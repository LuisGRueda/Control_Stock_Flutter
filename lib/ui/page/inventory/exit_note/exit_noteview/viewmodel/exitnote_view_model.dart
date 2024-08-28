import 'package:control_stock/domain/entitites/product.dart';

import 'package:control_stock/data/datasource/api/producto/product_client.dart';

ProductoClient api = ProductoClient();

class ExitNoteViewModel {
  Future<List<Map<String, dynamic>>> obtenerProductos() {
    Future<List<Map<String, dynamic>>> productos = api.listarProductos("");
    return productos;
  }

  EditProducto(Product producto, String code) {}
}
