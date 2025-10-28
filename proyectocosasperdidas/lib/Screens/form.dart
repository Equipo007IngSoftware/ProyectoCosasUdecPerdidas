import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Components/Imagen.dart';
import 'package:proyectocosasperdidas/Components/estado.dart';
import 'package:proyectocosasperdidas/Components/reporte.dart';
import 'package:proyectocosasperdidas/Components/categorias.dart';

///Pantalla de Formulario
///
///permite rellenar campos para crear un reporte<br />
///y luego enviarlo
class Formulario extends StatelessWidget {
  final Estado tipo;

  const Formulario({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulario"), centerTitle: true),
      body: Center(child: Column(
        children: [
          const Text("aqui va el formulario"),
          const MenuCategoria(),
          const MenuImagen(),
          Text((tipo==Estado.perdido)?"modo perdedor":"soy admin"),
        ],
      )),
    );
  }
}