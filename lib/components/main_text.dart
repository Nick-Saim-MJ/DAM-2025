import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  int _selectedIndex = 0;

// Lista de widgets para mostrar en el cuerpo según el índice seleccionado
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Página 1: Inicio', style: TextStyle(fontSize: 30)),
    Text('Página 2: Perfil', style: TextStyle(fontSize: 30)),
    Text('Página 3: Ajustes', style: TextStyle(fontSize: 30)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      //Navigator.pop(context);
    });
  }

  void _onItemTappedDra(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(
          context); // Cierra el Drawer cuando se selecciona una opción
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ejemplo de Texto Simple')),
      body:
      Center(
        child: RichText(
          text: TextSpan(
            text: 'Este es un ',
            style: TextStyle(fontSize: 24, color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                text: 'texto ',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              TextSpan(
                text: 'rico ',
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Colors.green),
              ),
              TextSpan(
                text: 'en ?.',
                style: TextStyle(
                    decoration: TextDecoration.underline, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}