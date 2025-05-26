class DestinoResp {
  DestinoResp({
    required this.idDestino,
    required this.nombre,
    required this.descripcion,
    required this.ubicacion,
    required this.imagenUrl,
    required this.latitud,
    required this.longitud,
    required this.popularidad,
    required this.preciomedio,
    required this.rating,
  });

  final int idDestino;
  final String nombre;
  final String descripcion;
  final String ubicacion;
  final String imagenUrl;
  final double latitud;
  final double longitud;
  final int popularidad;
  final double preciomedio;
  final double rating;

  factory DestinoResp.fromJson(Map<String, dynamic> json) {
    return DestinoResp(
      idDestino: json["idDestino"],
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      ubicacion: json["ubicacion"],
      imagenUrl: json["imagenUrl"],
      latitud: (json["latitud"] ?? 0).toDouble(),
      longitud: (json["longitud"] ?? 0).toDouble(),
      popularidad: json["popularidad"] ?? 0,
      preciomedio: (json["preciomedio"] ?? 0).toDouble(),
      rating: (json["rating"] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "descripcion": descripcion,
    "ubicacion": ubicacion,
    "imagenUrl": imagenUrl,
    "latitud": latitud,
    "longitud": longitud,
    "popularidad": popularidad,
    "preciomedio": preciomedio,
    "rating": rating,
  };
}

class DestinoDto {
  DestinoDto({
    required this.nombre,
    required this.descripcion,
    required this.ubicacion,
    required this.imagenUrl,
    required this.latitud,
    required this.longitud,
    required this.popularidad,
    required this.preciomedio,
    required this.rating,
  });

  late String nombre;
  late String descripcion;
  late String ubicacion;
  late String imagenUrl;
  late double latitud;
  late double longitud;
  late int popularidad;
  late double preciomedio;
  late double rating;

  DestinoDto.unlaunched();

  factory DestinoDto.fromJson(Map<String, dynamic> json) {
    return DestinoDto(
      nombre: json["nombre"],
      descripcion: json["descripcion"],
      ubicacion: json["ubicacion"],
      imagenUrl: json["imagenUrl"],
      latitud: (json["latitud"] ?? 0).toDouble(),
      longitud: (json["longitud"] ?? 0).toDouble(),
      popularidad: json["popularidad"] ?? 0,
      preciomedio: (json["preciomedio"] ?? 0).toDouble(),
      rating: (json["rating"] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "descripcion": descripcion,
    "ubicacion": ubicacion,
    "imagenUrl": imagenUrl,
    "latitud": latitud,
    "longitud": longitud,
    "popularidad": popularidad,
    "preciomedio": preciomedio,
    "rating": rating,
  };
}
