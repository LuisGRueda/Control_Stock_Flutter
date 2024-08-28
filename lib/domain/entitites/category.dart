class Category {
  final int id;
  final int padre;
  final String nombre;
  final List<dynamic>? ancestros;

  Category(
      {required this.id,
      required this.padre,
      required this.nombre,
      required this.ancestros});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      padre: json['padre'] ?? 0,
      nombre: json['nombre'],
      ancestros: json['ancestros'] ?? [],
    );
  }
}
