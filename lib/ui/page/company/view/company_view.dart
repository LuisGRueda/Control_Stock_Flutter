import 'package:control_stock/ui/page/company/viewmodel/company_view_model.dart';
import 'package:flutter/material.dart';
import '../../../../../domain/entitites/product.dart';
/*
class CompanyView extends StatefulWidget {
  const CompanyView({super.key});
  @override
  State<CompanyView> createState() => _CompanyViewState();
}

class _CompanyViewState extends State<CompanyView> {
  @override
  TemplateViewModel template = TemplateViewModel();
  CompanyViewModel ProdModel = CompanyViewModel();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: template.ColorBackgroud(context),
      body: Column(
        children: [
          Expanded(
            flex: 0,
            child: Container(color: Colors.grey),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Row(
                children: [
                  Expanded(
                    child: template.CardInfo("contenido card", context),
                  ),
                  Expanded(
                    child: template.CardInfo("contenido card", context),
                  ),
                  Expanded(
                    child: template.CardInfo("contenido card", context),
                  )
                ],
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
                        ProdModel.showModalProduct(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      child: Text('Agregar'),
                    ),
                    Container(
                      color: Colors.white,
                      child: FutureBuilder<List<Product>>(
                        future: Future.value(ProdModel.obtenerProductos()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text("Error al cargar los Registros");
                          } else {
                            List<Product>? productos = snapshot.data;
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
      ),
    );
  }
}
*/