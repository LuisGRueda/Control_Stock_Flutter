import 'package:control_stock/data/datasource/api/areauso/usearea_client_repository.dart';
import 'package:control_stock/domain/entitites/category.dart';
import 'package:dio/dio.dart';
import '../../../../domain/entitites/product.dart';

class UseAreaClient extends UseAreaClientRepository {
  final String _endpoint =
      "http://codagoz.empresa.bo/almacenes/api/GenClasificador/GetGenClasificador/10000030000";
  Dio dio = Dio();

  Future<List<Map<String, dynamic>>> searchUseArea() async {
    final dio = Dio();
    final response = await dio.get(_endpoint);
    final List<dynamic> datos = response.data['data'];

    final List<Map<String, dynamic>> filas = datos.map((dato) {
      return {
        'id': dato['id'],
        'codigo': dato['codigo'],
        'nombre': dato['nombre'],
        'descripcion': dato['descripcion'],
      };
    }).toList();

    return filas;
  }

  @override
  Future<bool> AddCategory(Product data) {
    // TODO: implement AddCategory
    throw UnimplementedError();
  }

  @override
  Future<Category?> ModifyPCategory(int id, Product data) {
    // TODO: implement ModifyPCategory
    throw UnimplementedError();
  }
}
