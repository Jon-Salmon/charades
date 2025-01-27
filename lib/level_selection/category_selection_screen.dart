import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../how_to_play/how_to_play_dialog.dart';
import '../settings/settings.dart';
import '../style/palette.dart';
import 'category.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final settings = context.watch<SettingsController>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
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
                IconButton(
                    onPressed: () {
                      showHowToPlayDialog(context, fromHelp: true);
                    },
                    icon: Icon(Icons.help_outline_outlined, size: 36)),
              ],
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: AutoSizeText(
                  'Select category',
                  style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 40),
                  maxLines: 1,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: gameCategories.length,
                itemBuilder: (context, index) {
                  final data = gameCategories[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        if (!settings.hasSeenHowToPlay.value) {
                          await showHowToPlayDialog(context);
                          settings.setHasSeenHowToPlay();
                        }
                        if (context.mounted) {
                          GoRouter.of(context).go('/play/session/${data.name}');
                        }
                      },
                      child: Container(
                        color: palette.backgroundMain,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                data.icon,
                                size: 48,
                              ),
                              AutoSizeText(
                                data.name,
                                maxLines: 2,
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, height: 1.1),
                                wrapWords: false,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
