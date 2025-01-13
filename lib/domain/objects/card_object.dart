class CardObject {
  CardObject({
    this.name,
    this.secondaryName,
    this.answer,
  });

  // Factory method to create a CardObject from JSON
  factory CardObject.fromJson(Map<String, dynamic> json) {
    return CardObject(
      name: json['name'] as String?,
      secondaryName: json['secondaryName'] as String?,
      answer: json['answer'] as String?,
    );
  }

  String? name;
  String? secondaryName;
  String? answer;

  // Method to convert a CardObject to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'secondaryName': secondaryName,
      'answer': answer,
    };
  }
}
