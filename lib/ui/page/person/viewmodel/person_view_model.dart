import 'package:control_stock/ui/colors_view.dart';
import 'package:flutter/material.dart';

import '../../../../data/datasource/api/persona/person_client.dart';
import '../../../../domain/entitites/person.dart';

final _formKey = GlobalKey<FormState>();
String _PersonName = '';
int _PersonStock = 0;
double _PersonPrice = 0.0;
PersonClient api = PersonClient();
AppColor StyleApp = AppColor();

class PersonViewModel {
  void showModalPerson(BuildContext context, {Person? personToEdit}) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    Person Persono = personToEdit ??
        Person(
            brand: '', model: '', stock: 0, code: '', unitPrice: 0, name: '');
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: StyleApp.ColorBackgroud(context),
          height: MediaQuery.of(context).size.height * 0.8,
          margin: MediaQuery.of(context).size.width < 800
              ? const EdgeInsets.fromLTRB(60, 0, 60, 0)
              : const EdgeInsets.fromLTRB(120, 0, 120, 0),
          padding: MediaQuery.of(context).size.width < 800
              ? const EdgeInsets.all(25)
              : const EdgeInsets.all(50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(personToEdit == null
                    ? 'Agregar Persona'
                    : 'Editar Persona'),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: Persono.name,
                  decoration:
                      const InputDecoration(labelText: 'Nombre de la Persona'),
                  validator: (value) {
                    if (value == '') {
                      return 'Por favor, ingresa el nombre de la Persona';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    Persono.name = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: Persono.stock.toString(),
                  decoration:
                      const InputDecoration(labelText: 'Cantidad en stock'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == '') {
                      return 'Por favor, ingresa la cantidad en stock';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    Persono.stock = int.parse(value!);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: Persono.unitPrice.toString(),
                  decoration:
                      const InputDecoration(labelText: 'Precio unitario'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == '') {
                      return 'Por favor, ingresa el precio unitario';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    Persono.unitPrice = double.parse(value!);
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (personToEdit == null) {
                        Persono.code = "1";
                        Persono.brand = "515";
                        Persono.model = "555";
                        AddPersona(Persono);
                      } else {
                        EditPersona(Persono);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                      personToEdit == null ? 'Agregar' : 'Guardar cambios'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<Person>> obtenerPersons() {
    Future<List<Person>> persons = api.GetPerson() as Future<List<Person>>;
    return persons;
  }

  AddPersona(Person dato) {
    Future<bool> Persono = api.AddPerson(dato);
    return Persono;
  }

  EditPersona(Person dato) {}
}
