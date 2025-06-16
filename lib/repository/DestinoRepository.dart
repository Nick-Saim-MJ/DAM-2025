import 'package:dio/dio.dart';
import 'package:granturismo/apis/destino_api.dart';
import 'package:granturismo/modelo/MessageModelo.dart';
import 'package:granturismo/modelo/DestinoModelo.dart';
import 'package:granturismo/util/TokenUtil.dart';

class DestinoRepository{
  DestinoApi? destinoApi;

  DestinoRepository(){
    Dio _dio=Dio();
    _dio.options.headers["Content-Type"]="application/json";
    destinoApi=DestinoApi(_dio);
  }

  Future<List<DestinoResp>> getEntidad() async{
    return await destinoApi!.getDestino(TokenUtil.TOKEN).then((value)=>value);
  }

  Future<Message> deleteEntidad(int id) async{
    return await destinoApi!.deleteDestino(TokenUtil.TOKEN, id);
  }

  Future<DestinoResp> updateEntidad(int id, DestinoDto destino) async{
    return await destinoApi!.updateDestino(TokenUtil.TOKEN, id, destino);
  }

  Future<Message> createEntidad(DestinoDto destino) async{
    return await destinoApi!.crearDestino(TokenUtil.TOKEN, destino);
  }

}