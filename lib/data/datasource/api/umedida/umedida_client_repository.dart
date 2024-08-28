import 'package:control_stock/domain/entitites/product.dart';

abstract class UnidadMedidaClientRepository {
  Future<List<Map<String, dynamic>>> listarUnidadMedida(String query);
  Future<bool> AddProduct(Product data);
  Future<Product?> ModifyProducto(int id, Product data);
}
