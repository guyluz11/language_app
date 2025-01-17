import 'package:word_link/domain/objects/json_helper_object.dart';
import 'package:word_link/domain/objects/results_related/answer_cards_object.dart';

// Stores all of the the answers for one collection
class AnswersCollectionObject implements JsonHelperObject {
  AnswersCollectionObject({
    required this.uniqueId,
    List<AnswerCardsObject> resultsTemp = const [],
  }) {
    _results = resultsTemp;
  }

  /// Factory method to create a `ResultsObject` from JSON
  factory AnswersCollectionObject.fromJson(Map<String, dynamic> json) {
    return AnswersCollectionObject(
      uniqueId: json['collectionUniqueId'] as String,
      resultsTemp: (json['results'] as List<dynamic>)
          .map(
            (item) => AnswerCardsObject.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  String uniqueId;
  late List<AnswerCardsObject> _results;

  /// Method to convert a `ResultsObject` to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'collectionUniqueId': uniqueId,
      'results': _results.map((item) => item.toJson()).toList(),
    };
  }
}
