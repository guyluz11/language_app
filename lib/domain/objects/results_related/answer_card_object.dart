import 'package:word_link/domain/controllers/controllers.dart';

/// Answer for card
class AnswerCardObject {
  AnswerCardObject({
    required this.correctAnswer,
    String? cardUniqueIdTemp,
  }) {
    uniqueId = cardUniqueIdTemp ??= RandomIdController.instance.getUniqueId();
  }

  // Factory method to create a CardsCollectionObject from JSON
  factory AnswerCardObject.fromJson(Map<String, dynamic> json) {
    return AnswerCardObject(
      cardUniqueIdTemp: json['uniqueId'] as String,
      correctAnswer: json['correctAnswer'] as bool,
    );
  }

  late String uniqueId;
  bool correctAnswer;

  // Method to convert a CardsCollectionObject to JSON
  Map<String, dynamic> toJson() {
    return {
      'uniqueId': uniqueId,
      'correctAnswer': correctAnswer,
    };
  }
}
