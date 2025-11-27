import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Screens/user_screen.dart';
import 'package:proyectocosasperdidas/screens/mediator_screen.dart';
import 'administrator_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Scaffold proporciona una estructura básica para la pantalla, en este caso con una AppBar y un Body
    return Scaffold(
      //appBar simplemente tiene un título centrado
      appBar: AppBar(
        title: const Text("Proyecto Cosas Perdidas UdeC"),
        centerTitle: true, // Centra el título
      ),
      //body simplemente contiene un Center
      body:
          //Center simplemente aloja y centra un Column
          Center(
            //Column organiza sus hijos en una columna vertical
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .center, // Centra los hijos de la columna tanto horizontal como verticalmente
              children: [
                //Row organiza sus hijos en una fila horizontal
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Centra los hijos de la columna tanto horizontal como verticalmente
                  children: [
                    // Boton
                    ElevatedButton(
                      // Acción al presionar el botón
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdministratorScreen(),
                          ),
                        );
                      },
                      // Estilo personalizado para el botón
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        //backgroundColor: Colors.blue,
                        backgroundColor: Color.fromARGB(255, 0, 255, 128),
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

                    //espacio entre botones
                    const SizedBox(width: 15),

                    // Boton
                    ElevatedButton(
                      // Acción al presionar el botón
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MediatorScreen(),
                          ),
                        );
                      },
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
                      child: const Text("Mediador"),
                    ),

                    //Espacio entre botones
                    const SizedBox(width: 15),

                    // Boton
                    ElevatedButton(
                      // Acción al presionar el botón
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserScreen(),
                          ),
                        );
                      },
                      // Estilo personalizado para el botón
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(
                          255,
                          209,
                          250,
                          46,
                        ),
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
                      child: const Text("Usuario"),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
