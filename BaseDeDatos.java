import java.util.ArrayList;
import java.util.List;

public final class BaseDeDatos {
    static private List<Reporte> reportesPerdidos;
    static private List<Reporte> reportesEncontrados;
    static private List<Reporte> reportesSolucionados;
    public BaseDeDatos(){
        reportesPerdidos = new ArrayList<>();
        reportesEncontrados = new ArrayList<>();
        reportesSolucionados = new ArrayList<>();
    }
    /**Añade un reporte a la lista de reportes correspondiente, de acuerdo al tipo de reporte, si es
     * de un objeto perdido o encontrado.*/
    static public void registrarReporte(Reporte r){
        if (r.tipo == 0) reportesPerdidos.add(r);
        else reportesEncontrados.add(r);
    }
    /**Función llamada por el mediador, saca a dos reportes de sus repectivas listas y los añade a la lista de reportes
     * solucionados.*/
    public void registrarPareja(Reporte rP, Reporte rE){
        eliminarReporte(rP);
        eliminarReporte(rE);
        reportesSolucionados.add(rP);
        reportesSolucionados.add(rE);
    }
    /**Elimina a un reporte de su lista correspondiente de acuerdo a su tipo*/
    static public void eliminarReporte(Reporte r){
        if (r.tipo == 0) reportesPerdidos.remove(r);
        else reportesEncontrados.remove(r);
    }
    public List<Reporte> getReportesPerdidos(){
        return reportesPerdidos;
    }
    public List<Reporte> getReportesEncontrados(){
        return reportesEncontrados;
    }
    public List<Reporte> getReportesSolucionados(){
        return  reportesSolucionados;
    }



}

class Reporte{
    int tipo;
}