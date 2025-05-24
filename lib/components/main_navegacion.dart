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
      home: HomePage(),

    );
  }
}
/*class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class Usuario {
  final String nombre;
  final int edad;
  Usuario(this.nombre, this.edad);
}*/

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Página Principal')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push( context,
              MaterialPageRoute(
                builder: (context) => SecondPage(message: '¡Hola desde la página principal!'),
              ),
            );
          },
          child: Text('Ir a la Segunda Página'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String message;
  SecondPage({required this.message});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Segunda Página')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Regresar a la Página Principal'),
            ),
          ],
        ),
      ),
    );
  }
}

/*class _MyHomePageState extends State<MyHomePage> {
  final List<Usuario> usuarios = [
    Usuario('Juan', 25),
    Usuario('Ana', 30),
    Usuario('Pedro', 28),
    Usuario('María', 22),
    Usuario('Luis', 35),
    Usuario('Sofía', 27),
    Usuario('Javier', 33),
    Usuario('Lucía', 29),
    Usuario('Carlos', 31),
  ];

}*/