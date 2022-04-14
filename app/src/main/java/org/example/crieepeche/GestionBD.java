package org.example.crieepeche;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class GestionBD {
    private SQLiteDatabase maBase;
    private BdHelper monBdHelper;
    private ArrayList<Bac> listebacs;
    public GestionBD(Context context) {
        monBdHelper = new BdHelper(context, "bddCriePeche.db", null, 1);
    }
    public void open(){
        maBase = monBdHelper.getWritableDatabase();
        SimpleDateFormat dtf = new SimpleDateFormat("dd/MM/yyyy");
        Calendar calendar = Calendar.getInstance();
        Date dateObj = calendar.getTime();
        String formattedDate = dtf.format(dateObj);
        Log.i("DATABASE", formattedDate);
        listebacs = new ArrayList<Bac>();
        Cursor c = maBase.rawQuery("select Bac.id, idDatePeche, Espece.nom, Presentation.libelle, idTypeBac from Bac inner join Presentation on Presentation.id=Bac.idPresentation inner join Espece on Espece.id=Bac.idEspece where idDatePeche='"+formattedDate+"'",null);
        while (c.moveToNext()) {
            listebacs.add(new Bac(Integer.parseInt(c.getString(0)), c.getString(1), c.getString(2), c.getString(3), c.getString(4)));
        }
    }
    public void close(){
        maBase.close();
    }
    public ArrayList<Bac> donneBacs(){
        return listebacs;
    }
    public void deleteBac(int positionbacdeleted){
        SimpleDateFormat dtf = new SimpleDateFormat("dd/MM/yyyy");
        Calendar calendar = Calendar.getInstance();
        Date dateObj = calendar.getTime();
        String formattedDate = dtf.format(dateObj);
        Log.i("BAC", String.valueOf(positionbacdeleted));
        int idbacdeleted = listebacs.get(positionbacdeleted).getNumBac();
        maBase.execSQL("delete from Bac where id='"+idbacdeleted+"' and idDatePeche='"+formattedDate+"'");
        listebacs.remove(positionbacdeleted);
    }
    public ArrayList<Espece> donneEspece(){
        ArrayList<Espece> liste = new ArrayList<Espece>();
        Cursor c = maBase.rawQuery("select id, nom, nomScientifique, nomCourt from espece",null);
        while (c.moveToNext()) {
            liste.add(new Espece(Integer.parseInt(c.getString(0)), c.getString(1), c.getString(2), c.getString(3)));
        }
        return liste;
    }
}
