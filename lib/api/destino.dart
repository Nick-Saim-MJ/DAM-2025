import 'package:dio/dio.dart';
import 'package:flutter_demo/destino.dart'; // Asegúrate de que esta ruta sea correcta
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

part 'destino.g.dart'; // Este archivo se generará con build_runner

@RestApi(baseUrl: "http://172.22.2.1:8080/") // Reemplaza con la URL de tu API
abstract class DestinoApi {
  factory DestinoApi(Dio dio, {String baseUrl}) = _DestinoApi;

  static DestinoApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return DestinoApi(dio);
  }

  @GET("/destinos") // Endpoint para obtener la lista de destinos
  Future<List<DestinoDTO>> listar();
}
