import 'package:word_link/domain/controllers/controllers.dart';

/// Answer for card
class AnswerCardObject {
  AnswerCardObject({
    required this.correctAnswer,
    required this.cardUniqueId,
    String? answerUniqueIdTemp,
  }) {
    answerUniqueId =
        answerUniqueIdTemp ??= RandomIdController.instance.getUniqueId();
  }

  // Factory method to create a CardsCollectionObject from JSON
  factory AnswerCardObject.fromJson(Map<String, dynamic> json) {
    return AnswerCardObject(
      cardUniqueId: json['cardUniqueId'] as String,
      answerUniqueIdTemp: json['answerUniqueId'] as String,
      correctAnswer: json['correctAnswer'] as bool,
    );
  }

  String cardUniqueId;
  late String answerUniqueId;
  bool correctAnswer;

  // Method to convert a CardsCollectionObject to JSON
  Map<String, dynamic> toJson() {
    return {
      'cardUniqueId': cardUniqueId,
      'answerUniqueId': answerUniqueId,
      'correctAnswer': correctAnswer,
    };
  }
}
