part of 'package:word_link/domain/controllers/random_id_controller.dart';

class _RandomIdRepository extends RandomIdController {
  late Uuid uuid;

  @override
  void init() => uuid = const Uuid();

  @override
  String getUniqueId() => uuid.v4();
}
