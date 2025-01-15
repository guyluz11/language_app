import 'package:word_link/domain/objects/json_helper_object.dart';
import 'package:word_link/domain/objects/results_releasted/answer_card_object.dart';

/// Answer to one collection
class AnswersCollectionObject implements JsonHelperObject {
  AnswersCollectionObject({
    required this.collectionUniqueId,
    List<AnswerCardObject> resultsTemp = const [],
  }) {
    _results = resultsTemp;
  }

  /// Factory method to create a `ResultsObject` from JSON
  factory AnswersCollectionObject.fromJson(Map<String, dynamic> json) {
    return AnswersCollectionObject(
      collectionUniqueId: json['collectionUniqueId'] as String,
      resultsTemp: (json['results'] as List<dynamic>)
          .map(
              (item) => AnswerCardObject.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  String collectionUniqueId;
  late List<AnswerCardObject> _results;

  /// Method to convert a `ResultsObject` to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'collectionUniqueId': collectionUniqueId,
      'results': _results.map((item) => item.toJson()).toList(),
    };
  }
}
