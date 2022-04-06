package org.example.crieepeche;


public class Espece {
    private int id;
    private String nom;
    private String nomScientifique;
    private String nomCourt;
    public Espece(){

    }
    public Espece (Integer id, String nom, String nomScientifique, String nomCourt)
    {
        this.id = id;
        this.nom = nom;
        this.nomScientifique = nomScientifique;
        this.nomCourt = nomCourt;
    }
    public long getId() {
        return id;
    }
    public String getNom() {
        return nom;
    }
    public String getNomScientifique(){
        return nomScientifique;
    }
    public String getNomCourt() {
        return nomCourt;
    }
}