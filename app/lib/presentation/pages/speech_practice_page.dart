import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:word_link/domain/controllers/controllers.dart';
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
  final List<String> _words = ['hello', 'world', 'flutter', 'dart'];
  String _currentWord = '';
  String _translatedText = '';

  @override
  void initState() {
    super.initState();
    _speechToTextController.initialize();
    _getRandomWord();
  }

  void _getRandomWord() {
    _words.shuffle();
    setState(() {
      _currentWord = _words.first;
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
          const TextAtom('Say the word:'),
          TextAtom(_currentWord,
              style: Theme.of(context).textTheme.headlineMedium),
          const SeparatorAtom(),
          ButtonAtom(
            variant: ButtonVariant.highEmphasisFilled,
            onPressed: _speechToTextController.isListening
                ? _stopListening
                : _startListening,
            text: _speechToTextController.isListening ? 'Stop' : 'Speak',
            icon:
                _speechToTextController.isListening ? Icons.mic_off : Icons.mic,
          ),
          const SeparatorAtom(),
          if (_speechToTextController.lastWords.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextAtom('You said: '),
                TextAtom(_speechToTextController.lastWords,
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          if (_translatedText.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextAtom('In Polish: '),
                TextAtom(_translatedText,
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            )
          else
            const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _startListening() {
    _speechToTextController.startListening();
    _speechToTextController.addListener(_processSpeech);
    setState(() {});
  }

  void _stopListening() {
    _speechToTextController.stopListening();
    _speechToTextController.removeListener(_processSpeech);
    _checkAnswer();
    setState(() {});
  }

  void _processSpeech() {
    if (mounted) {
      setState(() {});
    }
  }

  void _checkAnswer() async {
    final String recognizedWords = _speechToTextController.lastWords;
    final String correctAnswer = _currentWord;

    if (recognizedWords.isNotEmpty) {
      final String translated = await LanguageController.instance.translateText(
        TranslateLanguage.english,
        TranslateLanguage.polish,
        recognizedWords,
      );
      setState(() {
        _translatedText = translated;
      });
    }

    if (recognizedWords.toLowerCase() == correctAnswer.toLowerCase()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Correct!'),
          content: Text('You said: $recognizedWords'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _getRandomWord();
              },
              child: const Text('Next'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Incorrect'),
          content: Text(
              'You said: $recognizedWords\nCorrect answer: $correctAnswer'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }
  }
}
