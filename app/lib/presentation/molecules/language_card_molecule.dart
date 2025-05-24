import 'package:flutter/material.dart';
import 'package:word_link/domain/controllers/language_controller.dart';
import 'package:word_link/presentation/organisms/detailed_card_organism.dart';

class LanguageCardMolecule extends StatelessWidget {
  const LanguageCardMolecule({
    super.key,
    required this.language,
    required this.onClick,
  });

  final LanguageEnum language;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Stack(
        children: [
          DetailedCardOrganism(
            titleText: language.displayName,
            subTitle: 'Practice your ${language.displayName} vocabulary',
            buttonText: 'Open',
            background: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    language.flagUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.error_outline, size: 50),
                        ),
                      );
                    },
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            customContent: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  language.gifUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
            onClick: onClick,
          ),
        ],
      ),
    );
  }
}
