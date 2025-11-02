import 'package:proyectocosasperdidas/Components/reporte.dart';

///Clase de Solución
///
///contiene el reporte de perdido y de encontrado correspondientes
class Solucion {
  final Reporte perdido;
  final Reporte encontrado;

  Solucion(this.perdido, this.encontrado);
}

///Base de Datos
///
///Lleva registro de los reportes de objeto perdido y encontrado<br />
///ademas de los pares solucionados
///````DataBase()```
class DataBase {
  static DataBase? _instance;

  DataBase._();

  factory DataBase() => _instance ??= DataBase._();

  final List<Reporte> reportesPerdido = [];
  final List<Reporte> reportesEncontrado = [];
  final List<Solucion> reportesSolucionado = [];

  Reporte getReporteEncontrado(int i){
    return reportesEncontrado[i];
  }
  int encontradosSize(){
    return reportesEncontrado.length;
  }
   Reporte getReportePerdido(int i){
    return reportesPerdido[i];
  }
  int perdidosSize(){
    return reportesPerdido.length;
  }

  ///Registra un objeto perdido<br />
  //////```DataBase().registrarReportePerdido(r1);```
  void registrarReportePerdido(Reporte r){
    reportesPerdido.add(r);
  }
  ///Registra un objeto encontrado por parte del Administrador<br />
  //////```DataBase().registrarReporteEncontrado(r2);```
  void registrarReporteEncontrado(Reporte r){
    reportesEncontrado.add(r);
  }
  ///Empareja un reporte de la lista de perdidos y uno de la lista de encontrados
  ///
  ///Si uno de los reportes no esta en la lista correspondiente, devuelve falso<br />
  ///```if (DataBase().emparejar(r1,r2)) {//emparejamiento exitoso}```
  bool emparejar(Reporte perdido, Reporte encontrado){
    if (reportesEncontrado.contains(encontrado)){
      if (reportesPerdido.remove(perdido)){
        reportesEncontrado.remove(encontrado);
        reportesSolucionado.add(Solucion(perdido, encontrado));
        return true;
        }else {return false;}
    }else {return false;}
  }
}