import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../game_internals/score.dart';
import '../style/my_button.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class WinGameScreen extends StatelessWidget {
  final Score score;

  const WinGameScreen({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    const gap = SizedBox(height: 10);

    return Scaffold(
      backgroundColor: palette.backgroundPlaySession,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            gap,
            const Center(
              child: Text(
                'Final Score',
                style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 42),
              ),
            ),
            gap,
            Center(
              child: Text(
                score.items.where((element) => element.correct).length.toString(),
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 18),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: 4,
                  children: score.items
                      .map((o) => Text(
                            o.word,
                            style: TextStyle(
                                fontSize: 24,
                                color: o.correct ? null : Colors.red,
                                fontWeight: FontWeight.w500,
                                height: 1.2),
                            textAlign: TextAlign.center,
                          ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
        rectangularMenuArea: Column(
          children: [
            MyButton(
              onPressed: () {
                GoRouter.of(context)
                    .replace('/play/session/${score.category.name}', extra: score.items.map((e) => e.word).toList());
              },
              child: const Text('Play Again'),
            ),
            MyButton(
              onPressed: () {
                GoRouter.of(context).go('/play');
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
