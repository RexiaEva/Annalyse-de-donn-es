import pandas as pd
import numpy as np
import mysql.connector

from base_donnee import *

def main():
    # On crée notre objet connexion mySQL
    connexion = Base_donnee()
    connexion.gen_connexion()
    connexion.creer_curseur()

    def slicer (liste, pourcentage):
        """
        Cette fonction découpe une liste A en liste B nestée
        remplie de petits bouts issus de la liste A. Le pourcentage
        de 0 à 1
        correspondra à la taille des listes nestées dans le resultat.
        
        Par exemple, 0.5 donnera une liste nestée contenant deux slices,
        0.1 donnera des slices d'une taille de 10% de la liste A, etc.
        """

        # Gestion du cas où l'on rentrerait 0 au lieu d'une taille valide de slice.
        if pourcentage == 0:
            pourcentage +=1
            print("Le pourcentage ne doit pas être nul. Pourcentage repassé à 1.")
        
        resultat = []
        taille_liste = len(liste)

        taille_slices = taille_liste * pourcentage
        
        # variable qui fait la navette entre la liste d'éléments et la liste de listes nestées pour la charger :
        navette = []
        i = 0

        while i < taille_liste:

            # Si groupe pas fini, on lui ajoute l'élément de rang i et on incrémente i.
            if len(navette) < taille_slices:
                navette.append(liste[i])
                i+=1

            # Si groupe a atteint la taille visée, on l'ajoute à la liste de groupes et on le vide.
            else:
                resultat.append(navette)
                navette = []

        # Ajout d'un éventuel dernier groupe réduit (+ rapide sans condition pour tester si un tel groupe existe).
        resultat.append(navette)

        return resultat

    def liste_to_tuple(df):
        print("1 :",len(df))
        df = np.array(df)
        print("2 :", len(df))
        liste = df.tolist()
        print("3 :", len(liste))
        for i in range(len(liste)):
            liste[i] = tuple(liste[i])
        return liste

    df = pd.read_csv("./data/athlete_events.csv")
    df2 = pd.read_csv("./data/noc_regions.csv")
    # merged = pd.merge(df, df2, on='NOC', how="left")

    liste_NOC = df2[["NOC", "region", "notes"]]
    liste_NOC = liste_NOC.fillna("nan")

    liste_NOC = liste_to_tuple(liste_NOC)
    liste_NOC = list(set(liste_NOC))

    # Remplissage nocs :
    print("la liste de noc", liste_NOC)
    slices_nocs = slicer(liste_NOC, 0.5)

    print("taille slices NOC :", len(slices_nocs))

    for i in slices_nocs:
        print(len(i))
        connexion.inserer_nocs_base(i)
    
    # Remplissage table équipes :

    liste_equipes = df[["Team","NOC"]]
    # Retrait des valeurs SGP pour la colonne NOC des athlètes (elles n'ont pas de contrepartie dans la bdd NOC).
    liste_equipes = liste_equipes.drop(liste_equipes[liste_equipes["NOC"] == "SGP"].index)

    print("yo", type(liste_equipes))
    liste_equipes = liste_to_tuple(liste_equipes)
    liste_equipes = list(set(liste_equipes))

    # Destruction des doublons grâce à un passage par le type set
    #TENTER AVEC UN PANDAS UNIQUE
    #liste_equipes = list(set(liste_equipes))

    print("yo", len(liste_equipes))

    slices_teams = slicer(liste_equipes, 0.2)
    print("taille slices team :", len(slices_teams))

    for i in slices_teams :
        connexion.inserer_equipes_base(i)


    # Remplissage table athletes :
    liste_athletes = df[["ID","Name","Sex"]]
    liste_athletes = liste_to_tuple(liste_athletes)
    liste_athletes = list(set(liste_athletes))

    slices_athletes = slicer(liste_athletes, 0.2)
    
    for i in slices_athletes :
        connexion.inserer_athletes_base(i)

    # Remplissage table jeux :
    liste_jeux = df[["Games","Year", "Season", "City"]]

    liste_jeux = liste_to_tuple(liste_jeux)
    liste_jeux = list(set(liste_jeux))

    slices_jeux = slicer(liste_jeux, 0.2)
    
    for i in slices_jeux :
        connexion.inserer_jeux_base(i)
    


main()