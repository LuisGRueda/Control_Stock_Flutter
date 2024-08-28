import 'package:flutter/material.dart';
import 'package:control_stock/domain/entitites/product.dart';
import 'package:flutter/material.dart';
import 'package:control_stock/data/datasource/api/producto/product_client.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
/*
class MyModalBottomSheet extends StatefulWidget {
  const MyModalBottomSheet({Key? key}) : super(key: key);

  @override
  _MyModalBottomSheetState createState() => _MyModalBottomSheetState();
}

class _MyModalBottomSheetState extends State<MyModalBottomSheet> {
  String? _selectedOption;
  String dropdownValue = 'Opción 1';
  List<String> options = ['Opción 1', 'Opción 2', 'Opción 3'];
  final format = DateFormat("yyyy-MM-dd");
  List<Product> datos = [
    Product(
        code: "123",
        name: DateTime.now(),
        stock: 152364,
        unitPrice: 1,
        brand: "5555",
        model: "5545454"),
    Product(
        code: "456",
        name: DateTime.now(),
        stock: 152364,
        unitPrice: 1,
        brand: "5555",
        model: "5545454"),
    Product(
        code: "789",
        name: DateTime.now(),
        stock: 152364,
        unitPrice: 1,
        brand: "5555",
        model: "5545454")
  ];
  final List<DataColumn> _columns = [
    DataColumn(
      label: Text('Code'),
    ),
    DataColumn(
      label: Text('Name'),
    ),
    DataColumn(
      label: Text('Stock'),
    ),
  ];
  final _formKey = GlobalKey<FormState>();

  void _openModalBottomSheet(Product? productEdit) {
    Product Producto = productEdit ??
        Product(
            brand: '',
            model: '',
            stock: 0,
            code: '',
            unitPrice: 0,
            name: DateTime.now());
    final _formKey = GlobalKey<FormState>();
    List<String> listaDeOpciones = ["A opcion", "opcion 2", "opcion 3"];
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          height: MediaQuery.of(context).size.height * 0.9,
          margin: MediaQuery.of(context).size.width < 800
              ? const EdgeInsets.fromLTRB(60, 0, 60, 0)
              : const EdgeInsets.fromLTRB(180, 0, 180, 0),
          padding: MediaQuery.of(context).size.width < 800
              ? const EdgeInsets.all(25)
              : const EdgeInsets.all(50),
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 0,
                    child: Container(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.red,
                              child: Text(productEdit == null
                                  ? 'Agregar Producto'
                                  : 'Editar Producto'),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton(
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.green,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DateTimeField(
                                  initialValue: Producto.name != DateTime.now()
                                      ? null
                                      : Producto.name,
                                  decoration: const InputDecoration(
                                      labelText: 'fecha de Registro'),
                                  format: format,
                                  onShowPicker: (context, currentValue) async {
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
                                    Producto.name = value!;
                                  },
                                ),
                                DropdownButtonFormField(
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
                                DropdownButtonFormField(
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
                                Autocomplete<Product>(
                                  optionsMaxHeight: 200,
                                  optionsBuilder: (TextEditingValue value) {
                                    if (value.text.isEmpty) {
                                      return List.empty();
                                    }
                                    return datos
                                        .where((element) => element.code
                                            .toLowerCase()
                                            .contains(value.text.toLowerCase()))
                                        .toList();
                                  },
                                  fieldViewBuilder: (BuildContext context,
                                          TextEditingController controller,
                                          FocusNode node,
                                          Function onSubmit) =>
                                      TextField(
                                    controller: controller,
                                    focusNode: node,
                                    decoration: const InputDecoration(
                                        hintText: 'Type here...'),
                                  ),
                                  optionsViewBuilder: (BuildContext context,
                                          Function onSelect,
                                          Iterable<Product> options) =>
                                      Align(
                                    alignment: Alignment.topLeft,
                                    child: Material(
                                      child: Container(
                                        width: 300,
                                        color: Colors.yellow,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: options.length,
                                          itemBuilder: (context, index) {
                                            Product d =
                                                options.elementAt(index);
                                            return InkWell(
                                              onTap: () => onSelect(d),
                                              child: ListTile(
                                                title: Text(d.code),
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
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.orange,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DateTimeField(
                                  initialValue: Producto.name != DateTime.now()
                                      ? null
                                      : Producto.name,
                                  decoration: const InputDecoration(
                                      labelText: 'fecha de Registro'),
                                  format: format,
                                  onShowPicker: (context, currentValue) async {
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
                                    Producto.name = value!;
                                  },
                                ),
                                DateTimeField(
                                  initialValue: Producto.name != DateTime.now()
                                      ? null
                                      : Producto.name,
                                  decoration: const InputDecoration(
                                      labelText: 'fecha de Registro'),
                                  format: format,
                                  onShowPicker: (context, currentValue) async {
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
                                    Producto.name = value!;
                                  },
                                ),
                                const TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Input 3',
                                  ),
                                ),
                                const TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Input 4',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      color: Colors.purple,
                      child: Autocomplete<Product>(
                        optionsMaxHeight: 200,
                        optionsBuilder: (TextEditingValue value) {
                          if (value.text.isEmpty) {
                            return List.empty();
                          }
                          return datos
                              .where((element) => element.code
                                  .toLowerCase()
                                  .contains(value.text.toLowerCase()))
                              .toList();
                        },
                        fieldViewBuilder: (BuildContext context,
                                TextEditingController controller,
                                FocusNode node,
                                Function onSubmit) =>
                            TextField(
                          controller: controller,
                          focusNode: node,
                          decoration:
                              const InputDecoration(hintText: 'Type here...'),
                        ),
                        optionsViewBuilder: (BuildContext context,
                                Function onSelect, Iterable<Product> options) =>
                            Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              width: 300,
                              color: Colors.yellow,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (context, index) {
                                  Product d = options.elementAt(index);
                                  return InkWell(
                                    onTap: () => onSelect(d),
                                    child: ListTile(
                                      title: Text(d.code),
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
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.purple,
                      child: DataTable(
                        columns: _columns,
                        rows: datos.map((product) {
                          return DataRow(cells: [
                            DataCell(
                              TextField(
                                enabled: false,
                                controller:
                                    TextEditingController(text: product.code),
                                onChanged: (value) {
                                  setState(() {
                                    product.code = value;
                                  });
                                },
                              ),
                            ),
                            DataCell(
                              TextField(
                                controller:
                                    TextEditingController(text: product.code),
                                onChanged: (value) {
                                  setState(() {
                                    product.code = value;
                                  });
                                },
                              ),
                            ),
                            DataCell(
                              TextField(
                                controller: TextEditingController(
                                    text: product.stock.toString()),
                                onChanged: (value) {
                                  setState(() {
                                    product.stock = int.parse(value);
                                  });
                                },
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
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
}*/
