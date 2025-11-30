import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proyectocosasperdidas/Components/categorias.dart';
import 'package:proyectocosasperdidas/Components/estado.dart';
import 'package:proyectocosasperdidas/Components/identificacion.dart';
import 'package:proyectocosasperdidas/Components/reporte.dart';
import 'package:proyectocosasperdidas/Components/ubicacion.dart';
import 'package:proyectocosasperdidas/Screens/administrator_screen.dart';
import 'package:proyectocosasperdidas/database.dart';

void main(){
  testWidgets('Tests a lista de reportes de Administrador', (WidgetTester tester) async {
    DataBase db = DataBase();
    Reporte rEncontrado = Reporte(
      titulo: "PruebaE",  
      descripcion: "DescE", 
      tipo: categorias.electronico, 
      estado: Estado.encontrado, 
      ubicacion: Ubicacion("UbiE"), 
      ident: Identificacion(id_o_nombre: "ID_E", numero: "+9003"));
    Reporte rPerdido = Reporte(
      titulo: "PruebaP", 
      descripcion: "DescP", 
      tipo: categorias.electronico, 
      estado: Estado.perdido, 
      ubicacion: Ubicacion("UbiP"), 
      ident: Identificacion(id_o_nombre: "nombre_P"));
    db.registrarReportePerdido(rPerdido);
    db.registrarReporteEncontrado(rEncontrado);
    bool testBool = db.emparejar(rPerdido, rEncontrado);

    expect(testBool, true);
    await tester.pumpWidget(MaterialApp(home: AdministratorScreen()));
    expect(find.byType(Card), findsNWidgets(2));
    expect(find.text("Estado: PERDIDO"), findsNothing);
    expect(find.text("Teléfono:"), findsNothing);
    await tester.tap(find.byType(Card).first);
    await tester.pump(Durations.extralong1);
    expect(find.text("Estado: PERDIDO"), findsOne);
    expect(find.text("Teléfono:"), findsOne);
  });
}