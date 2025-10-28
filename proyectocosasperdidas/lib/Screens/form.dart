import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Components/Imagen.dart';
import 'package:proyectocosasperdidas/Components/estado.dart';
import 'package:proyectocosasperdidas/Components/reporte.dart';
import 'package:proyectocosasperdidas/Components/categorias.dart';
import 'package:proyectocosasperdidas/Components/formAdmin.dart';
import 'package:proyectocosasperdidas/Components/formPerdedor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

///Pantalla de Formulario
///
///permite rellenar campos para crear un reporte<br />
///y luego enviarlo
class Formulario extends StatelessWidget {
  final Estado tipo;

  const Formulario({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario para reportar perdida de objeto',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'), // Spanish
        Locale('en', 'US'), // English (optional fallback)
      ],
      home: Scaffold(
        appBar: AppBar(title: const Text("Formulario"), centerTitle: true),
        body: Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              children: [
                (tipo == Estado.perdido) ? FormPerdedor() : FormAdmin(),
                //const MenuCategoria(),
                const MenuImagen(),
                Text((tipo == Estado.perdido) ? "modo perdedor" : "soy admin"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
