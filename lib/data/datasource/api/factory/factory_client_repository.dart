import 'package:control_stock/domain/entitites/factory.dart';
import 'package:control_stock/domain/entitites/product.dart';

abstract class FactoryClientRepository {
  Future<List<Factory>> _searchFactory(String query);
  Future<bool> AddFactory(Product data);
  Future<Factory?> ModifyPFactory(int id, Factory data);
}
