import 'package:flutter/material.dart';
import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/presentation/molecules/molecules.dart';

class PickLanguagePage extends StatefulWidget {
  const PickLanguagePage({super.key});

  @override
  State<PickLanguagePage> createState() => _PickLanguagePageState();
}

class _PickLanguagePageState extends State<PickLanguagePage> {
  Set<LanguageEnum> selectedLanguages = {};

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguages();
  }

  Future<void> _loadSelectedLanguages() async {
    final savedLanguages = PreferencesController.instance
        .getStringList(PreferenceKeys.learningLanguage);
    if (savedLanguages != null) {
      setState(() {
        selectedLanguages = savedLanguages
            .map((lang) => LanguageEnum.fromString(lang))
            .where((lang) => lang != LanguageEnum.english)
            .toSet();
      });
    }
  }

  Future<void> _onLanguageSelected(LanguageEnum language) async {
    setState(() {
      if (selectedLanguages.contains(language)) {
        selectedLanguages.remove(language);
      } else {
        selectedLanguages.add(language);
      }
    });

    await PreferencesController.instance.setStringList(
      PreferenceKeys.learningLanguage,
      selectedLanguages.map((lang) => lang.name).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const availableLanguages = LanguageEnum.values;

    return PageEnclosureMolecule(
      title: 'Choose Languages',
      subTitle: 'Select the languages you want to learn',
      child: SizedBox(
        height: size.height * 0.8,
        width: size.width * 0.9,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selected: ${selectedLanguages.length} language${selectedLanguages.length != 1 ? 's' : ''}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                padding: const EdgeInsets.all(20),
                itemCount: availableLanguages.length,
                itemBuilder: (context, index) {
                  final language = availableLanguages[index];
                  final isSelected = selectedLanguages.contains(language);

                  return GestureDetector(
                    onTap: () => _onLanguageSelected(language),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(179),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        border: isSelected
                            ? Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 3,
                              )
                            : null,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              language.flagUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                );
                              },
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withAlpha(179),
                                  ],
                                ),
                              ),
                            ),
                            if (isSelected)
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
