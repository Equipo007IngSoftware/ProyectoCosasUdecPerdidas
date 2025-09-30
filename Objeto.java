import java.util.ArrayList;

public class Objeto {
    private String ubicacion;
    private ArrayList<String> cualidades;
    public Objeto(ArrayList<String> cualidades, String ubicacion){  //se crearía en usuario.crearReporte()
        this.cualidades=cualidades;
        this.ubicacion=ubicacion;
    }
    public String getUbicacion(){
        return ubicacion;
    }
    public ArrayList<String> getListaCualidades(){
        return cualidades;
    }
    public void showCualidades(){
        for(String atri:cualidades){
            System.out.println(atri+"\n");
        }
    }

}
