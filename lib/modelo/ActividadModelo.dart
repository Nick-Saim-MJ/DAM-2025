class ActividadResp {
  ActividadResp({
    required this.idActividad,
    required this.titulo,
    required this.descripcion,
    required this.tipo,
    required this.duracionHoras,
    required this.imagenUrl,
    this.imagenPublicId, // It's nullable in backend, so make it nullable here
    required this.precioBase,

  });

  final int idActividad;
  final String titulo;
  final String descripcion;
  final String tipo;
  final int duracionHoras;
  final String imagenUrl;
  final String? imagenPublicId; // Nullable
  final double precioBase; // Mapped from BigDecimal

  factory ActividadResp.fromJson(Map<String, dynamic> json) {
    return ActividadResp(
      idActividad: json["idActividad"],
      titulo: json["titulo"],
      descripcion: json["descripcion"],
      tipo: json["tipo"],
      duracionHoras: json["duracionHoras"],
      imagenUrl: json["imagenUrl"],
      imagenPublicId: json["imagenPublicId"],
      precioBase: (json["precioBase"] as num?)?.toDouble() ?? 0.0, // Handle BigDecimal to double
    );
  }

  Map<String, dynamic> toJson() => {
    "idActividad": idActividad,
    "titulo": titulo,
    "descripcion": descripcion,
    "tipo": tipo,
    "duracionHoras": duracionHoras,
    "imagenUrl": imagenUrl,
    "imagenPublicId": imagenPublicId,
    "precioBase": precioBase,
  };
}

class ActividadDto {
  ActividadDto({
    required this.titulo,
    required this.descripcion,
    required this.tipo,
    required this.duracionHoras,
    required this.imagenUrl,
    this.imagenPublicId, // Nullable
    required this.precioBase,
  });

  late String titulo;
  late String descripcion;
  late String tipo;
  late int duracionHoras;
  late String imagenUrl;
  late String? imagenPublicId; // Nullable
  late double precioBase; // Mapped from BigDecimal

  ActividadDto.unlaunched();

  factory ActividadDto.fromJson(Map<String, dynamic> json) {
    return ActividadDto(
      titulo: json["titulo"],
      descripcion: json["descripcion"],
      tipo: json["tipo"],
      duracionHoras: json["duracionHoras"],
      imagenUrl: json["imagenUrl"],
      imagenPublicId: json["imagenPublicId"],
      precioBase: (json["precioBase"] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    "titulo": titulo,
    "descripcion": descripcion,
    "tipo": tipo,
    "duracionHoras": duracionHoras,
    "imagenUrl": imagenUrl,
    "imagenPublicId": imagenPublicId,
    "precioBase": precioBase,
  };
}
