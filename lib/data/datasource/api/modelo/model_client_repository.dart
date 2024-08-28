import 'package:control_stock/domain/entitites/factory.dart';
import 'package:control_stock/domain/entitites/model.dart';
import 'package:control_stock/domain/entitites/product.dart';

abstract class ModelClientRepository {
  Future<List<Map<String, dynamic>>> listModel();
  Future<bool> AddModel(Model data);
  Future<Model?> ModifyPModel(int id, Model data);
}
