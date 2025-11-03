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
  @override
  Widget build(BuildContext context) {
    DataBase db = DataBase();
    return Scaffold(
      appBar: AppBar(title: const Text("Mediador"), centerTitle: true),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        spacing:10,
        children: [
          SizedBox(height: 10,),
          ///Fila para manejar las categorias de los reportes mostrados 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              MenuCategoria(press: manageCategoria),
              ElevatedButton(onPressed: ()=>setState(() {
                c=null;
              }), child: Text("Limpiar Categoria"))
            ],
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Lista de objetos encontrados (Creados en vista Admin)
                ListaReportes(getReporte: db.getReporteEncontrado,size: db.encontradosSize(c), notify: manageEncontrado,),
                //Lista de objetos perdidos (Creados en vista Perdedor)
                ListaReportes(getReporte: db.getReportePerdido, size: db.perdidosSize(c), notify: managePerdido,)
              ],
            ),
          ),
        ],
      ),
    );
  }
  void managePerdido(Reporte r){
    dev.log("Este es un reporte perdido: ${r.titulo}");
  }
  void manageEncontrado(Reporte r){
    dev.log("Este es un reporte encontrado: ${r.titulo}");
  }
  void manageCategoria(categorias category){
    dev.log("Se seleccionó esta categoria: ${category.label}");
    setState(() {
      c = category;
    });
  }
}

class ListaReportes extends StatelessWidget {
  final ValueChanged<Reporte> notify;
  final Function(int) getReporte;
  final int size;
  const ListaReportes({super.key, required this.getReporte, required this.size, required this.notify});

  @override
  Widget build(BuildContext context) {
    dev.log("$size");
    return Expanded(
      child: ListView.builder(
        itemCount: size,
        itemBuilder: (context, index) {
          return GestureDetector(onTap: () => notify(getReporte(index)), child: TarjetaDeReporte.fromReporte(getReporte(index)));
        },
      ),
    );
  }
}