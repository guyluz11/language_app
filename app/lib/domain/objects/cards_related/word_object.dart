class WordObject {
  WordObject({
    required this.word,
    required this.hint,
    required this.url,
    this.translation,
  });

  String word;
  String hint;
  Uri? url;
  String? translation;
}
