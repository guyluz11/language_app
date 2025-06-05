import 'package:flutter/material.dart';
import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/presentation/core/global_variables.dart';

class SelectLanguageCardOrganism extends StatelessWidget {
  const SelectLanguageCardOrganism({
    required this.language,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final LanguageEnum language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(GlobalVariables.defaultRadius),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: isSelected
              ? Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 3)
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(GlobalVariables.defaultRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                language.flagUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Theme.of(context).colorScheme.scrim,
                    ],
                  ),
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: GlobalVariables.defaultPadding,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 20,
                    ),
                  ),
                ),
              Positioned(
                bottom: 15,
                left: 15,
                right: 15,
                child: Text(
                  language.displayName,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
