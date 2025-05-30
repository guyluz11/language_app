import 'package:llama_sdk/llama_sdk.dart';

part 'package:word_link/infrastructure/llm_repository.dart';

abstract class LlmController {
  static LlmController? _instance;

  static LlmController get instance => _instance ??= _LlmRepository();

  Future<void> init();

  Future<String> generateResponse(String prompt);
}
