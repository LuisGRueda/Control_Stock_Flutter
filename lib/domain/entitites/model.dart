class Model {
  int id;
  bool isSelected;
  int clasificadorId;
  String nombre;
  String codigo;
  String descripcion;

  Model({
    required this.id,
    required this.isSelected,
    required this.clasificadorId,
    required this.nombre,
    required this.codigo,
    required this.descripcion,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
        id: json["id"],
        isSelected: json["esSelected"],
        clasificadorId: json["clasificadorId"],
        nombre: json["nombre"],
        codigo: json["codigo"],
        descripcion: json["descripcion"]);
  }
}
