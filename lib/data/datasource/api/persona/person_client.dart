import 'package:control_stock/data/datasource/api/persona/person_client_repository.dart';
import 'package:dio/dio.dart';
import '../../../../domain/entitites/person.dart';

class PersonClient extends PersonClientRepository {
  final String _endpoint = "http:";
  Dio dio = Dio();
  @override
  Future<List<Person>> GetPerson() async {
    Response response = await dio.get(_endpoint);
    List<Person> Persons;
    if (response.statusCode == 200) {
      Persons = response.data;
      return Persons;
    }
    Persons = response.data;
    return Persons;
  }

  @override
  Future<bool> AddPerson(Person data) async {
    Response response = await dio.post(_endpoint, data: data);
    if (response.statusCode == 201) {
      Person PersonoCreado = response.data;
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<Person?> ModifyPerson(int id, Person data) async {
    Response response = await dio.put('$_endpoint/$id', data: data);

    if (response.statusCode == 200) {
      Person PersonoActualizado = response.data;
      return PersonoActualizado;
    } else {
      print(response.statusMessage);
      return null;
    }
  }
}
