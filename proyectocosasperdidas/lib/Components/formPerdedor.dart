import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Components/categorias.dart';
import 'package:intl/intl.dart';
import 'package:proyectocosasperdidas/Components/identificacion.dart';
import 'package:proyectocosasperdidas/Components/ubicacion.dart';
import 'package:proyectocosasperdidas/Components/reporte.dart';
import 'package:proyectocosasperdidas/Components/estado.dart';
/*void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Formulario para reportar perdida de objeto';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: FormPerdedor(),
      ),
    );
  }
}*/

class FormPerdedor extends StatefulWidget {
  @override
  FormPerdedorState createState() {
    return FormPerdedorState();
  }
}

class FormPerdedorState extends State<FormPerdedor> {
  final _formKey = GlobalKey<FormState>();
  late Identificacion id;
  late String nombre;
  late String numero;
  late String correo;
  late Ubicacion place;
  late Reporte reporte;
  late DateTime fecha;
  Estado estado = Estado.perdido;
  late String descr;
  late String objeto;
  late categorias category;
  TextEditingController _fechaController = TextEditingController();

  @override
  void dispose() {
    _fechaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 30.0,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: '¿Cómo te llamas?',
              labelText: 'Nombre *',
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            ),
            onSaved: (String? value) {
              if (value != null) {
                setState(() {
                  nombre = value;
                });
              }
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio.';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: '+56912345678',
              labelText: 'Telefóno de contacto *',
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            ),
            onSaved: (String? value) {
              if (value != null) {
                numero = value;
              }
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio.';
              }
              if (!RegExp(r'^\+[0-9]+$').hasMatch(value)) {
                return ("Asegúrate de que solo hay números después del +");
              }

              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'perdedor@gmail.com',
              labelText: 'Correo *',
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            ),
            onSaved: (String? value) {
              if (value != null) {
                correo = value;
              }
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio.';
              }
              if (!value.contains('@')) {
                return 'No hay @ en tu correo';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: '¿Qué perdiste?',
              labelText: 'Objeto *',
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            ),
            onSaved: (String? value) {
              if (value != null) {
                setState(() {
                  objeto = value;
                });
              }
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio.';
              }
              return null;
            },
          ),
          TextFormField(
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Describe tu objeto',
              labelText: 'Descripción *',
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            ),
            onSaved: (String? value) {
              if (value != null) {
                setState(() {
                  descr = value;
                });
              }
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio.';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _fechaController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Fecha cuando perdió el objeto *',
              hintText: 'dd/mm/aaaa',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio.';
              }
              return null;
            },
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2024),
                lastDate: DateTime.now(),
                locale: const Locale('es', 'ES'),
              );
              if (picked != null) {
                setState(() {
                  fecha = picked;
                  _fechaController.text = DateFormat(
                    'dd/MM/yyyy',
                  ).format(picked);
                });
              }
            },
          ),
          TextFormField(
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Último lugar donde lo viste',
              labelText: 'Ubicación de pérdida *',
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            ),
            onSaved: (String? value) {
              if (value != null) {
                setState(() {
                  place = Ubicacion(value);
                });
              }
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio.';
              }
              return null;
            },
          ),
          MenuCategoria(press: (value) => category=value),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                id = Identificacion(
                  id_o_nombre: nombre,
                  numero: numero,
                  correo: correo,
                );
                reporte = Reporte(
                  titulo: objeto,
                  fecha: fecha,
                  descripcion: descr,
                  tipo: category,
                  estado: estado,
                  ubicacion: place,
                  ident: id,
                );
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Procesando')));
              }
            },
            child: const Text('Mandar'),
          ),
        ],
      ),
    );
  }
}
