package org.example.crieepeche;


public class Bac {
    private Integer numBac;
    private String idDatePeche;
    private String nomEspece;
    private String Presentation;
    private String TypeBac;
    public Bac(){

    }
    public Bac(Integer numBac, String idDatePeche, String nomEspece, String Presentation, String TypeBac)
    {
        this.numBac = numBac;
        this.idDatePeche = idDatePeche;
        this.nomEspece = nomEspece;
        this.Presentation = Presentation;
        this.TypeBac = TypeBac;
    }
    public Integer getNumBac() {
        return numBac;
    }
    public String getNomEspece(){
        return nomEspece;
    }
    public String getIdDatePeche() { return idDatePeche; }
    public String getPresentation() {
        return Presentation;
    }
    public String getTypeBac() {
        return TypeBac;
    }
    public String toString() {
        return "Bac n°"+numBac+" ("+TypeBac+") : "+nomEspece+ " ("+Presentation+")";
    }
}