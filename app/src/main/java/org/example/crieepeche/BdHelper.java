package org.example.crieepeche;


import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;
import android.widget.Toast;

public class BdHelper extends SQLiteOpenHelper {
    public BdHelper(Context context, String name,
                    SQLiteDatabase.CursorFactory factory,int version) {
        super(context, name, factory, version);
        // TODO Auto-generated constructor stub
    }
    @Override
    public void onCreate(SQLiteDatabase db) {;
        // TODO Auto-generated method stub;
        String req = "create table Espece(id integer primary key, nom text, nomScientifique text, nomCourt text);";
        db.execSQL(req);
        req = "insert into Espece values(33760,'Baudroie','Lophius Piscatorus','BAUDR');";
        db.execSQL(req);
        req = "insert into Espece values(33090,'Bar de Chalut','Dicentrarchus Labrax','BARCH');";
        db.execSQL(req);
        req = "insert into Espece values(33091,'Bar de Ligne','Dicentrarchus Labrax','BARLI');";
        db.execSQL(req);
        req = "insert into Espece values(32130,'Lieu Jaune de Ligne','Pollachius pollachius','LJAUL');";
        db.execSQL(req);
        req = "insert into Espece values(42040,'Araignée de mer casier','Maja squinado','ARAIS');";
        db.execSQL(req);
        req = "insert into Espece values(42041,'Araignée de mer chalut','Maja squinado','ARAIL');";
        db.execSQL(req);
        req = "insert into Espece values(43010,'Homard','Hammarus gammorus','HOMAR');";
        db.execSQL(req);
        req = "insert into Espece values(43030,'Langouste rouge','Palinurus elephas','LANGR');";
        db.execSQL(req);
        req = "insert into Espece values(32140,'Lieu Noir','Lophius Virens','LNOI');";
        db.execSQL(req);
        req = "insert into Espece values(31020,'Turbot','Psetta maxima','TURBO');";
        db.execSQL(req);
        req = "insert into Espece values(33480,'Dorade rose','Pagellus bogaraveo','DORAD');";
        db.execSQL(req);
        req = "insert into Espece values(38150,'Raie douce','Raja Montagui','RAIE');";
        db.execSQL(req);
        req = "insert into Espece values(33020,'Congre commun','Conger conger','CONGR');";
        db.execSQL(req);
        req = "insert into Espece values(32020,'Merlu','Merluccius bilinearis','MERLU');";
        db.execSQL(req);
        req = "insert into Espece values(31030,'Barbue','Scophthalmus rhombus','BARBU');";
        db.execSQL(req);
        req = "insert into Espece values(31150,'Plie ou carrelet','Pleuronectes Platessa','PLIE');";
        db.execSQL(req);
        req = "insert into Espece values(32050,'Cabillaud','Gadus Morhua Morhue','CABIL');";
        db.execSQL(req);
        req = "insert into Espece values(32230,'Lingue franche','Molva Molva','LINGU');";
        db.execSQL(req);
        req = "insert into Espece values(33080,'Saint Pierre','Zeus Faber','STPIE');";
        db.execSQL(req);
        req = "insert into Espece values(33110,'Mérou ou cernier','Polyprion Americanus','CERNI');";
        db.execSQL(req);
        req = "insert into Espece values(33120,'Mérou noir','Epinephelus Guaza','MEROU');";
        db.execSQL(req);
        req = "insert into Espece values(33410,'Rouget Barbet','Mullus SPP','ROUGT');";
        db.execSQL(req);
        req = "insert into Espece values(33450,'Dorade royale chalut','Sparus Aurata','DORAC');";
        db.execSQL(req);
        req = "insert into Espece values(33451,'Dorade royale ligne','Sparus Aurata','DORAL');";
        db.execSQL(req);
        req = "insert into Espece values(33490,'Pageot Acarne','Pagellus Acarne','PAGEO');";
        db.execSQL(req);
        req = "insert into Espece values(33500,'Pageot Commun','Pagellus Arythrinus','PAGEC');";
        db.execSQL(req);
        req = "insert into Espece values(33580,'Vieille','LabrusBergylta','VIEIL');";
        db.execSQL(req);
        req = "insert into Espece values(33730,'Grondin gris','Eutrigla Gurnadus','GRONG');";
        db.execSQL(req);
        req = "insert into Espece values(33740,'Grondin rouge','Aspitrigla Cuculus','GRONR');";
        db.execSQL(req);
        req = "insert into Espece values(33761,'Baudroie Maigre','Lophius Piscicatorius','BAUDM');";
        db.execSQL(req);
        req = "insert into Espece values(33790,'Grondin Camard','Trigloporus Lastoviza','GRONC');";
        db.execSQL(req);
        req = "insert into Espece values(33800,'Grondin Perlon','Trigla Lucerna','GRONP');";
        db.execSQL(req);
        req = "insert into Espece values(34150,'Mulet','Mugil SPP','MULET');";
        db.execSQL(req);
        req = "insert into Espece values(35040,'Sardine atlantique','Sardina Pilchardus','SARDI');";
        db.execSQL(req);
        req = "insert into Espece values(37050,'Maquereau','Scomber Scombrus','MAQUE');";
        db.execSQL(req);
        req = "insert into Espece values(38160,'Raie Pastenague commune','Dasyatis Pastinaca','RAIEP');";
        db.execSQL(req);
        req = "insert into Espece values(42020,'Crabe tourteau de casier','Cancer Pagurus','CRABS');";
        db.execSQL(req);
        req = "insert into Espece values(42021,'Crabe tourteau de chalut','Cancer Pagurus','CRABL');";
        db.execSQL(req);
        req = "insert into Espece values(44010,'Langoustine','Nephrops norvegicus','LANGT');";
        db.execSQL(req);
        req = "insert into Espece values(57010,'Seiche','Sepia SPP','SEICH');";
        db.execSQL(req);
        req = "insert into Espece values(57020,'Calmar','Loligo SPP','CALAM');";
        db.execSQL(req);
        req = "insert into Espece values(57050,'Poulpe','Octopus SPP','POULP');";
        db.execSQL(req);
        req = "create table Presentation(id text primary key, libelle text);";
        db.execSQL(req);
        req = "insert into Presentation values('ET','Etété');";
        db.execSQL(req);
        req = "insert into Presentation values('ENT','Entier');";
        db.execSQL(req);
        req = "insert into Presentation values('VID','Vidé');";
        db.execSQL(req);
        req = "create table TypeBac(id text primary key, tare real);";
        db.execSQL(req);
        req = "insert into TypeBac values('B',2.50);";
        db.execSQL(req);
        req = "insert into TypeBac values('F',4);";
        db.execSQL(req);
        req = "create table Bac(id integer, idDatePeche text,idEspece integer, idPresentation text, idTypeBac text, foreign key (idEspece) references Espece(id), foreign key (idPresentation) references Presentation(id), foreign key (idTypeBac) references TypeBac(id), primary key(id, idDatePeche));";
        db.execSQL(req);
        req = "create table Utilisateur(id integer primary key, login text, token text, issync int, datelastsync text);";
        db.execSQL(req);
        req = "insert into Bac values(1,'05/04/2022', 44010, 'VID', 'F');";
        db.execSQL(req);
        req = "insert into Bac values(2,'05/04/2022', 37050, 'ET', 'B');";
        db.execSQL(req);
        req = "insert into Bac values(3,'05/04/2022', 44010, 'ET', 'F');";
        db.execSQL(req);
        req = "insert into Bac values(4,'05/04/2022', 37050, 'ET', 'B');";
        db.execSQL(req);
        req = "insert into Bac values(1,'06/04/2022', 34150, 'ENT', 'B');";
        db.execSQL(req);
        req = "insert into Bac values(2,'06/04/2022', 37050, 'VID', 'F');";
        db.execSQL(req);
        req = "insert into Bac values(3,'06/04/2022', 33730, 'ET', 'B');";
        db.execSQL(req);
        req = "insert into Bac values(4,'06/04/2022', 33580, 'ENT', 'B');";
        db.execSQL(req);
        req = "insert into Bac values(5,'06/04/2022', 33580, 'VID', 'B');";
        db.execSQL(req);
        req = "insert into Bac values(6,'06/04/2022', 33730, 'ET', 'F');";
        db.execSQL(req);
        req = "insert into Bac values(7,'06/04/2022', 33500, 'VID', 'B');";
        db.execSQL(req);
    }
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int
            newVersion) {
        // TODO
        String req1 = "DROP TABLE IF EXISTS Utilisateur;";
        db.execSQL(req1);
        req1 = "DROP TABLE IF EXISTS Bac;";
        db.execSQL(req1);
        req1 = "DROP TABLE IF EXISTS TypeBac;";
        db.execSQL(req1);
        req1 = "DROP TABLE IF EXISTS Presentation;";
        db.execSQL(req1);
        req1 = "DROP TABLE IF EXISTS Espece;";
        db.execSQL(req1);
        onCreate(db);
    }
    public void readData(SQLiteDatabase db) {
        Cursor cursor = db.query("client", new String[]{"id", "nom", "tel"}, null,
                null, null, null, null);
        cursor.moveToFirst();
        Log.i("bd", "avant cursor");
        while (!cursor.isAfterLast()) {
            long id = cursor.getLong(0);
            String name = cursor.getString(1);
            String phone = cursor.getString(2);
            Log.i("bd", name + " " + phone);
            cursor.moveToNext();
        }
        // assurez-vous de la fermeture du curseur
        cursor.close();
    }
}

