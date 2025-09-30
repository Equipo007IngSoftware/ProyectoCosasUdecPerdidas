public class Administrador {
    private String ubicacion;
    public Administrador(String ubicacion){
        this.ubicacion=ubicacion;
    }
    public void eliminarReporte(Reporte r){
        BaseDeDatos.eliminarReporte(Reporte r);
    }
    public Reporte crearReporte(){
        BaseDeDatos.crearReporte();
    }
}

