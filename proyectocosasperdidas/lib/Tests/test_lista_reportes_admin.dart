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
  testWidgets('Caso feliz de lista de reportes (vista Admin)', (WidgetTester tester) async {
    ///Crear reportes de prueba y comprobar que estan bien emparejados
    DataBase db = DataBase();
    Reporte rEncontrado = Reporte(
      titulo: "PruebaE",  
      descripcion: "DescE", 
      tipo: categorias.electronico, 
      estado: Estado.encontrado, 
      ubicacion: Ubicacion("UbiE"), 
      ident: Identificacion(id_o_nombre: "ID_E"));
    Reporte rPerdido = Reporte(
      titulo: "PruebaP", 
      descripcion: "DescP", 
      tipo: categorias.electronico, 
      estado: Estado.perdido, 
      ubicacion: Ubicacion("UbiP"), 
      ident: Identificacion(id_o_nombre: "nombre_P", numero: "+9003"));
    db.registrarReportePerdido(rPerdido);
    db.registrarReporteEncontrado(rEncontrado);
    bool testBool = db.emparejar(rPerdido, rEncontrado);
    expect(testBool, true);

    await tester.pumpWidget(MaterialApp(home: AdministratorScreen()));
    ///Se confirma que estén las 2 cards, y de que aparezca la información extra cuando se les hace click
    expect(find.byType(Card), findsNWidgets(2));
    expect(find.text("Estado: PERDIDO"), findsNothing);
    expect(find.text("+9003"), findsNothing);
    await tester.tap(find.byType(Card).first);
    await tester.pump(Durations.extralong1);
    expect(find.text("Estado: PERDIDO"), findsOne);
    expect(find.text("+9003"), findsOne);
  });
  testWidgets('Edge Case de lista de reportes (sin reportes)', (WidgetTester tester) async {
    ///Deja vacia a la base de datos, y confirma que se muestre el texto para las listas vacias y ninguna Card
    DataBase().reportesSolucionado.clear();
    await tester.pumpWidget(MaterialApp(home: AdministratorScreen()));
    await tester.pump(Durations.short2);
    expect(find.text("No hay ningún reporte emparejado"), findsOne);
    expect(find.byType(Card), findsNothing);
    await tester.tap(find.byType(Switch));
    await tester.pump(Durations.short2);
    expect(find.text("No hay ningún objeto entregado"), findsOne);
    expect(find.byType(Card), findsNothing);
  });
  testWidgets('Solucionar emparejamiento', (WidgetTester tester) async {
    ///Vuelve a crear los reportes de prueba
    DataBase db = DataBase();
    Reporte rEncontrado = Reporte(
      titulo: "PruebaE",  
      descripcion: "DescE", 
      tipo: categorias.electronico, 
      estado: Estado.encontrado, 
      ubicacion: Ubicacion("UbiE"), 
      ident: Identificacion(id_o_nombre: "ID_E"));
    Reporte rPerdido = Reporte(
      titulo: "PruebaP", 
      descripcion: "DescP", 
      tipo: categorias.electronico, 
      estado: Estado.perdido, 
      ubicacion: Ubicacion("UbiP"), 
      ident: Identificacion(id_o_nombre: "nombre_P", numero: "+9003"));
    db.registrarReportePerdido(rPerdido);
    db.registrarReporteEncontrado(rEncontrado);
    bool testBool = db.emparejar(rPerdido, rEncontrado);
    expect(testBool, true);

    ///Confirma que aparece el botón de "marcar como solucionado" solo cuando se selecciona una pareja, 
    ///y que se deselecciona correctamente al volver a hacerle click
    await tester.pumpWidget(MaterialApp(home: AdministratorScreen()));
    expect(find.text("Marcar como solucionado"), findsNothing);
    expect(find.byType(ElevatedButton), findsOne);
    await tester.tap(find.byType(Card).first);
    await tester.pump(Durations.short2);
    expect(find.text("Marcar como solucionado"), findsOne);
    expect(find.byType(ElevatedButton), findsNWidgets(2));
    await tester.tap(find.byType(Card).first);
    await tester.pump(Durations.short2);
    expect(find.text("Marcar como solucionado"), findsNothing);
    expect(find.byType(ElevatedButton), findsOne);

    ///Comprueba que el botón de marcar como solucionado da la advertencia antes de continuar
    await tester.tap(find.byType(Card).first);
    await tester.pump(Durations.short2);
    await tester.tap(find.byType(ElevatedButton).last);
    await tester.pump(Durations.short2);
    expect(find.text("¿Confirmar?"),findsOne);
    expect(find.byType(Dialog), findsOne);
    expect(find.byType(ElevatedButton), findsNWidgets(4));

    ///Comprueba que el emparejamiento se mueve a la lista de objetos entregados
    await tester.tap(find.byType(ElevatedButton).at(2));
    await tester.pump(Durations.short2);
    expect(find.text("No hay ningún reporte emparejado"), findsOne);
    expect(find.byType(Card), findsNothing);
    await tester.tap(find.byType(Switch));
    await tester.pump(Durations.short2);
    expect(find.byType(Card), findsNWidgets(2));
  });
}