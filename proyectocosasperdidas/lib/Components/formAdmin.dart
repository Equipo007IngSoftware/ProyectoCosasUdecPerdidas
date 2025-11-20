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
//clase que crea un formulario que le permite al administrador crear un reporte de un objeto encontrado

class FormAdmin extends StatefulWidget {
  @override
  FormAdminState createState() {
    return FormAdminState();
  }
}

class FormAdminState extends State<FormAdmin> {
  final _formKey = GlobalKey<FormState>();
  late Identificacion id; //identificación del admin
  late Ubicacion place; //lugar donde fue encontrado el objeto
  late Reporte reporte; //reporte que erá creado
  late DateTime fecha; //fecha cuándo el objeto fue encontrado
  Estado estado =
      Estado.encontrado; //indica que el reporte será de un objeto encontrado
  late String descr; //descripción del objeto encontrado
  late String objeto; //objeto encontrado
  late categorias category; //categoría del objeto encontrado
  PlatformFile? img; //imagen asociada al objeto
  bool chosen = true; //flag para ver si se ha escogido categoría
  bool chosenimage = true; //flag para saber si se ha ingresado imagen
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
            visible:
                (img == null &&
                chosenimage ==
                    false), //si es que no se ha subido imagen y se trata de mandar el reporte,el flag será falso y advertencia es visible
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
                //si es que no tiene imagen entonces no permite enviar el reporte
                if (img == null) {
                  setState(() {
                    chosenimage = false;
                  });
                  return;
                }

                try {
                  //intenta crear el reporte
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
                    chosen = true; //se borra advertencia si es que es visible
                  });
                  DataBase().registrarReporteEncontrado(
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
