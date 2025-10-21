import 'package:flutter/material.dart';

class MediatorScreen extends StatefulWidget {
  // Constructor de la clase MediatorScreen
  const MediatorScreen({super.key});

  // Metodo para crear el estado mutable de este widget
  @override
  State<MediatorScreen> createState() => _MediatorScreen();
}

// Clase privada que maneja el estado de MediatorScreen
class _MediatorScreen extends State<MediatorScreen> {
  // Metodo build que describe la parte de la interfaz de usuario representada por este widget
  @override
  Widget build(BuildContext context) {
    // Scaffold proporciona una estructura básica para la pantalla, en este caso con una AppBar y un Body
    return Scaffold(
      // AppBar que contiene un título centrado
      appBar: AppBar(title: const Text("Mediador"), centerTitle: true),
      // Body que contiene un Center con un texto
      body: const Center(child: Text("Pantalla de Mediador")),
    );
  }
}
