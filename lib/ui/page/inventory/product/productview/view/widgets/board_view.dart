//TABLA DE LISTADO DE PRODUCTOS
import 'dart:async';
import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/inventory/product/productcrud/view/crudproduct_view.dart';
import 'package:control_stock/ui/page/inventory/product/productview/viewmodel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickalert/quickalert.dart';

ProductViewModel api = ProductViewModel();

class BoardProduct extends StatefulWidget {
  const BoardProduct({super.key});

  @override
  State<BoardProduct> createState() => _BoardProductState();
}

class _BoardProductState extends State<BoardProduct> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Map<String, dynamic>>> _searchFuture;
  late List<Map<String, dynamic>> _searchResults = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _searchFuture = api.obtenerProductos('s');
  }

  // ignore: unused_field
  final _dataController = StreamController<void>.broadcast();
  // ignore: non_constant_identifier_names
  AppColor StyleApp = AppColor();
  ProductViewModel prodmodel = ProductViewModel();
  Future<void> _performSearch(String query) async {
    setState(() {
      _searchFuture = api.obtenerProductos(query);
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
                        DataColumn(label: Text('Nombre')),
                        DataColumn(label: Text('Descripción')),
                        DataColumn(label: Text('Cantidad física')),
                        DataColumn(label: Text('Cantidad lógica')),
                        DataColumn(label: Text('Precio promedio')),
                        DataColumn(label: Text('Acciones')),
                      ],
                      rows: _searchResults.map((fila) {
                        return DataRow(
                          cells: [
                            DataCell(Text(fila['codigo'].toString())),
                            DataCell(Text(fila['nombre'].toString())),
                            DataCell(Text(fila['descripcion'].toString())),
                            DataCell(Text(fila['cantidadFisica'].toString())),
                            DataCell(Text(fila['cantidadLogica'].toString())),
                            DataCell(Text(fila['precioPromedio'].toString())),
                            DataCell(
                              Row(
                                children: [
                                  MyModalBottomProduct(
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
                                        mostrarConfirmacionEliminacion(
                                            int.parse(fila['id'].toString()));
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
  void mostrarConfirmacionEliminacion(int id) {
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
  }

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
            SizedBox(
              height: 35,
              child: TextField(
                controller: _searchController,
                decoration: StyleApp.StyleInputText(context, 'Buscar'),
                onChanged: (value) {
                  _performSearch(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
