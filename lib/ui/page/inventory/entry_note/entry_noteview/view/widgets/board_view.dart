//TABLA DE LISTADO DE PRODUCTOS
import 'dart:async';
import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/inventory/entry_note/entry_notecrud/view/crudentrynote_view.dart';
import 'package:control_stock/ui/page/inventory/entry_note/entry_noteview/viewmodel/entrynote_view_model.dart';
import 'package:flutter/material.dart';

EntryNoteViewModel api = EntryNoteViewModel();

class BoardEntryNote extends StatefulWidget {
  const BoardEntryNote({super.key});

  @override
  State<BoardEntryNote> createState() => _BoardEntryNoteState();
}

class _BoardEntryNoteState extends State<BoardEntryNote> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Map<String, dynamic>>> _searchFuture;
  late List<Map<String, dynamic>> _searchResults = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchFuture = api.listNotaEntrada('s');
  }

  // ignore: unused_field
  final _dataController = StreamController<void>.broadcast();
  // ignore: non_constant_identifier_names
  AppColor StyleApp = AppColor();
  Future<void> _performSearch(String query) async {
    setState(() {
      _searchFuture = api.listNotaEntrada(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buscador(context),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          padding: const EdgeInsets.all(10),
          color: StyleApp.ColorContainer(context),
          child: Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _searchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Ha ocurrido un error al cargar los datos.'),
                  );
                }
                _searchResults = snapshot.data ?? [];
                return GestureDetector(
                  onPanUpdate: (details) {
                    setState(() {
                      _scrollController.position.moveTo(
                          _scrollController.position.pixels - details.delta.dx);
                    });
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Código')),
                        DataColumn(label: Text('Fecha')),
                        DataColumn(label: Text('Proveedor')),
                        DataColumn(label: Text('Destinatario')),
                        DataColumn(label: Text('Acciones')),
                      ],
                      rows: _searchResults.map((fila) {
                        return DataRow(
                          cells: [
                            DataCell(Text(fila['id'].toString())),
                            DataCell(Text(fila['fechaNota'].toString())),
                            DataCell(Text(fila['proveedorDesc'].toString())),
                            DataCell(Text(fila['destinatarioDesc'].toString())),
                            DataCell(
                              Row(
                                children: [
                                  MyModalBottomEntryNote(
                                    fila['id'].toString(),
                                    onNewDataAdded: () {
                                      setState(() {});
                                    },
                                  ),
                                  const SizedBox(
                                      width:
                                          8.0), // Separación entre los botones
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        // mostrarConfirmacionEliminacion(
                                        //   int.parse(fila['id'].toString()));
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

//MODAL DE CONFIRMACION DE ELIMINACION
/*  void mostrarConfirmacionEliminacion(int id) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: 'Estas seguro de eliminar esta registro?',
      confirmBtnText: 'Si',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.red,
      onConfirmBtnTap: () {
        prodmodel.DeleteProduct(id).then((resultado) {
          String mensaje = resultado
              ? "El producto ha sido Eliminado correctamente."
              : "Ha ocurrido un error al intentar agregar el producto.";
          Fluttertoast.showToast(
              msg: mensaje,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP_RIGHT,
              timeInSecForIosWeb: 3,
              backgroundColor: resultado ? Colors.green : Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          _performSearch("");
          Navigator.pop(context);
        });
      },
    );
  }*/

// BARRA BUSCADORA DE PRODUCTOS
  Container buscador(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: StyleApp.ColorContainer(context),
      ),
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 35,
                    child: TextField(
                      decoration: StyleApp.StyleInputText(context, 'Texto 1'),
                      onChanged: (value) {
                        // Manejar cambios en el primer TextField
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 35,
                    child: TextField(
                      decoration: StyleApp.StyleInputText(context, 'Texto 2'),
                      onChanged: (value) {
                        // Manejar cambios en el segundo TextField
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 35,
                    child: TextField(
                      controller: _searchController,
                      decoration: StyleApp.StyleInputText(context, 'Buscar'),
                      onChanged: (value) {
                        _performSearch(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container seleccion() {
    String _selectedOption = 'Activo';
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: StyleApp.ColorContainer(context),
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 35,
              child: DropdownButton<String>(
                value: _selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue!;
                  });
                },
                items: <String>['Activo', 'Inactivo']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
