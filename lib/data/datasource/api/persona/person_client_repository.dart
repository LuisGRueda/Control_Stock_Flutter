
// ignore: file_names
import 'package:control_stock/domain/entitites/person.dart';

abstract class PersonClientRepository {
  Future<List<Person>> GetPerson();
  Future<bool> AddPerson(Person data);
  Future<Person?> ModifyPerson(int id, Person data);
}
