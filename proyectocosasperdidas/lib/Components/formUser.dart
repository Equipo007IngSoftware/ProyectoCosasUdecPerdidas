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

class FormUser extends StatefulWidget {
  @override
  FormUserState createState() {
    return FormUserState();
  }
}

class FormUserState extends State<FormUser> {
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
  PlatformFile? img;
  bool chosen = true;
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
              hintText: 'user@gmail.com',
              labelText: 'Correo *',
              contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            ),
            onSaved: (String? value) {
              if (value != null) {
                correo = value.toLowerCase();
              }
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Este campo es obligatorio.';
              }
              if (!RegExp(
                /*r'^[a-z|A-Z|0-9]+\@[a-z|A-Z|0-9]+\.[a-z]+$',*/
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              ).hasMatch(value)) {
                return 'No tiene formato de correo';
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
          MenuImagen(img: (value) => img = value),
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
                try {
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
                    imagen: img,
                  );
                  setState(() {
                    chosen = true;
                  });
                  DataBase().registrarReportePerdido(reporte);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Enviado')));
                } catch (e) {
                  setState(() {
                    chosen = false;
                  });
                }
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
