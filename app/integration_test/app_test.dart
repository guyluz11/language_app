import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:word_link/infrastructure/core/logger.dart';
import 'package:word_link/main.dart' as app;
import 'package:word_link/presentation/atoms/atoms.dart';
import 'package:word_link/presentation/core/global_variables.dart';
import 'package:word_link/presentation/pages/pages.dart';

import 'domain_test/test_preferences_repository.dart';

void main() {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Define a method to take screenshots
  Future<void> takeScreenshot(String screenshotName) async {
    if (Platform.isLinux) {
      logger.i('Screenshot not supported on linux');
      return;
    }

    final Directory path = Directory('/tmp/${GlobalVariables.appNameForFolders }_screenshots');
    if (!path.existsSync()) {
      path.createSync(recursive: true);
    }

    final file = File('${path.path}/$screenshotName.png');
    final List<int> bytes = await binding.takeScreenshot(screenshotName);
    await file.writeAsBytes(bytes);
    logger.i('Screenshot saved: ${file.path}');
  }

  testWidgets('Navigate and take screenshots', (WidgetTester tester) async {
    TestPreferencesRepository();
    app.main(debugBanner: false);

    /// Welcome page
    await tester.pumpAndSettle();
    await tester.pump(WelcomePage.startRenderNextButton);
    await tester.pump(WelcomePage.nextButtonDurationTillVisible);
    await tester.pump(WelcomePage.showSubTitleDuration);
    await tester.pump(const Duration(seconds: 30));
    await tester.pumpAndSettle();

    takeScreenshot('1_welcome_page');

    Finder nextButtonFinder = find.widgetWithText(ButtonAtom, 'Next');
    expect(nextButtonFinder, findsOneWidget);
    await tester.tap(nextButtonFinder);

    /// Initializing app page
    await tester.pumpAndSettle();

    /// Home page
    await tester.pumpAndSettle();
    takeScreenshot('2_home_page');
    nextButtonFinder = find.widgetWithText(ButtonAtom, 'Open');
    await tester.tap(nextButtonFinder);

    /// Practice Cards Page
    await tester.pumpAndSettle();
    takeScreenshot('3_practice_cards_page');
  });
}
