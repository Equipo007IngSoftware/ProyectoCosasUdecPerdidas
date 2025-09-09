**Visión del problema**  
 En el campus de la universidad es fácil que miembros de esta o externos pierdan objetos dentro del campus de la universidad, lo que puede generar angustia, estrés, entre otros. Cuando estas ocasiones ocurren, falta un método para facilitar a quien pierde sus objetos el poder recuperarlos desde inspectoría, una vez fueron entregados, saber si fue encontrado y dónde lo puede encontrar, ya que la universidad cuenta con múltiples edificios.  
Notemos que los objetos (por protocolos actuales) siempre deberían llegar a manos de un miembro de la comunidad con la capacidad de hacer llegar estos objetos a la zona designada de objetos perdidos en la vecindad.

**Visión de la Solución**  
*Nota: Por usuario nos referimos a la persona que perdió el objeto y administrador es quién recibe el objeto y es responsable por su almacenamiento.*  
 Suponemos que los objetos que pueden ser recuperados tienen que tener un cierto valor asumido por las personas que los encuentren y quieran entregarlos, y que el usuario que lo extravió va con una expectativa de lo que es recuperable o no.  
 Un administrador recibe un objeto y lo añade a los objetos encontrados a través de nuestra solución software; el usuario al notar que pierde el objeto lo registra como objeto perdido en el software, finalmente un actor verifica la correspondencia entre los objetos perdidos y encontrados, al identificar la correlación, el software avisa al dueño del objeto que este fue encontrado y donde puede buscarlo (luego de verificaciones de pertenencia adecuados).

\-Administradores tienen facultades para editar descripciones de objetos encontrados con más detalles o información de ubicación.  
\-Tiempo de almacenamiento de objetos se adapta a las políticas de cada departamento en los que los objetos se encuentren.  
\-Se solicita acreditación por parte del usuario, un correo, número de contacto y descripción más detallada del objeto para verificar que el objeto sea suyo. También el usuario debería hacer el reporte dentro de 24 horas de ser perdido.

**Actores**

|  Actores |  Descripción Breve |  Acciones Permitidas |
| ----- | :---- | :---- |
|  **El que los pierde** | Aquellos usuarios que extravíen pertenencias en los confines de la universidad o sospechen que ese sea el caso. |  Crear reporte de objeto extraviado, recibir notificaciones de pareos confirmados, confirmar la recuperación de la pertenencia |
|  **El que lo encuentra** | Personas que, al merodear por los confines de la universidad, se encuentran con una pertenencia extraviada | Recibir indicaciones de a que mediador entregar la pertenencia |
| **Administrador** | Persona de autoridad dentro de la Universidad administra las peticiones de objetos perdidos antes de notificar a los usuarios involucrados | Crear reportes de objetos encontrados, confirmar parejos del sistema. |
| **Mediador** | Plataforma encargada de procesar los reportes de pertenencias extraviadas y ordenar parejos por compatibilidad | Analizar información de reportes de pertenencias extraviadas/encontradas para ordenar pareos apropiadamente. |

**Requisitos Funcionales**

| ID | Título | Prioridad | Descripción breve |
| :---- | :---- | :---- | :---- |
| R1. | Captar Objetos Perdidos | M | Quien pierde el objeto hace un reporte |
| R2. | Captar Objetos Encontados | M | El administrador reporta objetos encontrados |
| R3. | Relacionar Objetos perdidos y encontrados | M | El mediador relaciona los objetos perdidos y encontrados |
| R4. | Notificar a dueño | M | Se notifica a quien pierde el objeto |
| R5. | Visualización de objetos | M | El administrador puede ver los reportes |
| R6. | Verificación de identidad | M | Quien pierde el objeto tiene que demostrar que el objeto es suyo |
| R7. | Eliminación de resueltos | S | Al resolver un caso se elimina el objeto de las listas |
| R8. | Historial de reportes visibles al usuario con pertenencia extraviada | S | El usuario puede ver los reportes que realizó y su estado, con la posibilidad de cambiarlo en caso de encontrarlo |

**Requisitos No Funcionales**

|  Categoria |  Requisito |  Justificación |
| :---- | :---- | :---- |
|  Seguridad | Cumplir con las normativa universitaria. Solo quien perdió el objeto y los administradores pueden ver los reportes | Como la solución va a interactuar con el ambiente universitario bajo su consentimiento debe hacerlo según su normativa. |
|  Usabilidad | Se debe poder acceder a la solución mediante dispositivos táctiles y computadores. El software no necesita instalación previa de parte de quien pierde el objeto | Aumentar el tipo de medios para acceder a la solución hace más probable su aprovechamiento. La solución está destinada a una eventualidad no planeada, así que debe ser fácil de acceder |
| Rendimiento | El algoritmo empleado para verificar las coincidencias debe permitir hacer 100 verificaciones en 1 segundo | Reducir los tiempos de respuesta entre los actores hace más eficiente el cumplimiento del proceso. |
| Confiabilidad | Que el sistema sea accesible dentro de horarios laborales de la universidad un 99.3% del tiempo.  | Esto hace que se pueda acceder a la solución en el momento oportuno y no se tenga que esperar para hacer un reporte.  |

