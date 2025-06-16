import 'package:dio/dio.dart';
import 'package:granturismo/apis/actividad_api.dart';
import 'package:granturismo/modelo/ActividadModelo.dart';
import 'package:granturismo/modelo/MessageModelo.dart';
import 'package:granturismo/util/TokenUtil.dart';

class Actividadrepository{
  ActividadApi? actividadApi;

  ActividadRepository(){
    Dio _dio=Dio();
    _dio.options.headers["Content-Type"]="application/json";
    actividadApi=ActividadApi(_dio);
  }

  Future<List<ActividadResp>> getEntidad() async{
    return await actividadApi!.getActividad(TokenUtil.TOKEN).then((value)=>value);
  }

  Future<Message> deleteEntidad(int id) async{
    return await actividadApi!.deleteActividad(TokenUtil.TOKEN, id);
  }

  Future<ActividadResp> updateEntidad(int id, ActividadDto actividad) async{
    return await actividadApi!.updateActividad(TokenUtil.TOKEN, id, actividad);
  }

  Future<Message> createEntidad(ActividadDto actividad) async{
    return await actividadApi!.crearActividad(TokenUtil.TOKEN, actividad);
  }

}