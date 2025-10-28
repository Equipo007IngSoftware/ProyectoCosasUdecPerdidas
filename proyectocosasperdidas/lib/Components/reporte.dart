import 'package:proyectocosasperdidas/Components/tarjeta_de_reporte.dart';
import 'estado.dart';
import 'identificacion.dart';
import 'ubicacion.dart';
import 'categorias.dart';

/// Reporte guarda la información relacionada a un objeto
///
///
/// guarda fecha, descripcion, tipo, estado, ubicacion, identificacion e imagen(opcional)
///
///
/// Ejemplo de uso: ```Reporte(descripcion: "celular", tipo: categorias.electronico, estado: Estado.perdido, ubicacion: Ubicacion("Sistemas"), ident: Identificacion("12.345.678-9"));```
class Reporte {
  String titulo;
  DateTime? fecha;
  String descripcion;
  categorias tipo;
  Estado estado;
  Ubicacion ubicacion;
  Identificacion ident;
  String? imagenUrl;

  ///Contructor de Reporte
  ///
  ///imagen es opcional<br />
  ///fecha por defecto es DateTime.now()
  ///
  ///```Reporte(descripcion: "celular", tipo: categorias.electronico, estado: Estado.perdido, ubicacion: Ubicacion("Sistemas"), ident: Identificacion("12.345.678-9"));```
  Reporte({
    required this.titulo,
    this.fecha,
    required this.descripcion,
    required this.tipo,
    required this.estado,
    required this.ubicacion,
    required this.ident,
    this.imagenUrl,
  }) {
    fecha ??= DateTime.now();
  }
}
