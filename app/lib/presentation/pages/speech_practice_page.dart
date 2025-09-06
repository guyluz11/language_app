import 'package:flutter/material.dart';
import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/domain/objects/language_enum.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/molecules/molecules.dart';

class SpeechPracticePage extends StatefulWidget {
  const SpeechPracticePage({super.key});

  @override
  _SpeechPracticePageState createState() => _SpeechPracticePageState();
}

class _SpeechPracticePageState extends State<SpeechPracticePage> {
  final SpeechToTextController _speechToTextController =
      SpeechToTextController.instance;
  final TtsController _ttsController = TtsController.instance;
  String _translatedText = '';
  String _spokenText = '';
  bool _isProcessing = false;

  LanguageEnum _sourceLanguage = LanguageEnum.english;
  LanguageEnum _targetLanguage = LanguageEnum.polish;

  @override
  void initState() {
    super.initState();
    _speechToTextController.initialize();
    _ttsController.initialize();
    _speechToTextController.addListener(_onSpeechStateChanged);
    _ttsController.addListener(_onTtsStateChanged);
    _startListening(fromInit: true);
  }

  @override
  void dispose() {
    _speechToTextController.removeListener(_onSpeechStateChanged);
    _ttsController.removeListener(_onTtsStateChanged);
    _ttsController.stop();
    super.dispose();
  }

  void _onSpeechStateChanged() {
    if (_speechToTextController.isDone && !_isProcessing) {
      _onSpeechEnd();
    }
    if (mounted) {
      setState(() {
        _spokenText = _speechToTextController.lastWords;
      });
    }
  }

  void _onTtsStateChanged() {
    if (!_ttsController.isSpeaking && _isProcessing) {
      _clearTextAndListen();
    }
  }

  void _swapLanguages() {
    setState(() {
      final temp = _sourceLanguage;
      _sourceLanguage = _targetLanguage;
      _targetLanguage = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageEnclosureMolecule(
      title: 'Speech Practice',
      topBarType: TopBarType.back,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextAtom('Say something in ${_sourceLanguage.displayName}:'),
          TextAtom(_spokenText,
              style: Theme.of(context).textTheme.headlineMedium),
          const SeparatorAtom(),
          ButtonAtom(
            variant: ButtonVariant.highEmphasisFilled,
            onPressed: _speechToTextController.isListening
                ? () {}
                : () => _startListening(),
            text:
                _speechToTextController.isListening ? 'Listening...' : 'Speak',
            icon:
                _speechToTextController.isListening ? Icons.mic_off : Icons.mic,
          ),
          const SeparatorAtom(),
          if (_translatedText.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextAtom('In ${_targetLanguage.displayName}: '),
                TextAtom(
                  _translatedText,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            )
          else
            const SizedBox(height: 24),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLanguageButton('From', _sourceLanguage, (lang) {
                setState(() {
                  _sourceLanguage = lang;
                });
              }),
              IconButton(
                icon: const Icon(Icons.swap_horiz),
                onPressed: _swapLanguages,
                tooltip: 'Swap languages',
              ),
              _buildLanguageButton('To', _targetLanguage, (lang) {
                setState(() {
                  _targetLanguage = lang;
                });
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageButton(String label, LanguageEnum language,
      void Function(LanguageEnum) onSelected) {
    return Column(
      children: [
        TextAtom(label),
        const SizedBox(height: 8),
        ButtonAtom(
          variant: ButtonVariant.lowEmphasisText,
          onPressed: () => _showLanguagePicker(language, onSelected),
          text: language.displayName,
        ),
      ],
    );
  }

  void _showLanguagePicker(
      LanguageEnum currentLanguage, void Function(LanguageEnum) onSelected) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: LanguageEnum.values
              .map((lang) => ListTile(
                    title: Text(lang.displayName),
                    onTap: () {
                      onSelected(lang);
                      Navigator.of(context).pop();
                    },
                  ))
              .toList(),
        );
      },
    );
  }

  void _startListening({bool fromInit = false}) {
    if (!_speechToTextController.isListening) {
      _speechToTextController.startListening(localeId: _sourceLanguage.locale);
      if (!fromInit) {
        setState(() {});
      }
    }
  }

  Future _onSpeechEnd() async {
    final String recognizedWords = _speechToTextController.lastWords;
    if (recognizedWords.isNotEmpty) {
      _isProcessing = true;

      final String translated =
          await LanguageController.instance.translateText(
        _sourceLanguage.translateLanguage,
        _targetLanguage.translateLanguage,
        recognizedWords,
      );
      setState(() {
        _translatedText = translated;
      });
      await _ttsController.speak(translated, language: _targetLanguage.locale);
    }
  }

  void _clearTextAndListen() {
    if (mounted) {
      setState(() {
        _spokenText = '';
        _translatedText = '';
      });
    }
    _isProcessing = false;
    _startListening();
  }
}
