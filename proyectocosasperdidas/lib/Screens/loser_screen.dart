import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Components/categorias.dart';

class LoserScreen extends StatefulWidget {
  // Constructor de la clase LoserScreen
  const LoserScreen({super.key});

  // Metodo para crear el estado mutable de este widget
  @override
  State<LoserScreen> createState() => _LoserScreen();
}

class _LoserScreen extends State<LoserScreen> {
  // Metodo build que describe la parte de la interfaz de usuario representada por este widget
  @override
  Widget build(BuildContext context) {
    // Scaffold proporciona una estructura básica para la pantalla, en este caso con una AppBar y un Body
    return Scaffold(
      // AppBar que contiene un título centrado
      appBar: AppBar(title: const Text("Perdedor"), centerTitle: true),
      // Body que contiene un Center con un texto
      body: const Center(child: Column(
        children: [
          Text("Pantalla de Perdedor"),
          MenuCategoria(),
        ],
      )),
    );
  }
}
