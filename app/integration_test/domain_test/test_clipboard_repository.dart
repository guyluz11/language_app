import 'package:map_tube/domain/controllers/controllers.dart';

class TestClipboardRepository extends ClipboardController {
  TestClipboardRepository() {
    ClipboardController.instance = this;
  }

  @override
  Future<String?> getPaste() async => 'https://youtube.com/shorts/zfHTRMnqY5I';
}
