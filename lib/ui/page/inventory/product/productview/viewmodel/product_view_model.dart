import 'package:control_stock/domain/entitites/product.dart';
import 'package:flutter/material.dart';
import 'package:control_stock/data/datasource/api/producto/product_client.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

ProductoClient api = ProductoClient();

class ProductViewModel {
  //LLAMANDO A LA FUNCION LISTAR PRODUCTOS DE LA API
  Future<List<Map<String, dynamic>>> obtenerProductos(String query) {
    Future<List<Map<String, dynamic>>> productos = api.listarProductos(query);
    return productos;
  }

//LLAMANDO A LA FUNCION ELIMINAR DE LA API
  DeleteProduct(int id) {
    return api.DeleteProduct(id);
  }
}
