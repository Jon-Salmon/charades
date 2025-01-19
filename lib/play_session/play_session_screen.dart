import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:basic/audio/audio_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:simple_fsm/simple_fsm.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../audio/sounds.dart';
import '../game_internals/score.dart';
import '../level_selection/category.dart';
import '../style/palette.dart';

enum GameState { initial, playing, passed, skipped, holdVertical }

enum GameEvent { pass, skip, timer, righted }

class GameScreen extends StatefulWidget {
  final GameCategory category;
  final List<String>? previouslyUsedWords;

  const GameScreen(this.category, this.previouslyUsedWords, {super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _currentWordIndex = 0;

  List<String> _wordsAll = [];
  List<String> _words = [];

  late final FSM<GameState, GameEvent> fsm;

  late final StreamSubscription _accelSub;
  late final StreamSubscription _endSub;

  late final Score _score;

  bool isVertical = false;

  final stopwatch = StopWatchTimer(mode: StopWatchMode.countDown);

  @override
  void initState() {
    WakelockPlus.enable();

    _score = Score(widget.category);

    widget.category.loadWords().then((value) {
      _wordsAll = List.from(value);

      _words = List.from(_wordsAll);
      if (widget.previouslyUsedWords != null) {
        _words.removeWhere((element) => widget.previouslyUsedWords!.contains(element));
      }

      _words.shuffle();
    });

    fsm = FSM(initialState: GameState.initial, transitions: {
      GameState.initial: [
        Tx(GameState.playing, GameEvent.timer),
      ],
      GameState.playing: [
        Tx(GameState.skipped, GameEvent.skip),
        Tx(GameState.passed, GameEvent.pass),
      ],
      GameState.skipped: [
        Tx(GameState.playing, GameEvent.timer, guard: () => isVertical),
        Tx(GameState.holdVertical, GameEvent.timer),
      ],
      GameState.passed: [
        Tx(GameState.playing, GameEvent.timer, guard: () => isVertical),
        Tx(GameState.holdVertical, GameEvent.timer),
      ],
      GameState.holdVertical: [
        Tx(GameState.playing, GameEvent.righted),
      ],
    }, onEnter: {
      GameState.skipped: () {
        _nextWord(false);
        Timer(const Duration(milliseconds: 1000), () => fsm.fire(GameEvent.timer));
        stopwatch.onStopTimer();
      },
      GameState.passed: () {
        _nextWord(true);
        Timer(const Duration(milliseconds: 1000), () => fsm.fire(GameEvent.timer));
        stopwatch.onStopTimer();
      },
    }, onExit: {
      GameState.initial: () {
        stopwatch.setPresetSecondTime(60);
        stopwatch.onStartTimer();
      },
      GameState.passed: () => stopwatch.onStartTimer(),
      GameState.skipped: () => stopwatch.onStartTimer(),
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    // Start timer
    Timer(const Duration(seconds: 5), () => fsm.fire(GameEvent.timer));
    stopwatch.setPresetSecondTime(6);
    stopwatch.onStartTimer();

    _accelSub = accelerometerEventStream().listen(
      (AccelerometerEvent event) {
        if (event.z > 6) {
          fsm.fire(GameEvent.skip);
        } else if (event.z < -6) {
          fsm.fire(GameEvent.pass);
        }

        final vertical = event.z.abs() < 3;
        if (vertical != isVertical) {
          isVertical = vertical;
          if (vertical) {
            fsm.fire(GameEvent.righted);
          }
        }
      },
      onError: (error) {
        // TODO: handle errors
        // Logic to handle error
        // Needed for Android in case sensor is not available
      },
      cancelOnError: true,
    );

    _endSub = stopwatch.fetchEnded.listen((value) {
      roundedEnded();
    });

    super.initState();
  }

  void roundedEnded() {
    context.read<AudioController>().playSfx(SfxType.woosh);

    _score.items.add(ScoreItem(_words[_currentWordIndex], false));
    if (mounted) {
      GoRouter.of(context).go('/play/won', extra: {'score': _score});
    }
  }

  @override
  void dispose() {
    WakelockPlus.disable();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    _accelSub.cancel();
    _endSub.cancel();

    stopwatch.dispose(); // Need to call dispose function.

    super.dispose();
  }

  void onSkipTimer() {
    fsm.fire(GameEvent.timer);
  }

  void _nextWord(bool guessedCorrectly) {
    final audioController = context.read<AudioController>();
    audioController.playSfx(guessedCorrectly ? SfxType.ping : SfxType.woosh);

    _score.items.add(ScoreItem(_words[_currentWordIndex], guessedCorrectly));

    if (_currentWordIndex >= _words.length - 1) {
      _currentWordIndex = -1;
      _words = List.from(_wordsAll);
      _words.shuffle();
    }

    setState(() {
      _currentWordIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return StreamBuilder<Object>(
      stream: fsm.onTransition,
      initialData: GameState.initial,
      builder: (context, snapshot) {
        final Color color;
        final String text;
        Color? textColor;
        switch (fsm.state) {
          case GameState.passed:
            color = Colors.green;
            text = "Correct";
            textColor = Colors.white;
            break;
          case GameState.skipped:
            color = Colors.red;
            textColor = Colors.white;
            text = "Pass";
            break;
          case GameState.initial:
            text = "Place on forehead";
            color = palette.backgroundPlaySession;
            break;
          case GameState.holdVertical:
            text = "Hold vertical";
            color = palette.backgroundPlaySession;
            break;
          case GameState.playing:
          default:
            text = _words[_currentWordIndex];
            color = palette.backgroundPlaySession;
            break;
        }

        return Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.black),
          ),
          child: Scaffold(
            backgroundColor: color,
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Stack(
                children: [
                  SafeArea(
                    child: Center(
                        child: AutoSizeText(
                      text,
                      wrapWords: false,
                      maxLines: 1,
                      style: TextStyle(fontSize: 120, fontWeight: FontWeight.bold, color: textColor),
                    )),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkResponse(
                            onTap: () => GoRouter.of(context).pop(),
                            child: Image.asset(
                              'assets/images/back.png',
                              semanticLabel: 'Back',
                            ),
                          ),
                          StreamBuilder<int>(
                              stream: stopwatch.secondTime,
                              builder: (context, snapshot) {
                                return Text(snapshot.data == 0 ? "" : snapshot.data.toString(),
                                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold));
                              }),
                          SizedBox(),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
