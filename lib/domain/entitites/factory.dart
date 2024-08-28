class Factory {
  final String nroDocumento;
  final String nombre;
  final String descripcion;
  final int id;

  Factory({
    required this.nroDocumento,
    required this.nombre,
    required this.descripcion,
    required this.id,
  });

  factory Factory.fromJson(Map<String, dynamic> json) {
    return Factory(
      nroDocumento: json['nroDocumento'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      id: json['id'],
    );
  }
}
