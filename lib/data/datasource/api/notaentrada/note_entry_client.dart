import 'dart:convert';
import 'package:dio/dio.dart';
import 'note_entry_client_repository.dart';

class NoteEntryClient extends NoteEntryClientRepository {
  final String _endpoint =
      "http://codagoz.empresa.bo/almacenes/api/AlmacenEntradaSalida/";
  Dio dio = Dio();

  Future<List<Map<String, dynamic>>> listarNotasEntrada(String param) async {
    final response = await dio.get(
        '${_endpoint}BuscarNotasEntradaSalidaParam?paramText=root&estadosId=60000002001&estadosId=60000002001&tipoDocId=60000003001');
    final List<dynamic> datos = response.data['data'];

    final List<Map<String, dynamic>> filas = datos.map((dato) {
      return {
        'id': dato['id'],
        'fechaNota': dato['fechaNota'],
        'nroFactura': dato['nroFactura'],
        'proveedorDesc': dato['proveedorDesc'],
        'clienteRecpDesc': dato['clienteRecpDesc'],
        'destinatarioDesc': dato['destinatarioDesc'],
        'tipoDesc': dato['tipoDesc'],
        'tipoDocumentoDesc': dato['tipoDocumetoDesc']
      };
    }).toList();

    return filas;
  }

  @override
  // ignore: non_constant_identifier_names
  Future<bool> AgregarNotaEntrada(data) async {
    print(json.encode(data));
    dio.options.headers['Content-Type'] = 'application/json';
    Response response = await dio.post(
      "${_endpoint}SaveNotaEntradaSalida",
      data: json.encode(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> EditarNotaEntrada(data) async {
    print(json.encode(data));
    dio.options.headers['Content-Type'] = 'application/json';
    Response response = await dio.put(
      "${_endpoint}EditNotaEntradaSalida",
      data: json.encode(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> EliminarNotaEntrada(int id) async {
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
  Future<Map<String, dynamic>> NotaEntradaId(String id) async {
    try {
      final response =
          await dio.get('${_endpoint}GetNotaEntradaSalidaById/$id');
      print(response.data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }
}
