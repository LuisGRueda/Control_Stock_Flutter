/*import 'dart:async';
import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/inventory/product/productcrud/viewmodel/crudproduct_view_model.dart';
import 'package:flutter/material.dart';
import 'package:control_stock/domain/entitites/product.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class MyModalBottomExitNote extends StatefulWidget {
  const MyModalBottomExitNote({Key? key}) : super(key: key);

  @override
  _MyModalBottomExitNoteState createState() => _MyModalBottomExitNoteState();
}

CrudProductViewModel api = CrudProductViewModel();

class _MyModalBottomExitNoteState extends State<MyModalBottomExitNote> {
  String? _selectedOption;

  bool _isSelected = false;
  String dropdownValue = 'Opción 1';
  List<String> options = ['Opción 1', 'Opción 2', 'Opción 3'];
  final format = DateFormat("yyyy-MM-dd");
  late Future<List<Product>> datos;

  AppColor StyleApp = AppColor();
  final _formKey = GlobalKey<FormState>();
  FocusNode myFocusNode = FocusNode();
  void _openModalBottomSheet(Product? productEdit) {
    List<Product> datosTabla = List.empty(growable: true);
    final _dataController = StreamController<void>.broadcast();

    Object Producto = productEdit ?? Product;
    {
      id:
      null;
      esServicio:
      false;
      nombre:
      "";
      codigo:
      "";
      descripcion:
      "";
      conVencimiento:
      false;
      borrado:
      false;
      categoriaId:
      null;
      unidadMedidaId:
      null;
      productoTipoId:
      null;
      areaUso:
      [];
      motivoCambio:
      "";
      esSuscripcion:
      false;
      fabricanteId:
      null;
      modeloId:
      null;
      serie:
      "";
    }
    ;
    final _formKey = GlobalKey<FormState>();
    List<String> listaDeOpciones = ["A opcion", "opcion 2", "opcion 3"];
    searchData(String query) {
      return api.searchProducts(query);
    }

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

    final TextEditingController _controller = TextEditingController();
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
          height: MediaQuery.of(context).size.height * 0.9,
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
                                productEdit == null
                                    ? 'Agregar Producto'
                                    : 'Editar Producto',
                                style: StyleApp.StyleText(context)),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(productEdit == null
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
                                const SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: DateTimeField(
                                    /*initialValue:
                                        Producto. != DateTime.now()
                                            ? null
                                            : Producto.name,*/
                                    decoration: InputDecoration(
                                      labelText: 'Fecha de Registro',
                                      labelStyle: const TextStyle(fontSize: 12),
                                      suffixIcon: Icon(Icons.calendar_month),
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
                                      // ignore: unrelated_type_equality_checks
                                      if (value == '') {
                                        return 'Por favor, ingresa una fecha';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      //Producto.name = value!;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: DropdownButtonFormField(
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: StyleApp.ColorText(context)),
                                    hint: const Text('Almacen'),
                                    icon: const Icon(Icons.expand_more),
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
                                    items: listaDeOpciones.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            e,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {},
                                    isDense: true,
                                    isExpanded: true,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: DropdownButtonFormField(
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: StyleApp.ColorText(context)),
                                    hint: const Text('Proveedor'),
                                    icon: const Icon(Icons.arrow_drop_down),
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
                                    items: listaDeOpciones.map((e) {
                                      return DropdownMenuItem(
                                        value: e,
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            e,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String? value) {},
                                    isDense: true,
                                    isExpanded: true,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                /*SizedBox(
                                  height: 35,
                                  child: Autocomplete<Product>(
                                    optionsMaxHeight: 200,
                                    optionsBuilder: (TextEditingValue value) {
                                      if (value.text.isEmpty) {
                                        return List.empty();
                                      }
                                      return datos
                                          .where((element) => element.code
                                              .toLowerCase()
                                              .contains(
                                                  value.text.toLowerCase()))
                                          .toList();
                                    },
                                    fieldViewBuilder: (BuildContext context,
                                            TextEditingController controller,
                                            FocusNode node,
                                            Function onSubmit) =>
                                        TextField(
                                      controller: controller,
                                      focusNode: node,
                                      decoration: InputDecoration(
                                        hintText: 'Buscar Proveedor...',
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
                                            Iterable<Product> options) =>
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
                                              Product d =
                                                  options.elementAt(index);
                                              return InkWell(
                                                onTap: () => onSelect(d),
                                                child: ListTile(
                                                  title: Text(
                                                    d.code,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    onSelected: (value) => print(value.code),
                                    displayStringForOption: (Product d) =>
                                        '${d.code} ${d.stock}',
                                  ),
                                ),*/
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
                                const SizedBox(
                                  height: 16,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: DateTimeField(
                                    /*initialValue:
                                        Producto.name != DateTime.now()
                                            ? null
                                            : Producto.name,*/
                                    decoration: InputDecoration(
                                      labelText: 'Fecha de Registro',
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
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
                                      // ignore: unrelated_type_equality_checks
                                      if (value == '') {
                                        return 'Por favor, ingresa una fecha';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      //Producto.name = value!;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: DateTimeField(
                                    /*initialValue:
                                        Producto.name != DateTime.now()
                                            ? null
                                            : Producto.name,*/
                                    decoration: InputDecoration(
                                      labelText: 'Fecha de Registro',
                                      labelStyle: TextStyle(fontSize: 12),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
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
                                      // ignore: unrelated_type_equality_checks
                                      if (value == '') {
                                        return 'Por favor, ingresa una fecha';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      //Producto.name = value!;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: TextField(
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: _controller,
                                    decoration: InputDecoration(
                                      labelText: 'Nro Factura',
                                      labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: _isSelected
                                            ? Colors.lightBlueAccent
                                            : Colors.grey,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
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
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Orden Compra',
                                      labelStyle: TextStyle(fontSize: 12),
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(child: Text('')),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(40, 0, 40, 12),
                            color: StyleApp.ColorContainer(context),
                            child: SizedBox(
                              height: 35,
                              child: Autocomplete<Product>(
                                optionsMaxHeight: 200,
                                optionsBuilder: (TextEditingValue value) {
                                  if (value.text.isEmpty) {
                                    return List.empty();
                                  }
                                  return datosMedida = searchMedida(value.text);
                                },
                                fieldViewBuilder: (BuildContext context,
                                        TextEditingController controller,
                                        FocusNode node,
                                        Function onSubmit) =>
                                    TextField(
                                  controller: controller,
                                  focusNode: node,
                                  decoration: InputDecoration(
                                    hintText: 'Buscar Producto...',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 8.0,
                                    ),
                                  ),
                                ),
                                optionsViewBuilder: (BuildContext context,
                                        Function onSelect,
                                        Iterable<Product> options) =>
                                    Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    child: Container(
                                      width: 300,
                                      color: StyleApp.ColorBackgroud(context),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: options.length,
                                        itemBuilder: (context, index) {
                                          Product d = options.elementAt(index);
                                          return InkWell(
                                            onTap: () => onSelect(d),
                                            child: ListTile(
                                                //title: Text(d.code),
                                                ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                onSelected: (value) {
                                  setState(() {
                                    /*
                                    final productoExistente =
                                        datosTabla.firstWhereOrNull(
                                      (producto) =>
                                          producto.Codigo == value.code,
                                    );
                                    if (productoExistente != null) {
                                     // productoExistente.Cantidad++;
                                      _dataController.add(null);
                                    } else {
                                      /*datosTabla.add(Prod()
                                        ..Codigo = value.code
                                        ..Producto = value.model
                                        ..Cantidad = 1
                                        ..PrecioUnitario = value.unitPrice
                                        ..subtotal = value.unitPrice);
                                      _dataController.add(null);*/
                                    }
                                    _dataController.add(null);
                                  */
                                  });
                                },
                                displayStringForOption: (Product d) => '',
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(''),
                        )
                      ],
                    ),
                  ),
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
                                      text: product.PrecioUnitario.toString(),
                                    );
                                    TextEditingController controller1 =
                                        TextEditingController(
                                      text: product.Cantidad.toString(),
                                    );
                                    return DataRow(cells: [
                                      DataCell(
                                        TextField(
                                          enabled: false,
                                          controller: TextEditingController(
                                              text: product.Codigo),
                                          onChanged: (value) {
                                            setState(() {
                                              product.Codigo = value;
                                            });
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        TextField(
                                          enabled: false,
                                          controller: TextEditingController(
                                              text: product.Producto),
                                          onChanged: (value) {
                                            setState(() {
                                              product.Producto = value;
                                            });
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        TextField(
                                          textAlign: TextAlign.right,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          controller: controller1,
                                          onChanged: (value) {
                                            setState(() {
                                              product.Cantidad =
                                                  int.parse(value);
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
                                              product.PrecioUnitario =
                                                  double.parse(value);
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
                                              text: (product.Cantidad *
                                                      product.PrecioUnitario)
                                                  .toString()),
                                          onChanged: (value) {
                                            setState(() {
                                              product.subtotal =
                                                  product.Cantidad *
                                                      product.PrecioUnitario;
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
                                                  product.Cantidad++;
                                                  product.subtotal = product
                                                          .Cantidad *
                                                      product.PrecioUnitario;
                                                  _dataController.add(null);
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
                                                  if (product.Cantidad > 1) {
                                                    product.Cantidad--;
                                                    product.subtotal = product
                                                            .Cantidad *
                                                        product.PrecioUnitario;
                                                    _dataController.add(null);
                                                  }
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

  @override
  Widget build(BuildContext context, {Product? productToEdit}) {
    Product? productos = productToEdit;
    // ignore: unused_local_variable
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _openModalBottomSheet(productos);
        },
        child: const Text('Mostrar Modal'),
      ),
    );
  }
}
*/