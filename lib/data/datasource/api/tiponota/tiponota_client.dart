import 'package:control_stock/data/datasource/api/tiponota/tiponota_client_repository.dart';
import 'package:control_stock/domain/entitites/product.dart';
import 'package:control_stock/domain/entitites/productType.dart';
import 'package:dio/dio.dart';

class TipoNotaClient extends TipoNotaClientRepository {
  final String _endpoint =
      "http://codagoz.empresa.bo/almacenes/api/SisClasificador/GetSisClasificador/60000004000";
  Dio dio = Dio();
  @override
  Future<List<Map<String, dynamic>>> listTipoNota() async {
    final dio = Dio();
    final response = await dio.get(_endpoint);
    final List<dynamic> datos = response.data['data'];

    final List<Map<String, dynamic>> filas = datos.map((dato) {
      return {
        'id': dato['id'],
        'nombre': dato['nombre'],
        'descripcion': dato['descripcion'],
        'codigo': dato['codigo'],
        'activo': dato['activo'],
        'sisClasificadorId': dato['sisClasificadorId'],
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
