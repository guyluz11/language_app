import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/pages/pages.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final GlobalKey<IntroductionScreenState> _introKey =
      GlobalKey<IntroductionScreenState>();

  bool backButton = true;
  bool nextButton = true;
  bool isFinish = false;
  IntroState state = IntroState.welcomePage;

  void onIntroPageChange(int n) {
    state = IntroState.getStateByPageNumber(n);
    setState(() {
      nextButton = true;
      isFinish = n == IntroState.values.length - 1;
    });
  }

  void nextPage() => _introKey.currentState?.next();

  void onDone() {
    PreferencesController.instance
        .setBool(PreferenceKeys.finishedIntroduction, value: true);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  bool isPop = false;

  Future previousPage() async {
    if (state.pageNumber == 0 && !isPop) {
      isPop = true;
      Navigator.of(context).maybePop();
      return;
    }
    _introKey.currentState?.previous();
  }

  void onHorizontalDrag(DragEndDetails details) {
    if (details.primaryVelocity == 0) {
      return;
    } else if (details.primaryVelocity!.compareTo(0) == -1) {
      if (nextButton) {
        nextPage();
      }
      return;
    } else if (details.primaryVelocity!.compareTo(0) == 1) {
      previousPage();
    }
  }

  PageDecoration getPageDecoration() => const PageDecoration(
        pageMargin: EdgeInsets.zero,
        footerPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        contentMargin: EdgeInsets.only(bottom: 30),
      );

  PageViewModel customPageViewModel({required Widget bodyWidget}) =>
      PageViewModel(
        useScrollView: false,
        decoration: getPageDecoration(),
        bodyWidget: bodyWidget,
        titleWidget: const SizedBox(),
      );

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final ColorScheme colorScheme = themeData.colorScheme;

    return Scaffold(
      body: PopScope(
        canPop: state == IntroState.welcomePage,
        onPopInvokedWithResult: (bool a, b) => previousPage(),
        child: GestureDetector(
          onHorizontalDragEnd: onHorizontalDrag,
          child: IntroductionScreen(
            isProgressTap: false,
            key: _introKey,
            dotsDecorator: DotsDecorator(
              color: colorScheme.outlineVariant,
              activeColor: colorScheme.primary,
            ),
            overrideNext: Center(
              child: ButtonAtom(
                variant: ButtonVariant.lowEmphasisIcon,
                onPressed: nextButton ? nextPage : () {},
                icon: FontAwesomeIcons.arrowRight,
                disabled: !nextButton,
              ),
            ),
            overrideBack: Center(
              child: ButtonAtom(
                variant: ButtonVariant.lowEmphasisIcon,
                onPressed: previousPage,
                icon: FontAwesomeIcons.arrowLeft,
              ),
            ),
            overrideDone: Center(
              child: ButtonAtom(
                variant: ButtonVariant.highEmphasisFilled,
                onPressed: onDone,
                text: 'Skip',
              ),
            ),
            pages: [
              customPageViewModel(
                bodyWidget: WelcomePage(),
              ),
              customPageViewModel(
                bodyWidget: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextAtom('Explanation Page'),
                  ),
                ),
              ),
              customPageViewModel(
                bodyWidget: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextAtom('Choose a language page'),
                  ),
                ),
              ),
            ],
            showBackButton: backButton,
            back: const Icon(Icons.arrow_back),
            next: const Icon(Icons.arrow_forward),
            scrollPhysics: const NeverScrollableScrollPhysics(),
            onChange: onIntroPageChange,
            showDoneButton: isFinish,
            showNextButton: nextButton && !isFinish,
            onDone: onDone,
          ),
        ),
      ),
    );
  }
}

enum IntroState {
  welcomePage(0),
  newPage(1),
  homePage(2);

  const IntroState(this.pageNumber);

  final int pageNumber;

  static IntroState getStateByPageNumber(int number) {
    for (final IntroState state in IntroState.values) {
      if (state.pageNumber == number) {
        return state;
      }
    }
    return IntroState.welcomePage;
  }
}
