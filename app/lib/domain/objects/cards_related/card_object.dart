import 'package:word_link/domain/controllers/controllers.dart';

class CardObject {
  CardObject({
    this.name,
    this.secondaryName,
    this.answer,
    this.uniqueId = '-1',
    this.uri,
  }) {
    if (uniqueId == '-1') {
      uniqueId = RandomIdController.instance.getUniqueId();
    }
  }

  // Factory method to create a CardObject from JSON
  factory CardObject.fromJson(Map<String, dynamic> json) {
    return CardObject(
      name: json['name'] as String?,
      secondaryName: json['secondaryName'] as String?,
      answer: json['answer'] as String?,
      uniqueId: json['uniqueId'] as String,
    );
  }

  String? name;
  String? secondaryName;
  String? answer;
  late String uniqueId;
  Uri? uri;

  // Method to convert a CardObject to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'secondaryName': secondaryName,
      'answer': answer,
      'uniqueId': uniqueId,
    };
  }
}
