import 'package:granturismo/modelo/ActividadModelo.dart';
import 'package:granturismo/modelo/MessageModelo.dart';
import 'package:granturismo/util/UrlApi.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'actividad_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class ActividadApi {
  factory ActividadApi(Dio dio, {String baseUrl}) = _ActividadApi;

  static ActividadApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ActividadApi(dio);
  }

  @GET("/actividad")
  Future<List<ActividadResp>> getActividad(@Header("Authorization") String token);

  @POST("/actividad")
  Future<Message> crearActividad(@Header("Authorization") String token, @Body() ActividadDto actividad);

  @GET("/actividad/{id}")
  Future<ActividadResp> findActividad(@Header("Authorization") String token, @Path("id") int id);

  @DELETE("/actividad/{id}")
  Future<Message> deleteActividad(@Header("Authorization") String token, @Path("id") int id);

  @PUT("/actividad/{id}")
  Future<ActividadResp> updateActividad(@Header("Authorization") String token, @Path("id") int id, @Body() ActividadDto actividad);

}
