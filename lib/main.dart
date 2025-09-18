import 'package:flutter/material.dart';
import 'worker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Lista de trabajadores
  final List<Worker> _workers = [];

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();

  void _addWorker() {
    final idText = _idController.text;
    final nombre = _nombreController.text;
    final apellidos = _apellidosController.text;
    final edadText = _edadController.text;

    if (idText.isEmpty || nombre.isEmpty || apellidos.isEmpty || edadText.isEmpty) return;
    final id = int.tryParse(idText);
    final edad = int.tryParse(edadText);
    if (id == null || edad == null) return;
    if (_workers.any((w) => w.id == id)) return;
    if (edad < 18) return;
    setState(() {
      _workers.add(Worker(id: id, nombre: nombre, apellidos: apellidos, edad: edad));
      _idController.clear();
      _nombreController.clear();
      _apellidosController.clear();
      _edadController.clear();
    });
  }

  void _removeLastWorker() {
    setState(() {
      if (_workers.isNotEmpty) {
        _workers.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trabajadores'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _idController,
                decoration: InputDecoration(labelText: "ID"),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: "Nombre"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _apellidosController,
                decoration: InputDecoration(labelText: "Apellidos"),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _edadController,
                decoration: InputDecoration(labelText: "Edad"),
                keyboardType: TextInputType.number,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _addWorker,
                  child: Text("Agregar"),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _removeLastWorker,
                  child: Text("Eliminar último"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Lista de trabajadores:"),
            for (var w in _workers)
              Text("ID: ${w.id}, Nombre: ${w.nombre}, Apellidos: ${w.apellidos}, Edad: ${w.edad}"),
          ],
        ),
      ),
    );
}
}