class ProductType {
  int id;
  String nombre;
  String descripcion;
  String codigo;
  bool activo;
  int sisClasificadorId;

  ProductType({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.codigo,
    required this.activo,
    required this.sisClasificadorId,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      codigo: json['codigo'],
      activo: json['activo'],
      sisClasificadorId: json['sisClasificadorId'],
    );
  }
}
