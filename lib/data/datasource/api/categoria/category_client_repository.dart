import 'package:control_stock/domain/entitites/category.dart';
import 'package:control_stock/domain/entitites/product.dart';

abstract class CategoryClientRepository {
  Future<List<Category>> _searchCategory(String query);
  Future<bool> AddCategory(Product data);
  Future<Category?> ModifyPCategory(int id, Product data);
}
