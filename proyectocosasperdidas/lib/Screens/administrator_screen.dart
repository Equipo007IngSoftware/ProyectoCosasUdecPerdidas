import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Components/categorias.dart';

class AdministratorScreen extends StatefulWidget {
  // Constructor de la clase AdministratorScreen
  const AdministratorScreen({super.key});

  // Metodo para crear el estado mutable de este widget
  @override
  State<AdministratorScreen> createState() => _AdministratorScreen();
}

// Clase privada que maneja el estado de AdministratorScreen
class _AdministratorScreen extends State<AdministratorScreen> {
  // Metodo build que describe la parte de la interfaz de usuario representada por este widget
  @override
  Widget build(BuildContext context) {
    // Scaffold proporciona una estructura básica para la pantalla, en este caso con una AppBar y un Body
    return Scaffold(
      // AppBar que contiene un título centrado
      appBar: AppBar(title: const Text("Administrador"), centerTitle: true),
      // Body que contiene un Center con un texto
      body: const Center(child: Column(
        children: [
          Text("Pantalla de Administrador"),
          MenuCategoria(),
        ],
      )),
    );
  }
}
