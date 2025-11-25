import 'package:flutter/material.dart';
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
  //variable que dice si hay algun par de reporte seleccionado
  int seleccionIndex=-1;

  // Metodo build que describe la parte de la interfaz de usuario representada por este widget
  @override
  Widget build(BuildContext context) {
    // Scaffold proporciona una estructura básica para la pantalla, en este caso con una AppBar y un Body
    return Scaffold(
      // AppBar que contiene un título centrado
      appBar: AppBar(title: const Text("Administrador"), centerTitle: true),
      // Body que contiene un Center con un texto
      body: Center(
        child: Column(
          children: [
            //Boton que lleva a Formulario
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  //se abre un formulario en modo de objeto encontrado
                  MaterialPageRoute(
                    builder: (context) => Formulario(tipo: Estado.encontrado),
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
            Padding(padding: EdgeInsets.all(8)),
            if(seleccionIndex!=-1)
            ElevatedButton(
              onPressed: () {
                //muestra popup para preguntarte si estas seguro
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Confirmar?"),
                    content: const Text("Estos reportes se eliminaran permanentemente de la base de datos"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancelar"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState((){
                          DataBase().reportesEntregados.add(DataBase().reportesSolucionado.removeAt(seleccionIndex));
                          seleccionIndex=-1;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text("Sí"),
                      ),
                    ],
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
              child: const Text("Marcar como solucionado"),
            ),
            ListaReportesPares(
              DataBase().reportesSolucionado,
              onSeleccion: (seleccionado) {
                setState(() {
                  seleccionIndex = seleccionado;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
/*class ListaReportesPares extends StatelessWidget {
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
}*/

class ListaReportesPares extends StatefulWidget {
  final List<Solucion> soluciones;
  final ValueChanged<int> onSeleccion;
  const ListaReportesPares(
    this.soluciones, 
    {
    super.key, 
    required this.onSeleccion,
    }
  );
  @override
  State<ListaReportesPares> createState() => _ListaReportesParesState();
}

class _ListaReportesParesState extends State<ListaReportesPares> {
  // Almacena el índice de la fila de pares de reportes actualmente expandida
  // -1 significa que ninguna tarjeta esta expandida.
  int _expandedIndex = -1;

  // Callback que se llama cuando se toca cualquiera de las dos tarjetas en una fila (expande o contrae ambas tarjetas)
  void _handleTap(int index) {
    setState(() {
      _expandedIndex = (index == _expandedIndex) ? -1 : index;
    });
    widget.onSeleccion(_expandedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.soluciones.length,
        itemBuilder: (context, index) {
          final Solucion solucion = widget.soluciones[index];
          // Determina si el par actual debe estar expandido
          final bool isExpanded = index == _expandedIndex;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            // Row para colocar las dos tarjetas una al lado de la otra
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tarjeta 1: Reporte Perdido
                Expanded(
                  child: TarjetaDeReporte.fromReporte(
                    solucion.perdido,
                    onTap: (Reporte value) => _handleTap(index),
                    isSelected:isExpanded, // Sincroniza el estado (expandido o no)
                  ),
                ),
                // Tarjeta 2: Reporte Encontrado
                Expanded(
                  child: TarjetaDeReporte.fromReporte(
                    solucion.encontrado,
                    onTap: (Reporte value) => _handleTap(index),
                    isSelected:isExpanded, // Sincroniza el estado (expandido o no)
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
