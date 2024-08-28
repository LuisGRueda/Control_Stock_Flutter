import 'package:control_stock/domain/entitites/product.dart';
import 'package:control_stock/domain/entitites/productType.dart';

abstract class AlmacenClientRepository {
  Future<List<Map<String, dynamic>>> listAlmacen();
  Future<bool> AddCategory(ProductType data);
  Future<ProductType?> ModifyPCategory(int id, Product data);
}
