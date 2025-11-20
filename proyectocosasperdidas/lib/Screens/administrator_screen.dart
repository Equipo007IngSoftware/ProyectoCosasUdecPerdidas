import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Components/categorias.dart';
import 'package:proyectocosasperdidas/Components/estado.dart';
import 'package:proyectocosasperdidas/Components/reporte.dart';
import 'package:proyectocosasperdidas/Components/tarjeta_de_reporte.dart';
import 'package:proyectocosasperdidas/Screens/form.dart';
import 'package:proyectocosasperdidas/database.dart';

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
      body: Center(child: Column(
        children: [
          //Boton que lleva a Formulario
          ElevatedButton(
            onPressed: () {
                Navigator.push(
                  context,
                  //se abre un formulario en modo de objeto encontrado
                  MaterialPageRoute(
                    builder: (context) => Formulario(tipo: Estado.encontrado,),
                  ),
                );
              },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
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
          ListaReportesPares(DataBase().reportesSolucionado),
        ],
      )),
    );
  }
}

class ListaReportesPares extends StatelessWidget {
  //final ValueChanged<Reporte> notify;
  final List<Solucion> soluciones;
  //final int selectedReport;
  const ListaReportesPares(this.soluciones, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: soluciones.length,
        itemBuilder: (context, index) {
          return TarjetaDeReporte.fromReporte(soluciones[index].perdido, onTap: (Reporte value) {},/*, isSelected: index==selectedReport*/);
        },
      ),
    );
  }
}
