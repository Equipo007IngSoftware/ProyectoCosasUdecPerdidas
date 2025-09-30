import java.util.ArrayList;

public class Usuario {
    String email;
    String numContacto;
    ArrayList<Reporte> listaReportes=new ArrayList<Reporte>();

    public Usuario(String mail, String cont){
        this.email=mail;
        this.numContacto=cont;
    }

    void crearReporte(ArrayList<String> cualidad,String ubi){
        listaReportes.add(new Reporte(this,new Objeto(cualidad,ubi),ObjEstado.perdido));
    }

    void borrarReporte(Reporte r){
        r.marcarComoEncontrado();
        listaReportes.remove(r);
    }
}