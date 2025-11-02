import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Components/tarjeta_de_reporte.dart';
import 'package:proyectocosasperdidas/database.dart';
import 'dart:developer' as dev;

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
    DataBase db = DataBase();
    // Scaffold proporciona una estructura básica para la pantalla, en este caso con una AppBar y un Body
    return Scaffold(
      // AppBar que contiene un título centrado
      appBar: AppBar(title: const Text("Mediador"), centerTitle: true),
      // Body que contiene un Center con un texto
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Lista de objetos encontrados (Vista Admin)
          ListaReportes(getReporte: db.getReporteEncontrado,size: 9),
          //Lista de objetos perdidos (Vista Perdedor)
          ListaReportes(getReporte: db.getReportePerdido, size: 6)
        ],
      ),
    );
  }
}

class ListaReportes extends StatelessWidget {
  final Function(int) getReporte;
  final int size;
  const ListaReportes({super.key, required this.getReporte, required this.size});

  @override
  Widget build(BuildContext context) {
    dev.log("$size");
    return Expanded(
      child: ListView.builder(
        itemCount: size,
        itemBuilder: (context, index) {
          return TarjetaDeReporte.fromReporte(getReporte(0));
        },
      ),
    );
  }
}