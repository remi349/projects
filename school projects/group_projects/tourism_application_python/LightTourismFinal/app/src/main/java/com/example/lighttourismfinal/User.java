package com.example.lighttourismfinal;

import android.content.Context;
import android.content.SharedPreferences;

import androidx.appcompat.app.AppCompatActivity;

public class User extends AppCompatActivity {

    private String username = "...";
    private String password = "...";
    private String email = "...";
    Context context = getApplicationContext();

    SharedPreferences testPref = getSharedPreferences("pref", MODE_PRIVATE);

    //TODO
    // Faire un profil stocké sur le serveur pour chaque utilisateur
    // Objectif : stocker les facteur pré-log pour chaque utilisateur et lui donner la possibilité de les voir et de les régler
    // Ajouter un bouton qui, si actif, ne propose pas les lieux déjà visité
    // Chacune des 3 vignettes proposent le nom du lieu, un bouton itinéraire, une très courte description et une image
    // Pour les évènements créés par les utilisateur, il faut pouvoir accéder à l'espace commentaire
    // Faire une activité pour se connecter/déconnecter
    // .
    // Stockage :
    // - Serveur
    // -- les facteur pré-log
    // .
    // .
    // - Local
    // -- lieux déjà visités
    // .
    // Gérer les concurrences de création d'évènement
    // Faire un espace commentaire pour les évènements créés par les utilisateurs
    // Faire un profil par défaut si l'utilisateur n'a pas de profil où tous les facteurs pré-log sont à 1ç


    //utiliser setImage pour mettre l'image depuis une adresse url sur l'imageView
}
