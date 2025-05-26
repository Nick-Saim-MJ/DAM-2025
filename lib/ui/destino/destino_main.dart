import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:granturismo/apis/destino_api.dart';
import 'package:granturismo/modelo/DestinoModelo.dart';
import 'package:granturismo/theme/AppTheme.dart';
import 'package:granturismo/util/TokenUtil.dart';
import 'package:granturismo/ui/destino/destino_form.dart';
import 'package:granturismo/ui/destino/destino_edit.dart';

class MainDestino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DestinoApi>(create: (_) => DestinoApi.create()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
        theme: AppTheme.themeDataLight,
        darkTheme: AppTheme.themeDataDark,
        home: DestinoUI(),
      ),
    );
  }
}

class DestinoUI extends StatefulWidget {
  @override
  _DestinoUIState createState() => _DestinoUIState();
}

class _DestinoUIState extends State<DestinoUI> {
  late DestinoApi apiService;
  List<DestinoResp> destinos = [];
  List<DestinoResp> filteredDestinos = [];
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

    final api = Provider.of<DestinoApi>(context, listen: false);
    final data = await api.getDestino(TokenUtil.TOKEN);

    setState(() {
      destinos = data;
      filteredDestinos = List.from(destinos);
      _isLoading = false;
    });
  }

  void updateList(String value) {
    setState(() {
      filteredDestinos = destinos.where((dest) =>
      dest.nombre.toLowerCase().contains(value.toLowerCase()) ||
          dest.ubicacion.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  Future onGoBack(dynamic value) async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Destinos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DestinoForm()),
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
                hintText: 'Buscar destinos...',
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
              itemCount: filteredDestinos.length,
              itemBuilder: (context, index) {
                final destino = filteredDestinos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                      AssetImage("assets/imagen/location-icon.png"),
                    ),
                    title: Text(destino.nombre),
                    subtitle: Text(destino.ubicacion),
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
                                    DestinoFormEdit(modelA: destino),
                              ),
                            ).then(onGoBack);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _confirmDelete(context, destino);
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

  void _confirmDelete(BuildContext context, DestinoResp destino) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Confirmación"),
        content: Text("¿Deseas eliminar este destino?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await Provider.of<DestinoApi>(context, listen: false)
                  .deleteDestino(TokenUtil.TOKEN, destino.idDestino);
              _loadData();
            },
            child: Text("Eliminar"),
          ),
        ],
      ),
    );
  }
}
