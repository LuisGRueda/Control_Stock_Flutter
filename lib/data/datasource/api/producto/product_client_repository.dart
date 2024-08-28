import 'package:control_stock/domain/entitites/product.dart';
import 'package:get/get.dart';

abstract class ProductClientRepository {
  Future<List<Product>> _searchProducts(String query);
  Future<List<Map<String, dynamic>>> buscarProductoNota(String query);
  Future<bool> AddProduct(data);
  Future<bool> ModifyProducto(data);
}
