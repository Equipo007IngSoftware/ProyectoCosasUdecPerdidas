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

//clase que crea un formulario que le permite al usuario crear un reporte de un objeto perdido
class FormUser extends StatefulWidget {
  @override
  FormUserState createState() {
    return FormUserState();
  }
}

class FormUserState extends State<FormUser> {
  final _formKey = GlobalKey<FormState>();
  late Identificacion id; //identificación del usuario
  late String nombre; //nombre del usuario
  late String numero; //número de télefono del usuario
  late String correo; //correo del usuario
  late Ubicacion place; //lugar donde el usuario perdió el objeto
  late Reporte reporte; //reporte a crear
  late DateTime fecha; //fecha cuándo perdió el objeto
  Estado estado = Estado.perdido; //reporte se crea con status de perdido
  late String descr; //descripción del objeto
  late String objeto; //objeto perdido
  late categorias category; //categoría del objeto
  PlatformFile? img; //imagen del objeto
  bool chosen = true; //flag para saber si se ha escogido categoría
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
              hintText: '+56912345678 o 912345678',
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
              if (value[0] == '+') {
                if (!RegExp(r'^\+[0-9]+$').hasMatch(value)) {
                  return ("Asegúrate de que solo hay números después del +");
                } //chequea que sea un + seguido solamente de números
                else if (value.length < 12 || value.length > 13) {
                  return ("Chequea el largo");
                }
              } else {
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return ("Asegúrate de que solo hay números");
                } //chequea que solo hay números
                else if (value.length < 8 || value.length > 9) {
                  return ("Chequea el largo");
                }
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
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&ñ'*+-/=?^_`{|}~]+@[a-zA-Z0-9ñ]+\.[a-zA-Zñ]+",
              ).hasMatch(value)) {
                return 'No tiene formato de correo';
              } //chequea formato básico de correo
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
                firstDate: DateTime.now().subtract(
                  const Duration(days: 92),
                ), //permite hasta aprox 3 meses antes de la fecha actual
                lastDate: DateTime.now(),
                locale: const Locale(
                  'es',
                  'ES',
                ), //sistema "latino" de fechas (dd/mm/aaaa)
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
            visible:
                (chosen ==
                false), //si es que no se ha seleccionado categoría y se trata de mandar el reporte, el flag será falso y advertencia es visible
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
                  //trata de crear identificación del usuario
                  id = Identificacion(
                    id_o_nombre: nombre,
                    numero: numero,
                    correo: correo,
                  );
                  //trata de crear el reporte
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
                  DataBase().registrarReportePerdido(
                    reporte,
                  ); //registra reporte en la base de datos
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Enviado')));
                } catch (e) {
                  //si es que no se escogido categoría lanza una excepción, la atrapamos y marcamos la flag como falsa para hacer visible la advertencia
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
