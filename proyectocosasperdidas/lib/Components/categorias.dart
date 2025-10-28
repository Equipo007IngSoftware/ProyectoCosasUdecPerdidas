import 'package:flutter/material.dart';
enum categorias{
  electronico("Objeto Electrónico", Color.fromRGBO(66, 62, 1, 1)),
  ropa("Prenda de ropa", Color.fromRGBO(133, 29, 11, 1)),
  escolar("Util academico", Color.fromRGBO(6, 82, 92, 1)),
  doc("Documento personal", Color.fromRGBO(14, 112, 55, 1)),
  otro("Otro", Color.fromRGBO(92, 91, 87, 1));
  final String label;
  final Color fcolor;
  const categorias(this.label, this.fcolor);
}

class MenuCategoria extends StatelessWidget {
  const MenuCategoria({super.key, required this.press});
  final ValueChanged<categorias> press;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<categorias>(
      label: Text("Categoria"),
      width: 250,
      initialSelection: categorias.otro,
      dropdownMenuEntries: categorias.values.map<DropdownMenuEntry<categorias>>(
        (categorias c) {
          return DropdownMenuEntry<categorias>(
            value: c,
            label: c.label,
            style: ButtonStyle(foregroundColor: WidgetStatePropertyAll<Color?>(c.fcolor)),
          );
        },
      ).toList(),
      onSelected: (value) {
        press(value!);
      },
    );
  }
}