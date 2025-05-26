import 'package:granturismo/modelo/DestinoModelo.dart';
import 'package:granturismo/modelo/MessageModelo.dart';
import 'package:granturismo/util/UrlApi.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'destino_api.g.dart';

@RestApi(baseUrl: UrlApi.urlApix)
abstract class DestinoApi{
  factory DestinoApi(Dio dio, {String baseUrl})=_DestinoApi;

  static DestinoApi create(){
    final dio=Dio();
    dio.interceptors.add(PrettyDioLogger());
    return DestinoApi(dio);
  }

  @GET("/destinos")
  Future<List<DestinoResp>> getDestino(@Header("Authorization") String token);

  @POST("/destinos")
  Future<Message> crearDestino(@Header("Authorization") String token, @Body() DestinoDto destino);

  @GET("/destinos/{id}")
  Future<DestinoResp> findDestino(@Header("Authorization") String token, @Path("id") int id);

  @DELETE("/destinos/{id}")
  Future<Message> deleteDestino(@Header("Authorization") String token, @Path("id") int id );

  @PUT("/destinos/{id}")
  Future<DestinoResp> updateDestino(@Header("Authorization") String token, @Path("id") int id, @Body() DestinoDto destino);

}
