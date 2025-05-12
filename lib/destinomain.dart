import 'package:dio/dio.dart';
import 'package:flutter_demo/api/destino.dart';
import 'package:flutter_demo/destino.dart';

void main() async {
  final dio = Dio();

  // Aquí es donde agregas el token de autorización
  dio.options.headers = {
    'Authorization': 'Bearer eyJhbGciOiJIUzM4NCJ9.eyJyb2xlIjoiVVNFUiIsInRlc3QiOiJzeXNjZW50ZXJsaWZlLXZhbHVlLXRlc3QiLCJzdWIiOiJuaWNrc2FpbTY5QGdtYWlsLmNvbSIsImlhdCI6MTc0NzA3MTYyMSwiZXhwIjoxNzQ3MDg5NjIxfQ.IyOCY0hZ3idl7xd2d078tYm_QiS9iO5vQtrh4iYzWDd172Hm291GqbtNzoWGgjuq',
  };

  final apiService = DestinoApi(dio); // Usa DestinoApi en lugar de UsuarioApi

  try {
    // Realiza la solicitud para obtener la lista de destinos
    final response = await apiService.listar();

    // Si la solicitud fue exitosa, imprimimos la respuesta
    print("Response: $response");

    // Iterar y mostrar los detalles de cada destino
    for (var destino in response) {
      print('ID: ${destino.idDestino}, Nombre: ${destino.nombre}, Ubicación: ${destino.ubicacion}');
    }
  } catch (e) {
    // En caso de error, imprimir el error con más detalles
    print('Error: $e');

    if (e is DioError) {
      // Aquí imprimimos el código de estado y el contenido de la respuesta
      print('Status code: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
    }
  }
}
