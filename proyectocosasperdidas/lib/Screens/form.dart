import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Components/estado.dart';
import 'package:proyectocosasperdidas/Components/formAdmin.dart';
import 'package:proyectocosasperdidas/Components/formUser.dart';

///Pantalla de Formulario
///
///permite rellenar campos para crear un reporte<br />
///y luego enviarlo
class Formulario extends StatelessWidget {
  final Estado tipo;

  const Formulario({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulario"), centerTitle: true),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 30, 16, 0),
            child: Column(
              children: [
                (tipo == Estado.perdido) ? FormUser() : FormAdmin(),
                //const MenuCategoria(),
                //Text((tipo == Estado.perdido) ? "modo usuario" : "soy admin"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
