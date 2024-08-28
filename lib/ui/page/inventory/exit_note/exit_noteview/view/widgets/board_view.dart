import 'dart:async';
import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/inventory/exit_note/exit_notecrud/view/exit_notecrud_view.dart';
import 'package:flutter/material.dart';

class BoardExitNote extends StatefulWidget {
  const BoardExitNote({super.key});

  @override
  State<BoardExitNote> createState() => _BoardExitNoteState();
}

class _BoardExitNoteState extends State<BoardExitNote> {
  final _dataController = StreamController<void>.broadcast();
  List<Prod> datosTabla = List.empty(growable: true);
  AppColor StyleApp = AppColor();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: StyleApp.ColorContainer(context),
      child: StreamBuilder<void>(
          stream: _dataController.stream,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: _columns,
                rows: datosTabla.map((product) {
                  return DataRow(cells: [
                    DataCell(
                      TextField(
                        enabled: false,
                        controller: TextEditingController(text: product.Codigo),
                        onChanged: (value) {
                          setState(() {
                            product.Codigo = value;
                          });
                        },
                      ),
                    ),
                    DataCell(
                      TextField(
                        controller:
                            TextEditingController(text: product.Producto),
                        onChanged: (value) {
                          setState(() {
                            product.Producto = value;
                          });
                        },
                      ),
                    ),
                    DataCell(
                      TextField(
                        controller: TextEditingController(
                            text: product.Cantidad.toString()),
                        onChanged: (value) {
                          setState(() {
                            product.Cantidad = int.parse(value);
                            _dataController.add(null);
                          });
                        },
                      ),
                    ),
                    DataCell(
                      TextField(
                        controller: TextEditingController(
                            text: product.PrecioUnitario.toString()),
                        onChanged: (value) {
                          setState(() {
                            product.PrecioUnitario = double.parse(value);
                            _dataController.add(null);
                          });
                        },
                      ),
                    ),
                    DataCell(
                      TextField(
                        controller: TextEditingController(
                            text: (product.Cantidad * product.PrecioUnitario)
                                .toString()),
                        onChanged: (value) {
                          setState(() {
                            product.subtotal =
                                product.Cantidad * product.PrecioUnitario;
                          });
                        },
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              setState(() {
                                //MyModalBottomExitNote();
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        '¿Estás seguro de que deseas eliminar este elemento?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancelar'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Eliminar'),
                                        onPressed: () {
                                          setState(() {
                                            datosTabla.remove(product);
                                            _dataController.add(null);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            );
          }),
    );
  }
}

const List<DataColumn> _columns = [
  DataColumn(
    label: Text('Codigo'),
  ),
  DataColumn(
    label: Text('Producto'),
  ),
  DataColumn(
    label: Text('Cantidad'),
  ),
  DataColumn(
    label: Text('Precio Unitario'),
  ),
  DataColumn(
    label: Text('Sub Total'),
  ),
  DataColumn(
    label: Text('Acciones'),
  ),
];

class Prod {
  late String Codigo;
  late String Producto;
  late int Cantidad;
  late double PrecioUnitario;
  late double subtotal;
}
