import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:granturismo/apis/actividad_api.dart';
import 'package:granturismo/modelo/ActividadModelo.dart';
import 'package:granturismo/theme/AppTheme.dart';
import 'package:granturismo/util/TokenUtil.dart';
import 'package:granturismo/ui/actividad/actividad_form.dart';
import 'package:granturismo/ui/actividad/actividad_edit.dart';

class MainActividad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ActividadApi>(create: (_) => ActividadApi.create()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
        theme: AppTheme.themeDataLight,
        darkTheme: AppTheme.themeDataDark,
        home: ActividadUI(),
      ),
    );
  }
}

class ActividadUI extends StatefulWidget {
  @override
  _ActividadUIState createState() => _ActividadUIState();
}

class _ActividadUIState extends State<ActividadUI> {
  late ActividadApi apiService;
  List<ActividadResp> actividades = [];
  List<ActividadResp> filteredActividades = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    final api = Provider.of<ActividadApi>(context, listen: false);
    final data = await api.getActividad(TokenUtil.TOKEN);

    setState(() {
      actividades = data;
      filteredActividades = List.from(actividades);
      _isLoading = false;
    });
  }

  void updateList(String value) {
    setState(() {
      filteredActividades = actividades.where((actividad) =>
      actividad.titulo.toLowerCase().contains(value.toLowerCase()) ||
          actividad.tipo.toLowerCase().contains(value.toLowerCase())).toList();  // Cambiado de nombre y ubicacion a titulo y tipo
    });
  }

  Future onGoBack(dynamic value) async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Actividades'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ActividadForm()),
              ).then(onGoBack);
            },
          ),
        ],
      ),
      backgroundColor: AppTheme.nearlyWhite,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onChanged: updateList,
              decoration: InputDecoration(
                hintText: 'Buscar actividades...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    updateList('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredActividades.length,
              itemBuilder: (context, index) {
                final actividad = filteredActividades[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                      AssetImage("assets/imagen/location-icon.png"),
                    ),
                    title: Text(actividad.titulo),
                    subtitle: Text(actividad.tipo),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ActividadFormEdit(modelA: actividad),
                              ),
                            ).then(onGoBack);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _confirmDelete(context, actividad);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, ActividadResp actividad) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Confirmación"),
        content: Text("¿Deseas eliminar esta actividad?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await Provider.of<ActividadApi>(context, listen: false)
                  .deleteActividad(TokenUtil.TOKEN, actividad.idActividad);
              _loadData();
            },
            child: Text("Eliminar"),
          ),
        ],
      ),
    );
  }
}
