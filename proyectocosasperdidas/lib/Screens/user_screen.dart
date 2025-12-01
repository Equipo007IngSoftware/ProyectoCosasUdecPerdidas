import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Components/estado.dart';
import 'package:proyectocosasperdidas/Screens/form.dart';

class UserScreen extends StatefulWidget {
  // Constructor de la clase UserScreen
  const UserScreen({super.key});

  // Metodo para crear el estado mutable de este widget
  @override
  State<UserScreen> createState() => _UserScreen();
}

class _UserScreen extends State<UserScreen> {
  // Metodo build que describe la parte de la interfaz de usuario representada por este widget
  @override
  Widget build(BuildContext context) {
    // Scaffold proporciona una estructura básica para la pantalla, en este caso con una AppBar y un Body
    return Scaffold(
      // AppBar que contiene un título centrado
      appBar: AppBar(
        title: const Text("Proyecto cosas perdidas UdeC"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade600,
      ),
      // Body que contiene un Center con un texto
      body: Center(
        child: Column(
          children: [
            //const Text("Pantalla de Usuario"),
            //Boton que lleva a Formulario
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  //se abre un formulario en modo de objeto encontrado
                  MaterialPageRoute(
                    builder: (context) => Formulario(tipo: Estado.perdido),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
              child: const Text("Crear Reporte"),
            ),
          ],
        ),
      ),
    );
  }
}
