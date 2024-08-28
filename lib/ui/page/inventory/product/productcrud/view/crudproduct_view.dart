// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:control_stock/domain/entitites/category.dart';
import 'package:control_stock/domain/entitites/factory.dart';
import 'package:control_stock/domain/entitites/umedida.dart';
import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/inventory/product/productcrud/viewmodel/crudproduct_view_model.dart';
import 'package:flutter/material.dart';
import 'package:control_stock/domain/entitites/product.dart';
import 'package:fluttertoast/fluttertoast.dart';

CrudProductViewModel api = CrudProductViewModel();
String idPROD = "";

//DISEMO DE MARGENES DE MODAL
class MyModalBottomProduct extends StatefulWidget {
  final Function() onNewDataAdded;
  const MyModalBottomProduct(this.idProducto,
      {Key? key, required this.onNewDataAdded})
      : super(key: key);
  final String? idProducto;
  @override
  // ignore: library_private_types_in_public_api
  _MyModalBottomProductState createState() => _MyModalBottomProductState();
}

class _MyModalBottomProductState extends State<MyModalBottomProduct> {
  bool _isSelected = false;
  late Future<List<Product>> datos;
  late Future<List<UnidadDeMedida>> datosMedida;
  late Future<List<Category>> datosCategoria;
  late Future<List<Factory>> datosFabricas;

  // ignore: non_constant_identifier_names
  AppColor StyleApp = AppColor();
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();

  Future<void> openModalBottomSheet(String? idProduct) async {
    bool modoEdit = false;
    String idx = '';

    int id = 0;
    String codigo = '';
    String nombre = '';
    String descripcion = '';
    String motivoCambio = "";
    int categoria = 0;
    int unidadMedida = 0;
    int tipoProducto = 0;
    int fabricante = 0;
    int modelo = 0;
    List<int> areaUso = [];
    String serie = '';
    bool isService = false;
    bool isVencimiento = false;
    bool isSuscription = false;
    // ignore: unused_local_variable
    bool borrado = false;
    // ignore: unused_local_variable
    final dataController = StreamController<void>.broadcast();

    //COMPROBAR SI ES EDICION
    if (idProduct != null) {
      modoEdit = true;
      idx = idProduct;
      try {
        final producto = await api.ProductoId(idx);
        setState(() {
          id = producto['data']['id'];
          codigo = producto['data']['codigo'];
          nombre = producto['data']['nombre'];
          descripcion = producto['data']['descripcion'];
          categoria = producto['data']['categoriaId'];
          unidadMedida = producto['data']['unidadMedidaId'];
          tipoProducto = producto['data']['productoTipoId'];
          fabricante = producto['data']['fabricanteId'];
          modelo = producto['data']['modeloId'];
          areaUso = producto['data']['areaUso'];
          serie = producto['data']['serie'];
          motivoCambio = producto['data']['motivoCambio'];
          isService = producto['data']['esServicio'];
          isVencimiento = producto['data']['conVenciomiento'];
          isSuscription = producto['data']['esSuscripcion'];
        });
      } catch (e) {
        print('Error al cargar el producto: $e');
      }
    }
    //END COMPROBAR SI ES EDICION
    //VALIDADORES
    bool ValCategoria = false;
    bool ValUMedida = false;
    bool ValFabrica = false;
    //END VALIDADORES

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
                                modoEdit == false
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
                                      final camposCompletos = ValCategoria &&
                                          ValUMedida &&
                                          ValFabrica;

                                      if (camposCompletos == true) {
                                        final producto = {
                                          "id": id,
                                          "esServicio": isService,
                                          "nombre": nombre,
                                          "codigo": codigo,
                                          "descripcion": descripcion,
                                          "conVenciomiento": isVencimiento,
                                          "borrado": false,
                                          "categoriaId": categoria,
                                          "unidadMedidaId": unidadMedida,
                                          "productoTipoId": tipoProducto,
                                          "areaUso": [1],
                                          "motivoCambio": motivoCambio,
                                          "esSuscripcion": isSuscription,
                                          "fabricanteId": fabricante,
                                          "modeloId": modelo,
                                          "serie": serie,
                                        };

                                        //VERIFICACION DE ID PARA EDITORAR O AGREGAR
                                        final apiMethod = modoEdit == false
                                            ? api.AddProduct
                                            : api.EditProduct;
                                        final successMessage = idProduct == null
                                            ? "El producto ha sido agregado correctamente."
                                            : "El producto ha sido modificado correctamente.";
                                        final errorMessage = idProduct == null
                                            ? "Ha ocurrido un error al intentar agregar el producto."
                                            : "Ha ocurrido un error al intentar modificar el producto.";

                                        apiMethod(producto).then((resultado) {
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
                                  height: _isSelected ? 70 : 35,
                                  child: TextFormField(
                                    initialValue: codigo,
                                    decoration: StyleApp.StyleInputText(
                                        context, 'Codigo'),
                                    validator: (value) {
                                      if (value == '') {
                                        return 'Por favor, ingresa Ingresa un Codigo';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        codigo = value;
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
                                SizedBox(
                                  height: 35,
                                  child: TextFormField(
                                    initialValue: nombre,
                                    decoration: StyleApp.StyleInputText(
                                        context, 'Nombre'),
                                    validator: (value) {
                                      if (value == '') {
                                        return 'Por favor, ingresa Un nombre para este producto';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      nombre = value;
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
                                SizedBox(
                                  height: 35,
                                  child: TextFormField(
                                    initialValue: descripcion,
                                    decoration: StyleApp.StyleInputText(
                                        context, 'Descripcion'),
                                    validator: (value) {
                                      if (value == '') {
                                        return 'Por favor, ingresa una descripcion para este producto';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      descripcion = value;
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
                                SizedBox(
                                  height: 35,
                                  child: Autocomplete<Category>(
                                    optionsMaxHeight: 200,
                                    optionsBuilder: (TextEditingValue value) {
                                      if (value.text.isEmpty) {
                                        return List.empty();
                                      }
                                      return api
                                          .searchCategorys(value.text)
                                          .then((result) => result
                                              .map((item) =>
                                                  Category.fromJson(item))
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
                                        hintText: 'Categoria',
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
                                            Iterable<Category> options) =>
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
                                              Category d =
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
                                      categoria = value.id;
                                      ValCategoria = true;
                                    },
                                    displayStringForOption: (Category d) =>
                                        d.nombre,
                                  ),
                                ),
                                StyleApp.Separate12(),
                                SizedBox(
                                  height: 35,
                                  child: Autocomplete<UnidadDeMedida>(
                                    optionsMaxHeight: 200,
                                    optionsBuilder: (TextEditingValue value) {
                                      if (value.text.isEmpty) {
                                        return List.empty();
                                      }
                                      return api
                                          .listarUnidadMedida(value.text)
                                          .then((result) => result
                                              .map((item) =>
                                                  UnidadDeMedida.fromJson(item))
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
                                        hintText: 'Unidad Medida...',
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
                                            Iterable<UnidadDeMedida> options) =>
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
                                              UnidadDeMedida d =
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
                                      unidadMedida = value.id;
                                      ValUMedida = true;
                                    },
                                    displayStringForOption:
                                        (UnidadDeMedida d) => d.nombre,
                                  ),
                                ),
                                StyleApp.Separate12(),
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
                                SizedBox(
                                  height: 35,
                                  child: FutureBuilder<
                                          List<Map<String, dynamic>>>(
                                      future: api.ListProductType(),
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
                                              return 'Por favor, selecciona un tipo para este producto';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  StyleApp.ColorText(context)),
                                          hint: const Text('Tipo de Producto'),
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
                                            print(parsedValue);
                                            if (parsedValue != null) {
                                              tipoProducto = parsedValue;
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
                                      future: api.ListAreaUso(),
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
                                              return 'Por favor, selecciona un area de uso para este producto';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  StyleApp.ColorText(context)),
                                          hint: const Text('Area de Uso'),
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
                                              areaUso.add(parsedValue);
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
                                        hintText: 'Fabricante',
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
                                      ValFabrica = true;
                                    },
                                    displayStringForOption: (Factory d) =>
                                        d.nombre,
                                  ),
                                ),
                                StyleApp.Separate12(),
                                SizedBox(
                                  height: 35,
                                  child: FutureBuilder<
                                          List<Map<String, dynamic>>>(
                                      future: api.ListModel(),
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
                                              return 'Por favor, selecciona un modelo para este producto';
                                            }
                                            return null;
                                          },
                                          style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  StyleApp.ColorText(context)),
                                          hint: const Text('Modelo'),
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
                                              modelo = parsedValue;
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
                                  child: TextFormField(
                                    initialValue: serie,
                                    decoration: StyleApp.StyleInputText(
                                        context, 'Nro. Serie'),
                                    validator: (value) {
                                      if (value == '') {
                                        return 'Por favor, ingresa una serie para este producto';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      serie = value;
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
                                SizedBox(
                                  height: 35,
                                  child: modoEdit
                                      ? TextFormField(
                                          initialValue: motivoCambio,
                                          decoration: StyleApp.StyleInputText(
                                              context, 'Motivo de Cambio'),
                                          validator: (value) {
                                            if (value == '') {
                                              return 'Por favor, ingresa Un Motivo de Cambio para este producto';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            motivoCambio = value;
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
                                        )
                                      : Container(),
                                ),
                                StyleApp.Separate12(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Flex(
                      direction: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(40, 0, 40, 12),
                            color: StyleApp.ColorContainer(context),
                            child: MediaQuery.of(context).size.width <= 600
                                ? Column(
                                    children: [
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return SwitchListTile(
                                            title: const Text('¿Es servicio?'),
                                            value: isService,
                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                            activeColor: Colors.blue,
                                            inactiveTrackColor: Colors.grey,
                                            onChanged: (bool valor) {
                                              setState(() {
                                                isService = valor;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return SwitchListTile(
                                            title: const Text(
                                                '¿Tiene Vencimiento?'),
                                            value: isVencimiento,
                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                            activeColor: Colors.blue,
                                            inactiveTrackColor: Colors.grey,
                                            onChanged: (bool valor) {
                                              setState(() {
                                                isVencimiento = valor;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return SwitchListTile(
                                            title:
                                                const Text('¿Es Suscripcion?'),
                                            value: isSuscription,
                                            contentPadding: EdgeInsets.zero,
                                            dense: true,
                                            activeColor: Colors.blue,
                                            inactiveTrackColor: Colors.grey,
                                            onChanged: (bool valor) {
                                              setState(() {
                                                isSuscription = valor;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return SwitchListTile(
                                              title:
                                                  const Text('¿Es servicio?'),
                                              value: isService,
                                              contentPadding: EdgeInsets.zero,
                                              dense: true,
                                              activeColor: Colors.blue,
                                              inactiveTrackColor: Colors.grey,
                                              onChanged: (bool valor) {
                                                setState(() {
                                                  isService = valor;
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return SwitchListTile(
                                              title: const Text(
                                                  '¿Tiene Vencimiento?'),
                                              value: isVencimiento,
                                              contentPadding: EdgeInsets.zero,
                                              dense: true,
                                              activeColor: Colors.blue,
                                              inactiveTrackColor: Colors.grey,
                                              onChanged: (bool valor) {
                                                setState(() {
                                                  isVencimiento = valor;
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return SwitchListTile(
                                              title: const Text(
                                                  '¿Es Suscripcion?'),
                                              value: isSuscription,
                                              contentPadding: EdgeInsets.zero,
                                              dense: true,
                                              activeColor: Colors.blue,
                                              inactiveTrackColor: Colors.grey,
                                              onChanged: (bool valor) {
                                                setState(() {
                                                  isSuscription = valor;
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  late String? _idProducto;

  @override
  void initState() {
    super.initState();
    _idProducto = widget.idProducto;
  }

  @override
  Widget build(BuildContext context) {
    if (_idProducto == null) {
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
            openModalBottomSheet(_idProducto);
          },
          child: Text(
            'Agregar producto',
            style: TextStyle(
                color: StyleApp.ColorText(context),
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else {
      return IconButton(
        onPressed: () {
          openModalBottomSheet(_idProducto);
        },
        icon: const Icon(Icons.edit),
      );
    }
  }
}
