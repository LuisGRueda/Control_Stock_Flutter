class NotaEntrada {
  int id;
  String fechaNota;
  String nroFactura;
  String proveedorDesc;
  String clienteRecpDesc;
  String destinatarioDesc;
  String tipoDesc;
  String tipoDocumentoDesc;

  NotaEntrada({
    required this.id,
    required this.fechaNota,
    required this.nroFactura,
    required this.proveedorDesc,
    required this.clienteRecpDesc,
    required this.destinatarioDesc,
    required this.tipoDesc,
    required this.tipoDocumentoDesc,
  });

  factory NotaEntrada.fromJson(Map<String, dynamic> json) {
    return NotaEntrada(
      id: json['id'],
      fechaNota: json['fechaNota'],
      nroFactura: json['nroFactura'],
      proveedorDesc: json['proveedorDesc'],
      clienteRecpDesc: json['clienteRecpDesc'],
      destinatarioDesc: json['destinatarioDesc'],
      tipoDesc: json['tipoDesc'],
      tipoDocumentoDesc: json['tipoDocumentoDesc'],
    );
  }
}
