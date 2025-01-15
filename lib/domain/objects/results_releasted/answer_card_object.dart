/// Answer for card
class AnswerCardObject {
  AnswerCardObject({
    required this.cardUniqueId,
    required this.correctAnswer,
  });

  // Factory method to create a CardsCollectionObject from JSON
  factory AnswerCardObject.fromJson(Map<String, dynamic> json) {
    return AnswerCardObject(
      cardUniqueId: json['cardUniqueId'] as String,
      correctAnswer: json['correctAnswer'] as bool,
    );
  }

  String cardUniqueId;
  bool correctAnswer;

  // Method to convert a CardsCollectionObject to JSON
  Map<String, dynamic> toJson() {
    return {
      'cardUniqueId': cardUniqueId,
      'correctAnswer': correctAnswer,
    };
  }
}
