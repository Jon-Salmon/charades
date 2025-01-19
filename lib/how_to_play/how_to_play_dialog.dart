import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../style/palette.dart';

Future showHowToPlayDialog(BuildContext context, {bool fromHelp = false}) async {
  await showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => HowToPlayDialog(fromHelp: fromHelp),
  );
}

class HowToPlayDialog extends StatelessWidget {
  final bool fromHelp;

  const HowToPlayDialog({super.key, required this.fromHelp});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return AlertDialog(
      backgroundColor: palette.backgroundSettings,
      title: Text(
        'How to play',
        style: TextStyle(fontFamily: "Permanent Marker", fontSize: 30, color: palette.ink),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(fromHelp ? 'Ok' : 'Play',
              style: TextStyle(fontFamily: "Permanent Marker", fontSize: 20, color: palette.ink)),
        ),
      ],
      content: SingleChildScrollView(
        child: Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.apply(bodyColor: palette.ink, fontSizeFactor: 1.1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                  leading: Transform.rotate(angle: pi / 2, child: const Icon(Icons.phone_android_sharp)),
                  title: const Text('Hold phone landscape facing the describing team.')),
              ListTile(
                  leading: const Icon(Icons.check),
                  title: const Text('Twist phone downwards after guessing correctly.')),
              ListTile(leading: const Icon(Icons.skip_next), title: const Text('Twist phone upwards to skip.')),
            ],
          ),
        ),
      ),
    );
  }
}
