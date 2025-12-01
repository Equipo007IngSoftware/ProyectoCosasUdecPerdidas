import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Components/categorias.dart';
import 'package:proyectocosasperdidas/Components/tarjeta_de_reporte.dart';
import 'package:proyectocosasperdidas/database.dart';
import 'package:proyectocosasperdidas/Components/reporte.dart';
import 'dart:developer' as dev;

class MediatorScreen extends StatefulWidget {
  const MediatorScreen({super.key});

  @override
  State<MediatorScreen> createState() => _MediatorScreen();
}

class _MediatorScreen extends State<MediatorScreen> {
  categorias? c;
  int perdidoSelect = -1;
  int encontradoSelect = -1;

  @override
  Widget build(BuildContext context) {
    DataBase db = DataBase();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mediador"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          SizedBox(height: 10),

          ///Fila para manejar las categorias de los reportes mostrados
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              MenuCategoria(press: manageCategoria),
              ElevatedButton(
                onPressed: () => setState(() {
                  c = null;
                }),
                child: Text("Limpiar Categoria"),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: (perdidoSelect != -1 && encontradoSelect != -1)
                ? () {
                    setState(() {
                      Reporte perdido = db.getReportePerdido(
                        perdidoSelect,
                        null,
                      );
                      Reporte encontrado = db.getReporteEncontrado(
                        encontradoSelect,
                        null,
                      );
                      if (encontrado.fecha!.isBefore(perdido.fecha!)) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("¿Confirmar?"),
                            content: const Text(
                              "El objeto perdido se perdió después de que el objeto encontrado fue reportado. ¿Desea continuar?",
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    perdidoSelect = -1;
                                    encontradoSelect = -1;
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text("Cancelar"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (db.emparejar(perdido, encontrado)) {
                                      perdidoSelect = -1;
                                      encontradoSelect = -1;
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Emparejado',
                                            textAlign: TextAlign.center,
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    }
                                    ;
                                  });
                                },

                                child: const Text(
                                  "Aceptar",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (perdido.tipo != encontrado.tipo) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("¿Confirmar?"),
                            content: const Text(
                              "Estos reportes son de categorías disintas. ¿Desea continuar?",
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    perdidoSelect = -1;
                                    encontradoSelect = -1;
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text("Cancelar"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (db.emparejar(perdido, encontrado)) {
                                      perdidoSelect = -1;
                                      encontradoSelect = -1;
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Emparejado',
                                            textAlign: TextAlign.center,
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    }
                                    ;
                                  });
                                },

                                child: const Text(
                                  "Aceptar",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (db.emparejar(perdido, encontrado)) {
                        perdidoSelect = -1;
                        encontradoSelect = -1;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Emparejado',
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    });
                  }
                : null,
            child: Text("Emparejar"),
          ),

          ///Contenedor Expanded con las dos listas de reportes
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Lista de objetos encontrados (Creados en vista Admin)
                ListaReportes(
                  getReporte: db.getReporteEncontrado,
                  size: db.encontradosSize(c),
                  notify: manageEncontrado,
                  selectedReport: encontradoSelect,
                  selected_category: c,
                ),
                //Lista de objetos perdidos (Creados en vista Usuario)
                ListaReportes(
                  getReporte: db.getReportePerdido,
                  size: db.perdidosSize(c),
                  notify: managePerdido,
                  selectedReport: perdidoSelect,
                  selected_category: c,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///Metodo encargado de manejar cuando el usuario mediador presiona un reporte de objeto perdido (de momento placeholder)
  void managePerdido(Reporte r) {
    dev.log("Este es un reporte perdido: ${r.titulo}");
    setState(() {
      int nextsel = DataBase().reportesPerdido.indexOf(r);
      perdidoSelect = (perdidoSelect != nextsel) ? nextsel : -1;
    });
  }

  ///Metodo encargado de manejar cuando el usuario mediador presiona un reporte de objeto encontrado (de momento placeholder)
  void manageEncontrado(Reporte r) {
    dev.log("Este es un reporte encontrado: ${r.titulo}");
    setState(() {
      int nextsel = DataBase().reportesEncontrado.indexOf(r);
      encontradoSelect = (encontradoSelect != nextsel) ? nextsel : -1;
    });
  }

  ///Metodo encargado de manejar la categoria seleccionada
  void manageCategoria(categorias category) {
    setState(() {
      c = category;
    });
  }
}

///Widget de Listview que muestra todos los reportes correspondientes. Se le entrega la función de getReporte, size, y notify en los argumentos de modo que se pueda
///reutilizar tanto para reportes perdidos como reportes encontrados
class ListaReportes extends StatelessWidget {
  final ValueChanged<Reporte> notify;
  final Function(int, categorias?) getReporte;
  final categorias? selected_category;
  final int size;
  final int selectedReport;
  const ListaReportes({
    super.key,
    required this.getReporte,
    required this.size,
    required this.notify,
    required this.selectedReport,
    required this.selected_category,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: size,
        itemBuilder: (context, index) {
          // Construye cada TarjetaDeReporte usando el factory desde un Reporte obtenido por getReporte
          return TarjetaDeReporte.fromReporte(
            getReporte(index, selected_category),
            onTap: notify,
            isSelected: index == selectedReport,
          );
        },
      ),
    );
  }
}
