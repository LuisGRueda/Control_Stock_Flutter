import 'package:control_stock/data/datasource/api/umedida/umedida_client_repository.dart';
import 'package:dio/dio.dart';
import '../../../../domain/entitites/product.dart';

class UnidadMedidaClient extends UnidadMedidaClientRepository {
  final String _endpoint =
      "http://codagoz.empresa.bo/almacenes/api/GenUnidadMedida/";
  Dio dio = Dio();

  // Future<List<UnidadDeMedida>> listarUnidadMedida(param) async {
  //   final dio = Dio();
  //   try {
  //     final response =
  //         await dio.get('${_endpoint}BuscarUnidadMedida?paramText=${param}');

  //     if (response.statusCode == 200) {
  //       final unidadesDeMedida = (response.data as List<dynamic>)
  //           .map((unidadDeMedidaJson) =>
  //               UnidadDeMedida.fromJson(unidadDeMedidaJson))
  //           .toList();
  //       return unidadesDeMedida;
  //     } else {
  //       throw Exception('Error al obtener las unidades de medida.');
  //     }
  //   } catch (e) {
  //     throw Exception('Error al listar unidades de medida: $e');
  //   }
  // }
  Future<List<Map<String, dynamic>>> listarUnidadMedida(String param) async {
    final response =
        await dio.get('${_endpoint}BuscarUnidadMedida?paramText=${param}');
    final List<dynamic> unidades = response.data['data'];

    final List<Map<String, dynamic>> filas = unidades.map((unidad) {
      return {
        'id': unidad['id'],
        'nombre': unidad['nombre'],
        'categoriaId': unidad['categoriaId'],
        'factor': unidad['factor'],
        'redondeo': unidad['redondeo'],
        'activo': unidad['activo'] ?? true,
      };
    }).toList();

    return filas;
  }

  @override
  Future<bool> AddProduct(Product data) {
    throw UnimplementedError();
  }

  @override
  Future<Product?> ModifyProducto(int id, Product data) {
    throw UnimplementedError();
  }
}
