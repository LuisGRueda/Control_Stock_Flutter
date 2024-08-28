import 'dart:convert';
import 'package:control_stock/domain/entitites/factory.dart';
import 'package:dio/dio.dart';
import '../../../../domain/entitites/product.dart';
import 'factory_client_repository.dart';

class FactoryClient extends FactoryClientRepository {
  final String _endpoint = "http://codagoz.empresa.bo/almacenes/api/Entidad/";
  Dio dio = Dio();

  // Future<List<Factory>> searchFactory(String param) async {
  //   try {
  //     final response =
  //         await dio.get('${_endpoint}GetEntidadParam?paramText=$param');

  //     if (response.statusCode == 200) {
  //       final fabricas = (response.data as List<dynamic>)
  //           .map((fabricaJson) => Factory.fromJson(fabricaJson))
  //           .toList();
  //       return fabricas;
  //     } else {
  //       throw Exception('Error al obtener los productos.');
  //     }
  //   } catch (e) {
  //     throw Exception('Error al listar productos: $e');
  //   }
  // }

  Future<List<Map<String, dynamic>>> searchFactory(String param) async {
    final response =
        await dio.get('${_endpoint}GetEntidadParam?paramText=$param');
    final List<dynamic> datos = response.data['data'];
    final List<Map<String, dynamic>> filas = datos.map((data) {
      return {
        'nroDocumento': data['nroDocumento'],
        'nombre': data['nombre'],
        'descripcion': data['descripcion'],
        'id': data['id'],
      };
    }).toList();
    return filas;
  }

  @override
  // ignore: non_constant_identifier_names
  Future<bool> AddFactory(Product data) {
    // TODO: implement AddFactory
    throw UnimplementedError();
  }

  @override
  Future<Factory?> ModifyPFactory(int id, Factory data) {
    // TODO: implement ModifyPFactory
    throw UnimplementedError();
  }
}
