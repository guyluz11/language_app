import 'package:uuid/uuid.dart';

part 'package:word_link/infrastructure/random_id_repository.dart';

abstract class RandomIdController {
  static RandomIdController? _instance;

  static RandomIdController get instance => _instance ??= _RandomIdRepository();

  void init();

  String getUniqueId();
}
