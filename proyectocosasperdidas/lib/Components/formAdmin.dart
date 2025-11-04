import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Components/categorias.dart';
import 'package:intl/intl.dart';
import 'package:proyectocosasperdidas/Components/identificacion.dart';
import 'package:proyectocosasperdidas/Components/ubicacion.dart';
import 'package:proyectocosasperdidas/Components/reporte.dart';
import 'package:proyectocosasperdidas/Components/estado.dart';
import 'package:proyectocosasperdidas/Components/Imagen.dart';
import 'package:proyectocosasperdidas/database.dart';

/*void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Formulario para reportar objeto encontrado';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: FormAdmin(),
      ),
    );
  }
}*/

class FormAdmin extends StatefulWidget {
  @override
  FormAdminState createState() {
    return FormAdminState();
  }
}

class FormAdminState extends State<FormAdmin> {
  final _formKey = GlobalKey<FormState>();
  late Identificacion id;
  late String nombre;
  late Ubicacion place;
  late Reporte reporte;
  late DateTime fecha;
  Estado estado = Estado.encontrado;
  late String descr;
  late String objeto;
  late categorias category;
  PlatformFile? img;
  bool chosen = true;
  bool chosenimage = true;
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
              hintText: 'ID de administrador',
              labelText: 'Identificación *',
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            ),
            onSaved: (String? value) {
              if (value != null) {
                setState(() {
                  id = Identificacion(id_o_nombre: value);
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
              hintText: '¿Qué encontraste?',
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
              hintText: 'Describe el objeto',
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
              labelText: 'Fecha cuando encontró el objeto *',
              hintText: 'dd/mm/aaaa',
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
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
                firstDate: DateTime.now().subtract(const Duration(days: 92)),
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
              hintText: 'Dónde fue encontrado el objeto',
              labelText: 'Lugar encontrado *',
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
          MenuImagen(img: (value) => img = value),
          Visibility(
            visible: (img == null && chosenimage == false),
            child: const Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Text(
                'No ha seleccionado imagen',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          MenuCategoria(press: (value) => category = value),
          Visibility(
            visible: (chosen == false),
            child: const Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Text(
                'No ha seleccionado categoría',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                //si es que no tiene imagen entonces no permite enviar el reporte
                if (img == null) {
                  setState(() {
                    chosenimage = false;
                  });
                  return;
                }

                try {
                  reporte = Reporte(
                    titulo: objeto,
                    fecha: fecha,
                    descripcion: descr,
                    tipo: category,
                    estado: estado,
                    ubicacion: place,
                    ident: id,
                    imagen: img,
                  );
                  setState(() {
                    chosen = true;
                  });
                  DataBase().registrarReporteEncontrado(reporte);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Enviado')));
                } catch (e) {
                  setState(() {
                    chosen = false;
                  });
                }
                reporte = Reporte(
                  titulo: objeto,
                  fecha: fecha,
                  descripcion: descr,
                  tipo: category,
                  estado: estado,
                  ubicacion: place,
                  ident: id,
                  imagen: img,
                );
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
