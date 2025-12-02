import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/database.dart';
import 'reporte.dart';

class TarjetaDePar extends StatefulWidget {
  final Solucion solucion;
  final bool
  isSelected; // Indica si la tarjeta debe estar expandida (controlada por ListaReportes).
  final ValueChanged<Solucion>
  onTap; // Callback para notificar al ListaReportes al ser tocada.

  const TarjetaDePar({
    super.key,
    required this.solucion,
    required this.onTap,
    this.isSelected = false,
  });

  // Constructor factory para crear la tarjeta desde un objeto Reporte
  //(es por una cuestion de simplicidad al instanciar en ListaReportes).
  factory TarjetaDePar.fromSolucion(
    Solucion s, {
    required ValueChanged<Solucion> onTap,
    bool isSelected = false,
  }) {
    return TarjetaDePar(solucion: s, onTap: onTap, isSelected: isSelected);
  }

  @override
  State<TarjetaDePar> createState() => _TarjetaDeParState();
}

class _TarjetaDeParState extends State<TarjetaDePar> {
  late bool
  _isExpanded; // Estado interno para controlar si el contenido adicional es visible

  @override
  void initState() {
    super.initState();
    // Inicializa el estado interno con el valor que viene de ListaReportes (widget.isSelected)
    _isExpanded = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant TarjetaDePar oldWidget) {
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
  Widget _buildDetallesAdicionales(Reporte reporte) {
    // Determina el tipo de estado del reporte (perdido encontrado)
    final isPerdido = reporte.estado.toString().contains('perdido');

    List<Widget> details = [
      const Divider(),

      // Muestra el Estado del Reporte (para los dos).
      Text(
        'Estado: ${reporte.estado.toString().split('.').last.toUpperCase()}',
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
      Text(reporte.descripcion, style: const TextStyle(fontSize: 14)),
      const SizedBox(height: 8),

      // Detalles específicos del Usuario
      if (isPerdido) ...[
        // Nombre del usuario
        Text(
          'Contacto (Nombre):',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(reporte.ident.id_o_nombre, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 4),

        // Numero de contacto
        Text(
          'Teléfono:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          reporte.ident.numero ?? 'N/A',
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),

        // Correo de contacto
        Text(
          'Correo:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          reporte.ident.correo ?? 'N/A',
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
        Text(reporte.ident.id_o_nombre, style: const TextStyle(fontSize: 14)),
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
    Reporte perdido = widget.solucion.perdido;
    Reporte encontrado = widget.solucion.encontrado;
    // Inkwell es un widget que detecta gestos de toque, en este caso para expandir/comprimir la tarjeta
    return InkWell(
      onTap: () {
        // Al tocar, llama al callback para que el ListaReportes maneje la selección
        widget.onTap(widget.solucion);
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // Cambia el color si está seleccionado/expandido para destacar
        color: widget.isSelected ? Colors.lightBlue.shade50 : Colors.white,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: ReporteIndividual(perdido)),
              VerticalDivider(
                color: Colors.grey,
                thickness: 2,
                width: 20,
                indent: 12,
                endIndent: 12,
              ),
              Expanded(child: ReporteIndividual(encontrado)),
            ],
          ),
        ),
      ),
    );
  }

  Widget ReporteIndividual(Reporte reporte) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Contenedor de la Imagen
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: (reporte.imagen != null && reporte.imagen!.bytes != null)
              ? Image.memory(
                  reporte.imagen!.bytes!,
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
                  reporte.titulo,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),

              // columna con lugar y fecha cuando está expandido por si ubicación es muy larga
              _isExpanded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Ubicación completa, multilinea
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                reporte.ubicacion.descripcion,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              reporte.fecha != null
                                  ? '${reporte.fecha!.day}/${reporte.fecha!.month}/${reporte.fecha!.year}'
                                  : 'Sin fecha',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Ubicación
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  reporte.ubicacion.descripcion,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
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
                              '${reporte.fecha!.day}/${reporte.fecha!.month}/${reporte.fecha!.year}',
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
                    'Tipo: ${reporte.tipo.label}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              // Los detalles adicionales del reporte solo muestran si _isExpanded es true.
              if (_isExpanded) _buildDetallesAdicionales(reporte),
            ],
          ),
        ),
      ],
    );
  }
}
