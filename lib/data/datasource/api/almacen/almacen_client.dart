import 'package:control_stock/data/datasource/api/almacen/almacen_client_repository.dart';
import 'package:control_stock/domain/entitites/product.dart';
import 'package:control_stock/domain/entitites/productType.dart';
import 'package:dio/dio.dart';

class AlmacenClient extends AlmacenClientRepository {
  final String _endpoint =
      "http://codagoz.empresa.bo/almacenes/api/Almacen/GetAlmacenByTipo/60000001001/1";
  Dio dio = Dio();
  @override
  Future<List<Map<String, dynamic>>> listAlmacen() async {
    final dio = Dio();
    final response = await dio.get(_endpoint);
    final List<dynamic> datos = response.data['data'];

    final List<Map<String, dynamic>> filas = datos.map((dato) {
      return {
        'id': dato['id'],
        'nombre': dato['nombre'],
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
