import 'package:control_stock/data/datasource/api/pruductType/productTtype_cliente_repository.dart';
import 'package:control_stock/domain/entitites/product.dart';
import 'package:control_stock/domain/entitites/productType.dart';
import 'package:dio/dio.dart';

class ProductTypeClient extends ProductTypeClientRepository {
  final String _endpoint =
      "http://codagoz.empresa.bo/almacenes/api/SisClasificador/GetSisClasificador/50000005000";
  Dio dio = Dio();
  @override
  // Future<List<ProductType>> listProdcutType() async {
  //   try {
  //     final response = await dio.get(_endpoint);

  //     if (response.statusCode == 200) {
  //       final productosTipos = (response.data as List<dynamic>)
  //           .map((productosTipoJson) => ProductType.fromJson(productosTipoJson))
  //           .toList();
  //       return productosTipos;
  //     } else {
  //       throw Exception('Error al obtener los productos.');
  //     }
  //   } catch (e) {
  //     throw Exception('Error al listar productos: $e');
  //   }
  // }
  Future<List<Map<String, dynamic>>> listProdcutType() async {
    final dio = Dio();
    final response = await dio.get(_endpoint);
    final List<dynamic> datos = response.data['data'];

    final List<Map<String, dynamic>> filas = datos.map((dato) {
      return {
        'id': dato['id'],
        'nombre': dato['nombre'],
        'descripcion': dato['descripcion'],
        'codigo': dato['codigo'],
      };
    }).toList();

    return filas;
  }

  @override
  Future<bool> AddCategory(ProductType data) {
    // TODO: implement AddCategory
    throw UnimplementedError();
  }

  @override
  Future<ProductType?> ModifyPCategory(int id, Product data) {
    // TODO: implement ModifyPCategory
    throw UnimplementedError();
  }
}
