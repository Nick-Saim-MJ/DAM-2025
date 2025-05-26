import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:granturismo/apis/destino_api.dart';
import 'package:granturismo/modelo/DestinoModelo.dart';
import 'package:granturismo/util/TokenUtil.dart';

class DestinoForm extends StatefulWidget {
  const DestinoForm({super.key});

  @override
  State<DestinoForm> createState() => _DestinoFormState();
}

class _DestinoFormState extends State<DestinoForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final nombreController = TextEditingController();
  final descripcionController = TextEditingController();
  final ubicacionController = TextEditingController();
  final imagenUrlController = TextEditingController();
  final latitudController = TextEditingController();
  final longitudController = TextEditingController();
  final popularidadController = TextEditingController();
  final precioMedioController = TextEditingController();
  final ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Destino')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(nombreController, 'Nombre', true),
              _buildTextField(descripcionController, 'Descripción', true),
              _buildTextField(ubicacionController, 'Ubicación', false),
              _buildTextField(imagenUrlController, 'Imagen URL', false),
              _buildNumberField(latitudController, 'Latitud'),
              _buildNumberField(longitudController, 'Longitud'),
              _buildNumberField(popularidadController, 'Popularidad'),
              _buildNumberField(precioMedioController, 'Precio Medio'),
              _buildNumberField(ratingController, 'Rating'),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: _registrarDestino,
                    child: const Text('Guardar'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, bool required) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: required
          ? (value) => value!.isEmpty ? 'Campo requerido' : null
          : null,
    );
  }

  Widget _buildNumberField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      validator: (value) =>
      value!.isEmpty ? 'Campo requerido' : null,
    );
  }

  void _registrarDestino() async {
    if (_formKey.currentState!.validate()) {
      final destino = DestinoDto(
        nombre: nombreController.text,
        descripcion: descripcionController.text,
        ubicacion: ubicacionController.text,
        imagenUrl: imagenUrlController.text,
        latitud: double.tryParse(latitudController.text) ?? 0.0,
        longitud: double.tryParse(longitudController.text) ?? 0.0,
        popularidad: int.tryParse(popularidadController.text) ?? 0,
        preciomedio: double.tryParse(precioMedioController.text) ?? 0.0,
        rating: double.tryParse(ratingController.text) ?? 0.0,
      );

      var api = await Provider.of<DestinoApi>(context, listen: false)
          .crearDestino(TokenUtil.TOKEN, destino);

      if (api.toJson() != null) {
        Navigator.pop(context, () {
          setState(() {});
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Destino registrado exitosamente')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complete todos los campos requeridos')),
      );
    }
  }
}
