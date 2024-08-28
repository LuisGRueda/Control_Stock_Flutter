import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/person/viewmodel/person_view_model.dart';
import 'package:flutter/material.dart';
import '../../../../../domain/entitites/person.dart';

class PersonView extends StatefulWidget {
  const PersonView({super.key});
  @override
  State<PersonView> createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {
  AppColor styleapp = AppColor();
  PersonViewModel template = PersonViewModel();
  PersonViewModel prodmodel = PersonViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: StyleApp.ColorBackgroud(context),
        body: Column(
          children: [
            Expanded(
              flex: 0,
              child: Container(color: Colors.grey),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  children: [],
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          prodmodel.showModalPerson(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: const Text('Agregar'),
                      ),
                      Container(
                        color: Colors.white,
                        child: FutureBuilder<List<Person>>(
                          future: Future.value(prodmodel.obtenerPersons()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text("Error al cargar las personas");
                            } else {
                              List<Person>? productos = snapshot.data;
                              return DataTable(
                                columns: const [
                                  DataColumn(label: Text("Nombre")),
                                  DataColumn(label: Text("Descripción")),
                                  DataColumn(label: Text("Precio")),
                                ],
                                rows: productos!.map((producto) {
                                  return DataRow(cells: [
                                    DataCell(Text(producto.name)),
                                    DataCell(Text(producto.model)),
                                    DataCell(Text(
                                        "\$${producto.stock.toStringAsFixed(2)}")),
                                  ]);
                                }).toList(),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
