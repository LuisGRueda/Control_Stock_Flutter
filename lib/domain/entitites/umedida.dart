class UnidadDeMedida {
  final int id;
  final String nombre;
  final int categoriaId;
  final int factor;
  final int redondeo;
  final bool activo;

  UnidadDeMedida(
      {required this.id,
      required this.nombre,
      required this.categoriaId,
      required this.factor,
      required this.redondeo,
      required this.activo});

  factory UnidadDeMedida.fromJson(Map<String, dynamic> json) {
    return UnidadDeMedida(
      id: json['id'],
      nombre: json['nombre'],
      categoriaId: json['categoriaId'],
      factor: json['factor'],
      redondeo: json['redondeo'],
      activo: json['activo'],
    );
  }
}
