import 'package:control_stock/domain/entitites/product.dart';
import 'package:control_stock/domain/entitites/productType.dart';

abstract class ProductTypeClientRepository {
  Future<List<Map<String, dynamic>>> listProdcutType();
  Future<bool> AddCategory(ProductType data);
  Future<ProductType?> ModifyPCategory(int id, Product data);
}
