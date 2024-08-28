import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/responsive/responsive_view.dart';
import 'package:flutter/material.dart';

class User {
  final String nombre;
  final String apellido;

  User({required this.nombre, required this.apellido});
}

AppColor StyleApp = AppColor();

class RecruitmentDataWidget extends StatefulWidget {
  const RecruitmentDataWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RecruitmentDataWidgetState createState() => _RecruitmentDataWidgetState();
}

class _RecruitmentDataWidgetState extends State<RecruitmentDataWidget> {
  final List<User> users = [
    User(nombre: 'Juan', apellido: 'Pérez'),
    User(nombre: 'María', apellido: 'García'),
    User(nombre: 'Pedro', apellido: 'Sánchez'),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: StyleApp.ColorContainer(context),
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Usuarios Activos",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: StyleApp.ColorText(context),
                  fontSize: 22,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: StyleApp.ColorContText(),
                    borderRadius: BorderRadius.circular(100)),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                  "Ver todos",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: StyleApp.ColorText(context)),
                ),
              )
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          DataTable(
            columns: const [
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Apellido')),
            ],
            rows: users.map((user) {
              return DataRow(cells: [
                DataCell(Text(user.nombre)),
                DataCell(Text(user.apellido)),
              ]);
            }).toList(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Mostrando 4 de 4 resultados"),
                Text(
                  "Ver Todos",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
