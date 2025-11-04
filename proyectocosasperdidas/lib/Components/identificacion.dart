//identificación, cuando se identifica un admin solo es necesario su id, pero para el usuario es necesario número de télefono y correo

class Identificacion {
  String id_o_nombre;
  String? numero;
  String? correo;

  Identificacion({required this.id_o_nombre, this.numero, this.correo});
}
