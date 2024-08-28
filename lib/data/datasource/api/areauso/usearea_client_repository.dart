import 'package:control_stock/domain/entitites/category.dart';
import 'package:control_stock/domain/entitites/product.dart';

abstract class UseAreaClientRepository {
  Future<List<Map<String, dynamic>>> searchUseArea();
  Future<bool> AddCategory(Product data);
  Future<Category?> ModifyPCategory(int id, Product data);
}
