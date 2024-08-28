import 'package:flutter/material.dart';
import 'package:control_stock/data/datasource/api/producto/product_client.dart';
import '../../../../domain/entitites/product.dart';
/*
String _productName = '';
int _productStock = 0;
double _productPrice = 0.0;
ProductoClient api = ProductoClient();
TemplateViewModel template = TemplateViewModel();

class CompanyViewModel {
  void showModalProduct(BuildContext context, {Product? productToEdit}) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    Product Producto = productToEdit ??
        Product(
            brand: '', model: '', stock: 0, code: '', unitPrice: 0, name: '');
    final _formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: template.ColorBackgroud(context),
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
                Text(productToEdit == null
                    ? 'Agregar Producto'
                    : 'Editar Producto'),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: Producto.name,
                  decoration:
                      const InputDecoration(labelText: 'Nombre del Producto'),
                  validator: (value) {
                    if (value == '') {
                      return 'Por favor, ingresa el nombre del Producto';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    Producto.name = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: Producto.stock.toString(),
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
                    Producto.stock = int.parse(value!);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: Producto.unitPrice.toString(),
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
                    Producto.unitPrice = double.parse(value!);
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (productToEdit == null) {
                        Producto.code = "1";
                        Producto.brand = "515";
                        Producto.model = "555";
                        AddProducto(Producto);
                      } else {
                        EditProducto(Producto);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                      productToEdit == null ? 'Agregar' : 'Guardar cambios'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<Product>> obtenerProductos() {
    Future<List<Product>> productos = api.GetProduct();
    return productos;
  }

  AddProducto(Product data) {
    Future<bool> producto = api.AddProduct(data);
    return producto;
  }

  EditProducto(Product producto) {}
}
*/