part of 'package:word_link/domain/controllers/llm_controller.dart';

class _LlmRepository extends LlmController {
  late Llama _llama;

  @override
  Future<void> init() async {
    final controller = LlamaController(
      modelPath: 'assets/Qwen3-0.6B-Q8_0.gguf',
      nCtx: 2048,
      nBatch: 2048,
      greedy: true,
    );
    _llama = Llama(controller);
  }

  @override
  Future<String> generateResponse(String prompt) async {
    try {
      final messages = [UserLlamaMessage(prompt)];
      final response = await _llama.prompt(messages).first;
      return response;
    } catch (e) {
      return 'Error generating response: $e';
    }
  }
}
