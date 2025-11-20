import 'package:flutter/material.dart';
import 'reporte.dart';

class TarjetaDeReporte extends StatefulWidget {
  final Reporte reporte;
  final bool
  isSelected; // Indica si la tarjeta debe estar expandida (controlada por ListaReportes).
  final ValueChanged<Reporte>
  onTap; // Callback para notificar al ListaReportes al ser tocada.

  const TarjetaDeReporte({
    super.key,
    required this.reporte,
    required this.onTap,
    this.isSelected = false,
  });

  // Constructor factory para crear la tarjeta desde un objeto Reporte
  //(es por una cuestion de simplicidad al instanciar en ListaReportes).
  factory TarjetaDeReporte.fromReporte(
    Reporte r, {
    required ValueChanged<Reporte> onTap,
    bool isSelected = false,
  }) {
    return TarjetaDeReporte(reporte: r, onTap: onTap, isSelected: isSelected);
  }

  @override
  State<TarjetaDeReporte> createState() => _TarjetaDeReporteState();
}

class _TarjetaDeReporteState extends State<TarjetaDeReporte> {
  late bool
  _isExpanded; // Estado interno para controlar si el contenido adicional es visible

  @override
  void initState() {
    super.initState();
    // Inicializa el estado interno con el valor que viene de ListaReportes (widget.isSelected)
    _isExpanded = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant TarjetaDeReporte oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Este metodo se llama cuando el widget padre se reconstruye con nuevos parametros.
    // Si 'isSelected' cambia, se sincroniza el estado interno (_isExpanded) y se fuerza la reconstruccion.
    if (widget.isSelected != oldWidget.isSelected) {
      setState(() {
        _isExpanded = widget.isSelected;
      });
    }
  }

  // Widget que construye los detalles adicionales del Admin o User (persona que extravió algo).
  Widget _buildDetallesAdicionales() {
    // Determina el tipo de estado del reporte (perdido encontrado)
    final isPerdido = widget.reporte.estado.toString().contains('perdido');

    List<Widget> details = [
      const Divider(),

      // Muestra el Estado del Reporte (para los dos).
      Text(
        'Estado: ${widget.reporte.estado.toString().split('.').last.toUpperCase()}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.blueAccent,
        ),
      ),
      const SizedBox(height: 8),

      // Descripcion (Para los dos).
      Text(
        'Descripción:',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      Text(widget.reporte.descripcion, style: const TextStyle(fontSize: 14)),
      const SizedBox(height: 8),

      // Detalles específicos del Usuario
      if (isPerdido) ...[
        // Nombre del usuario
        Text(
          'Contacto (Nombre):',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          widget.reporte.ident.id_o_nombre,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),

        // Numero de contacto
        Text(
          'Teléfono:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          widget.reporte.ident.numero ?? 'N/A',
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),

        // Correo de contacto
        Text(
          'Correo:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          widget.reporte.ident.correo ?? 'N/A',
          style: const TextStyle(fontSize: 14),
        ),
      ],

      // Detalles específicos del Administrador
      if (!isPerdido) ...[
        // ID del Administrador
        Text(
          'ID Admin Reportante:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          widget.reporte.ident.id_o_nombre,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    ];

    // Padding para el espaciado vertical.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: details,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Inkwell es un widget que detecta gestos de toque, en este caso para expandir/comprimir la tarjeta
    return InkWell(
      onTap: () {
        // Al tocar, llama al callback para que el ListaReportes maneje la selección
        widget.onTap(widget.reporte);
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // Cambia el color si está seleccionado/expandido para destacar
        color: widget.isSelected ? Colors.lightBlue.shade50 : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Contenedor de la Imagen
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child:
                  (widget.reporte.imagen != null &&
                      widget.reporte.imagen!.bytes != null)
                  ? Image.memory(
                      widget.reporte.imagen!.bytes!,
                      // Altura dinamica: 250px expandido, 150px comprimido.
                      height: _isExpanded ? 250 : 150,
                      // BoxFit.contain se usa para mostrar la imagen completa.
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      // Placeholder si no hay imagen
                      'lib/Components/assets/report_placeholder.png',
                      height: _isExpanded ? 250 : 150,
                      fit: BoxFit.contain,
                    ),
            ),

            // Seccion de Titulo y Datos Abreviados
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titulo del Reporte
                  Center(
                    child: Text(
                      widget.reporte.titulo,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Fila de Lugar y Fecha
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Ubicación
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.reporte.ubicacion.descripcion,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      // Fecha
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.reporte.fecha!.day}/${widget.reporte.fecha!.month}/${widget.reporte.fecha!.year}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Tipo/Categoria
                  Row(
                    children: [
                      const Icon(Icons.category, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'Tipo: ${widget.reporte.tipo.label}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  // Los detalles adicionales del reporte solo muestran si _isExpanded es true.
                  if (_isExpanded) _buildDetallesAdicionales(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
