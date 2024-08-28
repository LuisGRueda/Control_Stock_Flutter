// ignore_for_file: unrelated_type_equality_checks, non_constant_identifier_names, unused_local_variable
import 'dart:async';
import 'package:control_stock/domain/entitites/category.dart';
import 'package:control_stock/domain/entitites/factory.dart';
import 'package:control_stock/domain/entitites/product.dart';
import 'package:control_stock/domain/entitites/umedida.dart';
import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/inventory/entry_note/entry_notecrud/viewmodel/crudentrynote_view_model.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:control_stock/domain/entitites/EntryNote.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

CrudEntryNoteViewModel api = CrudEntryNoteViewModel();
String idENTRY = "";

class MyModalBottomEntryNote extends StatefulWidget {
  final Function() onNewDataAdded;
  const MyModalBottomEntryNote(this.idEntryNoteo,
      {Key? key, required this.onNewDataAdded})
      : super(key: key);
  final String? idEntryNoteo;
  @override
  // ignore: library_private_types_in_public_api
  _MyModalBottomEntryNoteState createState() => _MyModalBottomEntryNoteState();
}

bool isChecked = false;

class _MyModalBottomEntryNoteState extends State<MyModalBottomEntryNote> {
  final TextEditingController _searchController = TextEditingController();
  late Future<List<Map<String, dynamic>>> _searchFuture;
  late List<Map<String, dynamic>> _searchResults = [];
  final ScrollController _scrollController = ScrollController();
  bool _isSelected = false;
  late Future<List<NotaEntrada>> datos;
  late Future<List<UnidadDeMedida>> datosMedida;
  late Future<List<Category>> datosCategoria;
  late Future<List<Factory>> datosFabricas;
  // ignore: unused_field
  final _dataController = StreamController<void>.broadcast();
  AppColor StyleApp = AppColor();
  Future<void> _performSearch(String query) async {
    setState(() {
      _searchFuture = api.buscarProductoNota(query);
    });
  }

  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  final List<DataColumn> columns = [
    const DataColumn(
      label: Text(
        'Codigo',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Producto',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Cantidad',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Precio Unitario',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Sub Total',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    DataColumn(
      label: Text(
        'Acciones',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  ];
  Future<void> openModalBottomSheet(String? idEntryNote) async {
    List<Product> datosTabla = List.empty(growable: true);
    bool modoEdit = false;
    String idx = '';

    int id = 0;
    DateTime fechanota = DateTime.now();
    int tiponotaentrada = 0;
    int almacen = 0;
    int almacenorigen = 0;
    DateTime fechafactura = DateTime.now();
    String nrofactura = '';
    String ordencompra = '';
    int fabricante = 0;
    int modelo = 0;
    String serie = '';
    bool borrado = false;
    final dataController = StreamController<void>.broadcast();
    final format = DateFormat("yyyy-MM-dd");
    //COMPROBAR SI ES EDICION
    if (idEntryNote != null) {
      modoEdit = true;
      idx = idEntryNote;
      try {
        final notaentrada = await api.NotaEntradaId(idx);
        setState(() {
          id = notaentrada['data']['id'];
          fechanota = notaentrada['data']['codigo'];
          tiponotaentrada = notaentrada['data']['nombre'];
          almacen = notaentrada['data']['descripcion'];
          almacenorigen = notaentrada['data']['motivoCambio'];
          fechafactura = notaentrada['data']['categoriaId'];
          nrofactura = notaentrada['data']['unidadMedidaId'];
          ordencompra = notaentrada['data']['EntryNoteoTipoId'];
          fabricante = notaentrada['data']['fabricanteId'];
          modelo = notaentrada['data']['modeloId'];
          serie = notaentrada['data']['serie'];
        });
      } catch (e) {
        print('Error al cargar el EntryNoteo: $e');
      }
    }
    //END COMPROBAR SI ES EDICION

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: StyleApp.ColorContainer(context),
          ),
          height: MediaQuery.of(context).size.height * 1,
          margin: MediaQuery.of(context).size.width < 800
              ? const EdgeInsets.fromLTRB(60, 0, 60, 0)
              : const EdgeInsets.fromLTRB(180, 0, 180, 0),
          padding: MediaQuery.of(context).size.width < 800
              ? const EdgeInsets.all(25)
              : const EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 0,
                    child: SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                modoEdit == false
                                    ? 'Agregar Nota de Entrada'
                                    : 'Editar Nota de Entrada',
                                style: StyleApp.StyleText(context)),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (true == true) {
                                        final EntryNoteo = {
                                          "id": id,
                                          "nombre": tiponotaentrada,
                                          "codigo": fechanota,
                                          "descripcion": almacen,
                                          "motivoCambio": almacenorigen,
                                          "categoriaId": fechafactura,
                                          "unidadMedidaId": nrofactura,
                                          "EntryNoteoTipoId": ordencompra,
                                          "borrado": false,
                                          "areaUso": [1],
                                          "fabricanteId": fabricante,
                                          "modeloId": modelo,
                                          "serie": serie,
                                        };

                                        //VERIFICACION DE ID PARA EDITORAR O AGREGAR
                                        final apiMethod = modoEdit == false
                                            ? api.AddNotaEntrada
                                            : api.EditNotaEntrada;
                                        final successMessage = idEntryNote ==
                                                null
                                            ? "El EntryNoteo ha sido agregado correctamente."
                                            : "El EntryNoteo ha sido modificado correctamente.";
                                        final errorMessage = idEntryNote == null
                                            ? "Ha ocurrido un error al intentar agregar el EntryNoteo."
                                            : "Ha ocurrido un error al intentar modificar el EntryNoteo.";

                                        apiMethod(EntryNoteo).then((resultado) {
                                          final mensaje = resultado
                                              ? successMessage
                                              : errorMessage;

                                          Fluttertoast.showToast(
                                            msg: mensaje,
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.TOP_RIGHT,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: resultado
                                                ? Colors.green
                                                : Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                          widget.onNewDataAdded();
                                          Navigator.of(context).pop();
                                        });
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "El formulario no está completo",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP_RIGHT,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      }
                                    }
                                  },
                                  child: Text(modoEdit == false
                                      ? 'Agregar'
                                      : 'Guardar cambios'),
                                ),
                                const SizedBox(width: 16),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color.fromARGB(200, 194, 196, 197),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            color: StyleApp.ColorContainer(context),
                            padding: const EdgeInsets.fromLTRB(40, 0, 16, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StyleApp.Separate16(),
                                SizedBox(
                                  height: 35,
                                  child: DateTimeField(
                                    initialValue: fechanota != DateTime.now()
                                        ? null
                                        : fechanota,
                                    decoration: InputDecoration(
                                      labelText: 'Fecha de Nota',
                                      labelStyle: const TextStyle(fontSize: 12),
                                      suffixIcon:
                                          const Icon(Icons.calendar_month),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    format: format,
                                    onShowPicker:
                                        (context, currentValue) async {
                                      return await showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100),
                                      );
                                    },
                                    validator: (value) {
                                      if (value == '') {
                                        return 'Por favor, ingresa una fecha';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      fechanota = value!;
                                    },
                                  ),
                                ),
                                StyleApp.Separate12(),
                                SizedBox(
                                  height: 35,
                                  child: FutureBuilder<
                                          List<Map<String, dynamic>>>(
                                      future: api.ListTipoNota(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (snapshot.hasError) {
                                          return const Center(
                                            child: Text(
                                                'Ha ocurrido un error al cargar los datos.'),
                                          );
                                        }
                                        final datos = snapshot.data!;
                                        return DropdownButtonFormField(
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Por favor, selecciona un tipo de Nota';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  StyleApp.ColorText(context)),
                                          hint: const Text('Tipo Nota Entrada'),
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                              vertical: 8.0,
                                            ),
                                          ),
                                          items: datos.map((fila) {
                                            return DropdownMenuItem(
                                              value: fila,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  fila['nombre'].toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            int? parsedValue = int.tryParse(
                                                value!['id'].toString());
                                            if (parsedValue != null) {
                                              tiponotaentrada = parsedValue;
                                            } else {
                                              // Manejar el caso en que el valor no se puede convertir a entero.
                                            }
                                          },
                                          isDense: true,
                                          isExpanded: true,
                                        );
                                      }),
                                ),
                                StyleApp.Separate12(),
                                SizedBox(
                                  height: 35,
                                  child: FutureBuilder<
                                          List<Map<String, dynamic>>>(
                                      future: api.ListAlmacen(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (snapshot.hasError) {
                                          return const Center(
                                            child: Text(
                                                'Ha ocurrido un error al cargar los datos.'),
                                          );
                                        }
                                        final datos = snapshot.data!;
                                        return DropdownButtonFormField(
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Por favor, selecciona un Almacen';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  StyleApp.ColorText(context)),
                                          hint: const Text('Almacen'),
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                              vertical: 8.0,
                                            ),
                                          ),
                                          items: datos.map((fila) {
                                            return DropdownMenuItem(
                                              value: fila,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  fila['nombre'].toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            int? parsedValue = int.tryParse(
                                                value!['id'].toString());
                                            if (parsedValue != null) {
                                              almacen = parsedValue;
                                            } else {
                                              // Manejar el caso en que el valor no se puede convertir a entero.
                                            }
                                          },
                                          isDense: true,
                                          isExpanded: true,
                                        );
                                      }),
                                ),
                                StyleApp.Separate12(),
                                SizedBox(
                                  height: 35,
                                  child: FutureBuilder<
                                          List<Map<String, dynamic>>>(
                                      future: api.ListAlmacen(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (snapshot.hasError) {
                                          return const Center(
                                            child: Text(
                                                'Ha ocurrido un error al cargar los datos.'),
                                          );
                                        }
                                        final datos = snapshot.data!;
                                        return DropdownButtonFormField(
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Por favor, selecciona un Almacen Origen';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  StyleApp.ColorText(context)),
                                          hint: const Text('Almacen Origen'),
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: const BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                              vertical: 8.0,
                                            ),
                                          ),
                                          items: datos.map((fila) {
                                            return DropdownMenuItem(
                                              value: fila,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  fila['nombre'].toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            int? parsedValue = int.tryParse(
                                                value!['id'].toString());
                                            if (parsedValue != null) {
                                              almacenorigen = parsedValue;
                                            } else {
                                              // Manejar el caso en que el valor no se puede convertir a entero.
                                            }
                                          },
                                          isDense: true,
                                          isExpanded: true,
                                        );
                                      }),
                                ),
                                StyleApp.Separate12(),
                                //
                                SizedBox(
                                  height: 35,
                                  child: Autocomplete<Producto>(
                                    optionsMaxHeight: 200,
                                    optionsBuilder: (TextEditingValue value) {
                                      if (value.text.isEmpty) {
                                        return List.empty();
                                      }
                                      return api
                                          .buscarProductoNota(value.text)
                                          .then((result) => result
                                              .map((item) =>
                                                  Producto.fromJson(item))
                                              .toList());
                                    },
                                    fieldViewBuilder: (BuildContext context,
                                            TextEditingController controller,
                                            FocusNode node,
                                            Function onSubmit) =>
                                        TextField(
                                      controller: controller,
                                      focusNode: node,
                                      decoration: InputDecoration(
                                        hintText: 'Producto',
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 8.0,
                                        ),
                                      ),
                                    ),
                                    optionsViewBuilder: (BuildContext context,
                                            Function onSelect,
                                            Iterable<Producto> options) =>
                                        Align(
                                      alignment: Alignment.topLeft,
                                      child: Material(
                                        child: Container(
                                          width: 300,
                                          color:
                                              StyleApp.ColorContainer(context),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: options.length,
                                            itemBuilder: (context, index) {
                                              Producto d =
                                                  options.elementAt(index);
                                              return InkWell(
                                                onTap: () => onSelect(d),
                                                child: ListTile(
                                                  title: Text(
                                                    d.nombre,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    onSelected: (value) {
                                      // categoria = value.id;
                                      //ValCategoria = true;
                                    },
                                    displayStringForOption: (Producto d) =>
                                        d.nombre,
                                  ),
                                ),
                                StyleApp.Separate12(),
                                SizedBox(
                                  height: 35,
                                  child: Autocomplete<Producto>(
                                    optionsMaxHeight: 200,
                                    optionsBuilder: (TextEditingValue value) {
                                      if (value.text.isEmpty) {
                                        return List.empty();
                                      }
                                      return api
                                          .buscarProductoNota(value.text)
                                          .then((result) => result
                                              .map((item) =>
                                                  Producto.fromJson(item))
                                              .toList());
                                    },
                                    fieldViewBuilder: (BuildContext context,
                                            TextEditingController controller,
                                            FocusNode node,
                                            Function onSubmit) =>
                                        TextField(
                                      controller: controller,
                                      focusNode: node,
                                      decoration: InputDecoration(
                                        hintText: 'Producto',
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 8.0,
                                        ),
                                      ),
                                    ),
                                    optionsViewBuilder: (BuildContext context,
                                            Function onSelect,
                                            Iterable<Producto> options) =>
                                        Align(
                                      alignment: Alignment.topLeft,
                                      child: Material(
                                        child: Container(
                                          width: 300,
                                          color:
                                              StyleApp.ColorContainer(context),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: options.length,
                                            itemBuilder: (context, index) {
                                              Producto d =
                                                  options.elementAt(index);
                                              return InkWell(
                                                onTap: () => onSelect(d),
                                                child: ListTile(
                                                  title: Text(
                                                    d.nombre,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    onSelected: (value) {
                                      // categoria = value.id;
                                      //ValCategoria = true;
                                    },
                                    displayStringForOption: (Producto d) =>
                                        d.nombre,
                                  ),
                                ), //BUSCADOR DE PRODUCTOS EN LA TABLA
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: StyleApp.ColorContainer(context),
                            padding: const EdgeInsets.fromLTRB(16, 0, 40, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StyleApp.Separate16(),
                                //DATETIME DE FECHA DE FACTURA
                                SizedBox(
                                  height: 35,
                                  child: DateTimeField(
                                    initialValue: fechafactura != DateTime.now()
                                        ? null
                                        : fechafactura,
                                    decoration: InputDecoration(
                                      labelText: 'Fecha de Factura',
                                      labelStyle: const TextStyle(fontSize: 12),
                                      suffixIcon:
                                          const Icon(Icons.calendar_month),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    format: format,
                                    onShowPicker:
                                        (context, currentValue) async {
                                      return await showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100),
                                      );
                                    },
                                    validator: (value) {
                                      if (value == '') {
                                        return 'Por favor, ingresa una fecha';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      fechafactura = value!;
                                    },
                                  ),
                                ),
                                StyleApp.Separate12(),
                                //INPUT DE NRO DE FACTURA
                                SizedBox(
                                  height: _isSelected ? 70 : 35,
                                  child: TextFormField(
                                    initialValue: nrofactura,
                                    decoration: StyleApp.StyleInputText(
                                        context, 'Nro Factura'),
                                    validator: (value) {
                                      if (value == '') {
                                        return 'Por favor, ingresa Numero de la factura';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        nrofactura = value;
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        _isSelected = true;
                                      });
                                    },
                                    onEditingComplete: () {
                                      setState(() {
                                        _isSelected = false;
                                      });
                                    },
                                  ),
                                ),
                                StyleApp.Separate12(),
                                //INPUT DE ORDEN DE COMPRA
                                SizedBox(
                                  height: _isSelected ? 70 : 35,
                                  child: TextFormField(
                                    initialValue: ordencompra,
                                    decoration: StyleApp.StyleInputText(
                                        context, 'Orden de Compra'),
                                    validator: (value) {
                                      if (value == '') {
                                        return 'Por favor, ingresa Orden de Compra';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        ordencompra = value;
                                      });
                                    },
                                    onTap: () {
                                      setState(() {
                                        _isSelected = true;
                                      });
                                    },
                                    onEditingComplete: () {
                                      setState(() {
                                        _isSelected = false;
                                      });
                                    },
                                  ),
                                ),
                                StyleApp.Separate12(),
                                //BUSCADOR DE PROVEEDOR
                                SizedBox(
                                  height: 35,
                                  child: Autocomplete<Factory>(
                                    optionsMaxHeight: 200,
                                    optionsBuilder: (TextEditingValue value) {
                                      if (value.text.isEmpty) {
                                        return List.empty();
                                      }
                                      return api
                                          .searchFactorys(value.text)
                                          .then((result) => result
                                              .map((item) =>
                                                  Factory.fromJson(item))
                                              .toList());
                                    },
                                    fieldViewBuilder: (BuildContext context,
                                            TextEditingController controller,
                                            FocusNode node,
                                            Function onSubmit) =>
                                        TextField(
                                      controller: controller,
                                      focusNode: node,
                                      decoration: InputDecoration(
                                        hintText: 'Proveedor',
                                        hintStyle:
                                            const TextStyle(fontSize: 12),
                                        prefixIcon: const Icon(Icons.search),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 8.0,
                                        ),
                                      ),
                                    ),
                                    optionsViewBuilder: (BuildContext context,
                                            Function onSelect,
                                            Iterable<Factory> options) =>
                                        Align(
                                      alignment: Alignment.topLeft,
                                      child: Material(
                                        child: Container(
                                          width: 300,
                                          color:
                                              StyleApp.ColorContainer(context),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: options.length,
                                            itemBuilder: (context, index) {
                                              Factory d =
                                                  options.elementAt(index);
                                              return InkWell(
                                                onTap: () => onSelect(d),
                                                child: ListTile(
                                                  title: Text(
                                                    d.nombre,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    onSelected: (value) {
                                      fabricante = value.id;
                                      // ValFabrica = true;
                                    },
                                    displayStringForOption: (Factory d) =>
                                        d.nombre,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //TABLA DE LISTADO DE PRODUCTOS NOTAS DE ENTRADAS
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                      color: StyleApp.ColorContainer(context),
                      child: StreamBuilder<void>(
                          stream: _dataController.stream,
                          builder: (context, snapshot) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SizedBox(
                                height: 500,
                                child: DataTable(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[300]!),
                                    ),
                                  ),
                                  headingRowHeight:
                                      60.0, // ajustar la altura de la fila de cabecera según lo que necesites
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.transparent),
                                  dataRowColor: MaterialStateColor.resolveWith(
                                      (states) =>
                                          StyleApp.ColorContainer(context)),
                                  columns: columns,
                                  rows: datosTabla.map((product) {
                                    TextEditingController controller =
                                        TextEditingController(
                                            //text: product.PrecioUnitario.toString(),
                                            );
                                    TextEditingController controller1 =
                                        TextEditingController(
                                            //text: product.Cantidad.toString(),
                                            );
                                    return DataRow(cells: [
                                      DataCell(
                                        TextField(
                                          enabled: false,
                                          controller: TextEditingController(
                                              /*text: product.Codigo*/),
                                          onChanged: (value) {
                                            setState(() {
                                              //product.Codigo = value;
                                            });
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        TextField(
                                          enabled: false,
                                          controller: TextEditingController(
                                              /*text: product.Producto*/),
                                          onChanged: (value) {
                                            setState(() {
                                              //product.Producto = value;
                                            });
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        TextField(
                                          textAlign: TextAlign.right,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            /*FilteringTextInputFormatter
                                                .digitsOnly*/
                                          ],
                                          controller: controller1,
                                          onChanged: (value) {
                                            setState(() {
                                              /*product.Cantidad =
                                                  int.parse(value);*/
                                            });
                                          },
                                          onTap: () {
                                            controller1.selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        offset: controller1
                                                            .text.length));
                                          },
                                          textInputAction: TextInputAction.done,
                                          onSubmitted: (_) {
                                            _dataController.add(null);
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        TextField(
                                          textAlign: TextAlign.right,
                                          enableInteractiveSelection: true,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          keyboardType: TextInputType.number,
                                          controller: controller,
                                          onChanged: (value) {
                                            setState(() {
                                              /*product.PrecioUnitario =
                                                  double.parse(value);*/
                                            });
                                          },
                                          onTap: () {
                                            controller.selection =
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        offset: controller
                                                            .text.length));
                                          },
                                          textInputAction: TextInputAction.done,
                                          onSubmitted: (_) {
                                            _dataController.add(null);
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        TextField(
                                          enabled: false,
                                          textAlign: TextAlign.right,
                                          controller: TextEditingController(
                                              /* text: (product.Cantidad *
                                                      product.PrecioUnitario)
                                                  .toString()*/
                                              ),
                                          onChanged: (value) {
                                            setState(() {
                                              /*product.subtotal =
                                                  product.Cantidad *
                                                      product.PrecioUnitario;*/
                                            });
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.add),
                                              onPressed: () {
                                                setState(() {
                                                  /*product.Cantidad++;
                                                  product.subtotal = product
                                                          .Cantidad *
                                                      product.PrecioUnitario;
                                                  _dataController.add(null);*/
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                                width:
                                                    8.0), // Separación entre los botones
                                            IconButton(
                                              icon: Icon(Icons.remove),
                                              onPressed: () {
                                                setState(() {
                                                  /*if (product.Cantidad > 1) {
                                                    product.Cantidad--;
                                                    product.subtotal = product
                                                            .Cantidad *
                                                        product.PrecioUnitario;
                                                    _dataController.add(null);
                                                  }*/
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                                width:
                                                    8.0), // Separación entre los botones
                                            IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                setState(() {
                                                  datosTabla.remove(product);
                                                  _dataController.add(null);
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]);
                                  }).toList(),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  late String? _idEntryNoteo;

  @override
  void initState() {
    super.initState();
    _idEntryNoteo = widget.idEntryNoteo;
    _searchFuture = api.buscarProductoNota('s');
  }

  @override
  Widget build(BuildContext context) {
    if (_idEntryNoteo == null) {
      return Center(
        child: ElevatedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.all(const BorderSide(
              color: Color.fromARGB(200, 194, 196, 197),
            )),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return StyleApp.ColorContText();
              }
              return Colors.transparent;
            }),
          ),
          onPressed: () {
            openModalBottomSheet(_idEntryNoteo);
          },
          child: Text(
            'Agregar Nota de Entrada',
            style: TextStyle(
                color: StyleApp.ColorText(context),
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else {
      return IconButton(
        onPressed: () {
          openModalBottomSheet(_idEntryNoteo);
        },
        icon: const Icon(Icons.edit),
      );
    }
  }
}
