import 'package:control_stock/domain/entitites/model.dart';
import 'package:dio/dio.dart';
import 'model_client_repository.dart';

class ModelClient extends ModelClientRepository {
  final String _endpoint =
      "http://codagoz.empresa.bo/almacenes/api/GenClasificador/GetGenClasificador/";
  Dio dio = Dio();
  Future<List<Map<String, dynamic>>> listModel() async {
    final dio = Dio();
    final response = await dio.get('${_endpoint}10000040000');
    final List<dynamic> datos = response.data['data'];

    final List<Map<String, dynamic>> filas = datos.map((dato) {
      return {
        'id': dato['id'],
        'esSelected': dato['esSelected'],
        'clasificadorId': dato['clasificadorId'],
        'nombre': dato['nombre'],
        'codigo': dato['codigo'],
        'descripcion': dato['descripcion'],
      };
    }).toList();

    return filas;
  }

  @override
  Future<bool> AddModel(Model data) {
    // TODO: implement AddModel
    throw UnimplementedError();
  }

  @override
  Future<Model?> ModifyPModel(int id, Model data) {
    // TODO: implement ModifyPModel
    throw UnimplementedError();
  }
}
