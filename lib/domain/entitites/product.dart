class Product {
  final String codigo;
  final String nombre;
  final String descripcion;
  final int unidadMedidaId;
  final String unidadMedidaDesc;
  final double cantidadFisica;
  final double cantidadLogica;
  final double precioPromedio;
  final int id;

  Product({
    required this.codigo,
    required this.nombre,
    required this.descripcion,
    required this.unidadMedidaId,
    required this.unidadMedidaDesc,
    required this.cantidadFisica,
    required this.cantidadLogica,
    required this.precioPromedio,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      codigo: json['codigo'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      unidadMedidaId: json['unidadMedidaId'],
      unidadMedidaDesc: json['unidadMedidaDesc'],
      cantidadFisica: json['cantidadFisica'].toDouble(),
      cantidadLogica: json['cantidadLogica'].toDouble(),
      precioPromedio: json['precioPromedio'].toDouble(),
      id: json['id'],
    );
  }
}

class Producto {
  int id;
  String nombre;
  String codigo;
  double cantidadLogica;
  bool conVenc;
  double precioPromedio;
  String serie;

  Producto({
    required this.id,
    required this.nombre,
    required this.codigo,
    required this.cantidadLogica,
    required this.conVenc,
    required this.precioPromedio,
    required this.serie,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      codigo: json['codigo'],
      cantidadLogica: json['cantidadLogica'].toDouble(),
      conVenc: json['conVenc'],
      precioPromedio: json['precioPromedio'].toDouble(),
      serie: json['serie'],
    );
  }
}