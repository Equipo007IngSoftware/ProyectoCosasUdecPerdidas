import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Scaffold proporciona una estructura básica para la pantalla, en este caso con una AppBar y un Body
    return Scaffold(
      //appBar simplemente tiene un título centrado
      appBar: AppBar(
        title: const Text("Proyecto Cosas Perdidas"),
        centerTitle: true, // Centra el título
      ),
      //Center simplemente centra su hijo en el plano horizontal y vertical
      body: Center(
        //Column organiza sus hijos en una columna vertical
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Centra los hijos de la columna tanto horizontal como verticalmente
          children: <Widget>[
            // Boton
            ElevatedButton(
              // Acción al presionar el botón
              onPressed: () {},
              // Estilo personalizado para el botón
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                // Añade padding (espacio) alrededor del texto del botón
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
              // Texto del botón
              child: const Text("Administrador"),
            ),
          ],
        ),
      ),
    );
  }
}
