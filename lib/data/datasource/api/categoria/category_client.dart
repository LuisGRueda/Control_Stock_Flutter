import 'dart:convert';
import 'package:control_stock/domain/entitites/category.dart';
import 'package:dio/dio.dart';
import '../../../../domain/entitites/product.dart';
import 'category_client_repository.dart';

class CategoryClient extends CategoryClientRepository {
  final String _endpoint = "http://codagoz.empresa.bo/almacenes/api/GenArbol/";
  Dio dio = Dio();

  Future<List<Map<String, dynamic>>> searchCategory(String param) async {
    final response =
        await dio.get('${_endpoint}BuscarGenCategoria?paramText=$param');
    final List<dynamic> categorias = response.data['data'];

    final List<Map<String, dynamic>> filas = categorias.map((categoria) {
      return {
        'id': categoria['id'],
        'padre': categoria['padre'],
        'nombre': categoria['nombre'],
        'ancestros': categoria['ancestros'] ?? [],
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
