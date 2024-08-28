import 'dart:convert';

import 'package:control_stock/data/datasource/api/producto/product_client_repository.dart';
import 'package:dio/dio.dart';
import '../../../../domain/entitites/product.dart';

class ProductoClient extends ProductClientRepository {
  final String _endpoint = "http://codagoz.empresa.bo/almacenes/api/Produto/";
  Dio dio = Dio();
//
  Future<List<Map<String, dynamic>>> listarProductos(String param) async {
    final response = await dio
        .get('${_endpoint}BuscarProductoByVenta?param=sha&esServicio=false');
    final List<dynamic> datos = response.data['data'];

    final List<Map<String, dynamic>> filas = datos.map((dato) {
      return {
        'id': dato['id'],
        'codigo': dato['codigo'],
        'nombre': dato['nombre'],
        'descripcion': dato['descripcion'],
        'unidadMedida': dato['unidadMedidaDesc'],
        'cantidadFisica': dato['cantidadFisica'],
        'cantidadLogica': dato['cantidadLogica'],
        'precioPromedio': dato['precioPromedio'],
      };
    }).toList();

    return filas;
  }

  @override
  Future<List<Map<String, dynamic>>> buscarProductoNota(String query) async {
    final response = await dio.get(
        '${_endpoint}BuscarProductoByVenta?param=${query}&esServicio=false');
    final List<dynamic> datos = response.data['data'];

    final List<Map<String, dynamic>> filas = datos.map((dato) {
      return {
        'id': dato['id'],
        "nombre": dato['nombre'],
        "codigo": dato['codigo'],
        "cantidadLogica": dato['cantidadLogica'],
        "conVenc": dato['conVenc'],
        "precioPromedio": dato['precioPromedio'],
        "serie": dato['serie']
      };
    }).toList();

    return filas;
  }

  @override
  // ignore: non_constant_identifier_names
  Future<bool> AddProduct(data) async {
    print(json.encode(data));
    dio.options.headers['Content-Type'] = 'application/json';
    Response response = await dio.post(
      "${_endpoint}SaveProducto",
      data: json.encode(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> ModifyProducto(data) async {
    print(json.encode(data));
    dio.options.headers['Content-Type'] = 'application/json';
    Response response = await dio.put(
      "${_endpoint}EditProducto",
      data: json.encode(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> DeleteProduct(int id) async {
    try {
      Response response = await dio.delete('${_endpoint}EliminarProducto/$id');
      print(response.statusCode);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

//https://almacen-bkend.codagoz.com/api/Produto/GetProductoById/20
  Future<Map<String, dynamic>> fetchProduct(String id) async {
    try {
      print('gsfsdfsdf $id');
      final response = await dio.get('${_endpoint}GetProductoById/$id');
      print(response.data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }
}
