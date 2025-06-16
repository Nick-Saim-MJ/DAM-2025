import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Still useful if you want location for activities
import 'package:provider/provider.dart';
import 'package:granturismo/modelo/ActividadModelo.dart'; // Import the correct Actividad models
import 'package:granturismo/apis/actividad_api.dart'; // Import the correct Actividad API
import 'package:granturismo/util/TokenUtil.dart';

class ActividadFormEdit extends StatefulWidget {
  final ActividadResp modelA;

  // Constructor name changed
  const ActividadFormEdit({super.key, required this.modelA});

  @override
  // State class name and constructor parameter type changed
  _ActividadFormEditState createState() => _ActividadFormEditState(modelA: modelA);
}


class _ActividadFormEditState extends State<ActividadFormEdit> {
  final ActividadResp modelA;
  _ActividadFormEditState({required this.modelA});

  final _formKey = GlobalKey<FormState>();
  Position? currentPosition; // Keep if location is relevant for activities

  // --- TextEditingControllers for Actividad fields ---
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _duracionHorasController = TextEditingController();
  final TextEditingController _imagenUrlController = TextEditingController();
  final TextEditingController _imagenPublicIdController = TextEditingController(); // New: for imagenPublicId
  final TextEditingController _precioBaseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarDatosIniciales();
    // Decide if you need location for activities. If not, remove _obtenerUbicacion() call.
    _obtenerUbicacion();
  }

  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _tipoController.dispose();
    _duracionHorasController.dispose();
    _imagenUrlController.dispose();
    _imagenPublicIdController.dispose();
    _precioBaseController.dispose();
    super.dispose();
  }

  void _cargarDatosIniciales() {
    // Assign initial values from ActividadResp model
    _tituloController.text = modelA.titulo;
    _descripcionController.text = modelA.descripcion;
    _tipoController.text = modelA.tipo;
    _duracionHorasController.text = modelA.duracionHoras.toString();
    _imagenUrlController.text = modelA.imagenUrl;
    _imagenPublicIdController.text = modelA.imagenPublicId ?? ''; // Handle nullable field
    _precioBaseController.text = modelA.precioBase.toString();
  }

  Future<void> _obtenerUbicacion() async {
    // This part is for geographical location (lat/lon).
    // If 'Actividad' does not have lat/lon, you might want to remove this method
    // and the corresponding controllers from this form.
    // For now, I'm keeping it but you should decide its relevance.
    final permiso = await Geolocator.requestPermission();
    if (permiso == LocationPermission.denied || permiso == LocationPermission.deniedForever) return;

    final pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = pos;
      // If you decide to keep lat/lon for Actividad, assign them here
      // For now, these controllers are removed from the Actividad model.
      // If you add lat/lon to Actividad, you'd add:
      // _latitudController.text = pos.latitude.toString();
      // _longitudController.text = pos.longitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Actividad")), // Changed title
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _campoTexto("Título", _tituloController),
              _campoTexto("Descripción", _descripcionController),
              _campoTexto("Tipo", _tipoController),
              _campoTexto("Duración (Horas)", _duracionHorasController, tipo: TextInputType.number),
              _campoTexto("Imagen URL", _imagenUrlController),
              _campoTexto("ID Público Imagen", _imagenPublicIdController), // New field
              _campoTexto("Precio Base", _precioBaseController, tipo: TextInputType.number),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancelar"),
                  ),
                  ElevatedButton(
                    onPressed: _guardarActividad, // Changed method call
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
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
      ),
    );
  }

  void _guardarActividad() async {
    if (!_formKey.currentState!.validate()) return;

    // Create ActividadDto from form fields
    final actividadDto = ActividadDto(
      titulo: _tituloController.text,
      descripcion: _descripcionController.text,
      tipo: _tipoController.text,
      duracionHoras: int.tryParse(_duracionHorasController.text) ?? 0,
      imagenUrl: _imagenUrlController.text,
      imagenPublicId: _imagenPublicIdController.text.isEmpty ? null : _imagenPublicIdController.text, // Handle empty string to null for nullable backend field
      precioBase: double.tryParse(_precioBaseController.text) ?? 0.0,
    );

    try {
      // Use ActividadApi and its updateActividad method
      final api = Provider.of<ActividadApi>(context, listen: false);
      final respuesta = await api.updateActividad(TokenUtil.TOKEN, modelA.idActividad, actividadDto); // Pass idActividad
      if (respuesta != null) {
        // If successful, pop the screen and potentially return true
        Navigator.pop(context, true);
      }
    } catch (e) {
      // Show error message if saving fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al guardar actividad: $e")),
      );
      debugPrint("Error al guardar actividad: $e"); // For debugging purposes
    }
  }
}