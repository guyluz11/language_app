import 'package:word_link/domain/controllers/controllers.dart';
import 'package:word_link/domain/objects/answers_related/answer_card_object.dart';
import 'package:word_link/domain/objects/json_helper_object.dart';

/// Stores one session of answering the questions of a collection
class AnswerCardsObject implements JsonHelperObject {
  AnswerCardsObject({
    String? uniqueIdTemp,
    List<AnswerCardObject> resultsTemp = const [],
  }) {
    _results = resultsTemp;
    {
      uniqueId = uniqueIdTemp ??= RandomIdController.instance.getUniqueId();
    }
  }

  /// Factory method to create a `ResultsObject` from JSON
  factory AnswerCardsObject.fromJson(Map<String, dynamic> json) {
    return AnswerCardsObject(
      uniqueIdTemp: json['uniqueId'] as String,
      resultsTemp: (json['results'] as List<dynamic>)
          .map(
            (item) => AnswerCardObject.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  late String uniqueId;
  late List<AnswerCardObject> _results;

  void addAnswer(AnswerCardObject answer) => _results.add(answer);

  List<AnswerCardObject> getAnswers() => _results;

  Iterable<AnswerCardObject> getCorrectAnswers() =>
      _results.where((answer) => answer.correctAnswer);

  Iterable<AnswerCardObject> getCorrectIncorrect() =>
      _results.where((answer) => !answer.correctAnswer);

  /// Method to convert a `ResultsObject` to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'uniqueId': uniqueId,
      'results': _results.map((item) => item.toJson()).toList(),
    };
  }
}
