import 'package:json_annotation/json_annotation.dart';
import 'package:decimal/decimal.dart'; // Usar la librería 'decimal' para manejar BigDecimal en Dart

@JsonSerializable()
class DestinoDTO {
  int? idDestino;  // Cambio Long a int
  String? nombre;
  String? descripcion;
  String? ubicacion;
  String? imagenUrl;
  double? latitud;
  double? longitud;
  int? popularidad;
  Decimal? preciomedio;  // Usamos Decimal para manejar valores decimales de forma precisa
  double? rating;

  DestinoDTO({
    this.idDestino,
    this.nombre,
    this.descripcion,
    this.ubicacion,
    this.imagenUrl,
    this.latitud,
    this.longitud,
    this.popularidad,
    this.preciomedio,
    this.rating,
  });

  // Constructor fromJson para convertir el JSON a un objeto
  DestinoDTO.fromJson(Map<String, dynamic> json) {
    idDestino = json['idDestino'];
    nombre = json['nombre'];
    descripcion = json['descripcion'];
    ubicacion = json['ubicacion'];
    imagenUrl = json['imagenUrl'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    popularidad = json['popularidad'];
    preciomedio = json['preciomedio'] != null ? Decimal.parse(json['preciomedio'].toString()) : null;
    rating = json['rating'];
  }

  // Factory para convertir el JSON a una instancia de DestinoDTO
  factory DestinoDTO.fromJsonModelo(Map<String, dynamic> json) {
    return DestinoDTO(
      idDestino: json['idDestino'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      ubicacion: json['ubicacion'],
      imagenUrl: json['imagenUrl'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      popularidad: json['popularidad'],
      preciomedio: json['preciomedio'] != null ? Decimal.parse(json['preciomedio'].toString()) : null,
      rating: json['rating'],
    );
  }

  // Método toJson para convertir el objeto a un mapa JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDestino'] = this.idDestino;
    data['nombre'] = this.nombre;
    data['descripcion'] = this.descripcion;
    data['ubicacion'] = this.ubicacion;
    data['imagenUrl'] = this.imagenUrl;
    data['latitud'] = this.latitud;
    data['longitud'] = this.longitud;
    data['popularidad'] = this.popularidad;
    data['preciomedio'] = this.preciomedio?.toString();  // Convertir Decimal a String
    data['rating'] = this.rating;
    return data;
  }
}
