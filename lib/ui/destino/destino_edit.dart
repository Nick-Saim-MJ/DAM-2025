import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:granturismo/modelo/DestinoModelo.dart';
import 'package:granturismo/apis/destino_api.dart';
import 'package:granturismo/util/TokenUtil.dart';

class DestinoFormEdit extends StatefulWidget {
  DestinoResp modelA;
  DestinoFormEdit({required this.modelA});
  @override
  _DestinoFormEditState createState() => _DestinoFormEditState(modelA: modelA);
}

class _DestinoFormEditState extends State<DestinoFormEdit> {
  DestinoResp modelA;
  _DestinoFormEditState({required this.modelA});

  final _formKey = GlobalKey<FormState>();
  Position? currentPosition;

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();
  final TextEditingController _imagenUrlController = TextEditingController();
  final TextEditingController _latitudController = TextEditingController();
  final TextEditingController _longitudController = TextEditingController();
  final TextEditingController _popularidadController = TextEditingController();
  final TextEditingController _precioMedioController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarDatosIniciales();
    _obtenerUbicacion();
  }

  void _cargarDatosIniciales() {
    _nombreController.text = modelA.nombre;
    _descripcionController.text = modelA.descripcion;
    _ubicacionController.text = modelA.ubicacion;
    _imagenUrlController.text = modelA.imagenUrl;
    _latitudController.text = modelA.latitud.toString();
    _longitudController.text = modelA.longitud.toString();
    _popularidadController.text = modelA.popularidad.toString();
    _precioMedioController.text = modelA.preciomedio.toString();
    _ratingController.text = modelA.rating.toString();
  }

  Future<void> _obtenerUbicacion() async {
    final permiso = await Geolocator.requestPermission();
    if (permiso == LocationPermission.denied || permiso == LocationPermission.deniedForever) return;

    final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = pos;
      _latitudController.text = pos.latitude.toString();
      _longitudController.text = pos.longitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Destino")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _campoTexto("Nombre", _nombreController),
              _campoTexto("Descripción", _descripcionController),
              _campoTexto("Ubicación", _ubicacionController),
              _campoTexto("Imagen URL", _imagenUrlController),
              _campoTexto("Latitud", _latitudController, tipo: TextInputType.number),
              _campoTexto("Longitud", _longitudController, tipo: TextInputType.number),
              _campoTexto("Popularidad", _popularidadController, tipo: TextInputType.number),
              _campoTexto("Precio Medio", _precioMedioController, tipo: TextInputType.number),
              _campoTexto("Rating", _ratingController, tipo: TextInputType.number),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar"),
                  ),
                  ElevatedButton(
                    onPressed: _guardarDestino,
                    child: const Text("Guardar"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _campoTexto(String label, TextEditingController controller, {TextInputType tipo = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: tipo,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
      ),
    );
  }

  void _guardarDestino() async {
    if (!_formKey.currentState!.validate()) return;

    final destinoDto = DestinoDto.unlaunched(); // o crea constructor normal
    destinoDto.nombre = _nombreController.text;
    destinoDto.descripcion = _descripcionController.text;
    destinoDto.ubicacion = _ubicacionController.text;
    destinoDto.imagenUrl = _imagenUrlController.text;
    destinoDto.latitud = double.tryParse(_latitudController.text) ?? 0.0;
    destinoDto.longitud = double.tryParse(_longitudController.text) ?? 0.0;
    destinoDto.popularidad = int.tryParse(_popularidadController.text) ?? 0;
    destinoDto.preciomedio = double.tryParse(_precioMedioController.text) ?? 0.0;
    destinoDto.rating = double.tryParse(_ratingController.text) ?? 0.0;

    try {
      final api = Provider.of<DestinoApi>(context, listen: false);
      final respuesta = await api.updateDestino(TokenUtil.TOKEN, modelA.idDestino, destinoDto);
      if (respuesta != null) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar destino: $e")),
      );
    }
  }
}
