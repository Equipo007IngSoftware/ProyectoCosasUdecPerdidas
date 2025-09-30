public class Reporte{
    private Date fecha;
    private ObjEstado estado;
    private Objeto objetoAsociado;

    private Persona autor;

    Reporte(Persona yo, Objeto objetoAsociado, ObjEstado estado){
        this.autor = yo;
        this.fecha = Date.now();
        this.objetoAsociado = objetoAsociado;
        this.estado = estado;

        if (estado == ObjEstado.perdido)
            DataBase.registrarReportePerdido(this);
        else if (estado == ObjEstado.encontrado)
            DataBase.registrarReporteEncontrado(this);
    }

    void marcarComoEncontrado(){
        DataBase.eliminarReportePerdido(this);
    } 

    Date getFecha(){return fecha;}
    int getEstado(){return estado;}
    Objeto getObjeto(){return objetoAsociado;}
    Persona getAutor(){return autor;}

    String getUbicacion(){return objetoAsociado.getUbicacion();}

    void setEstado(int estado){
        this.estado = estado;
    }
}