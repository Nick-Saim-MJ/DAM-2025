import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:granturismo/apis/actividad_api.dart';
import 'package:granturismo/modelo/ActividadModelo.dart';
import 'package:granturismo/util/TokenUtil.dart';

class ActividadForm extends StatefulWidget {
  const ActividadForm({super.key});

  @override
  State<ActividadForm> createState() => _ActividadFormState();
}

class _ActividadFormState extends State<ActividadForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final tituloController = TextEditingController();
  final descripcionController = TextEditingController();
  final tipoController = TextEditingController();
  final imagenUrlController = TextEditingController();
  final duracionHorasController = TextEditingController();
  final imagenPublicIdController = TextEditingController();
  final precioBaseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Actividad')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(tituloController, 'Título', true),
              _buildTextField(descripcionController, 'Descripción', true),
              _buildTextField(tipoController, 'Tipo', false),
              _buildTextField(imagenUrlController, 'Imagen URL', false),
              _buildNumberField(duracionHorasController, 'Duración (Horas)'),
              _buildTextField(imagenPublicIdController, 'Imagen Public ID', false),
              _buildNumberField(precioBaseController, 'Precio Base'),

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
                    onPressed: _registrarActividad,
                    child: const Text('Guardar'),
                  ),
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

  void _registrarActividad() async {
    if (_formKey.currentState!.validate()) {
      final actividad = ActividadDto(
        titulo: tituloController.text,
        descripcion: descripcionController.text,
        tipo: tipoController.text,
        duracionHoras: int.tryParse(duracionHorasController.text) ?? 0,
        imagenUrl: imagenUrlController.text,
        imagenPublicId: imagenPublicIdController.text.isEmpty
            ? null
            : imagenPublicIdController.text,
        precioBase: double.tryParse(precioBaseController.text) ?? 0.0,
      );

      var api = await Provider.of<ActividadApi>(context, listen: false)
          .crearActividad(TokenUtil.TOKEN, actividad);

      if (api.toJson() != null) {
        Navigator.pop(context, () {
          setState(() {});
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Actividad registrada exitosamente')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complete todos los campos requeridos')),
      );
    }
  }
}
