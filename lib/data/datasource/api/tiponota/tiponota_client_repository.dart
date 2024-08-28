import 'package:control_stock/domain/entitites/product.dart';
import 'package:control_stock/domain/entitites/productType.dart';

abstract class TipoNotaClientRepository {
  Future<List<Map<String, dynamic>>> listTipoNota();
  Future<bool> AddCategory(ProductType data);
  Future<ProductType?> ModifyPCategory(int id, Product data);
}
