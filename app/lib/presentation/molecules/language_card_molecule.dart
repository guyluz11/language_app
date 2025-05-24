import 'package:flutter/material.dart';
import 'package:word_link/domain/controllers/language_controller.dart';
import 'package:word_link/presentation/organisms/detailed_card_organism.dart';

class LanguageCardMolecule extends StatelessWidget {
  const LanguageCardMolecule({
    required this.language, required this.onClick, super.key,
  });

  final LanguageEnum language;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: DetailedCardOrganism(
        titleText: language.displayName,
        subTitle: 'Practice your ${language.displayName} vocabulary',
        buttonText: 'Open',
        background: Image.network(
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
        customContent: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            language.gifUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
          ),
        ),
        onClick: onClick,
      ),
    );
  }
}
