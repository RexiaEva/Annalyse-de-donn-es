import pandas as pd 
import numpy as np
import mysql.connector

from base_donnee import *

def main():
    # On crée notre objet connexion mySQL
    connexion = Base_donnee()
    connexion.gen_connexion()
    connexion.creer_curseur()

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

    NOC = df2[["NOC", "region", "notes"]]
    NOC = NOC.fillna("nan")
    NOC = liste_to_tuple(NOC)

    Team = df[["Team","NOC"]]
    # Retrait des valeurs SGP pour la colonne NOC des athlètes (elles n'ont pas de contrepartie dans la bdd NOC).
    Team = Team.drop(Team[Team["NOC"] == "SGP"].index)

    # team_noc = Team["NOC"]


    # team_noc = team_noc.tolist()
    # team_noc = liste_to_tuple(team_noc)
    print("yo", type(Team))
    Team = liste_to_tuple(Team)
    # Destruction des doublons grâce à un passage par le type set
    Team = list(set(Team))
    print("yo", len(Team))

    # Possibilité, créer une fonction slicer générique à partir de l'idée suivante :
    slices_nocs = []
    slices_nocs.append(NOC[:int(len(NOC)*0.2)])
    slices_nocs.append(NOC[int(len(NOC)*0.2):int(len(NOC)*0.4)])
    slices_nocs.append(NOC[int(len(NOC)*0.4):int(len(NOC)*0.6)])
    slices_nocs.append(NOC[int(len(NOC)*0.6):int(len(NOC)*0.8)])
    slices_nocs.append(NOC[int(len(NOC)*0.8):])

    print("taille slices NOC :", len(slices_nocs))

    for i in slices_nocs:
        print(len(i))
        connexion.inserer_nocs_base(i)

    # Possibilité, créer une fonction slicer générique à partir de l'idée suivante :
    slices_teams = [] 
    slices_teams.append(Team[:int(len(Team)*0.05)])
    slices_teams.append(Team[int(len(Team)*0.05):int(len(Team)*0.10)])
    slices_teams.append(Team[int(len(Team)*0.1):int(len(Team)*0.15)])
    slices_teams.append(Team[int(len(Team)*0.15):int(len(Team)*0.20)])
    slices_teams.append(Team[int(len(Team)*0.20):int(len(Team)*0.25)])
    slices_teams.append(Team[int(len(Team)*0.25):int(len(Team)*0.30)])
    slices_teams.append(Team[int(len(Team)*0.30):int(len(Team)*0.35)])
    slices_teams.append(Team[int(len(Team)*0.35):int(len(Team)*0.40)])
    slices_teams.append(Team[int(len(Team)*0.40):int(len(Team)*0.45)])
    slices_teams.append(Team[int(len(Team)*0.45):int(len(Team)*0.50)])
    slices_teams.append(Team[int(len(Team)*0.50):int(len(Team)*0.55)])
    slices_teams.append(Team[int(len(Team)*0.55):int(len(Team)*0.60)])
    slices_teams.append(Team[int(len(Team)*0.60):int(len(Team)*0.65)])
    slices_teams.append(Team[int(len(Team)*0.65):int(len(Team)*0.70)])
    slices_teams.append(Team[int(len(Team)*0.70):int(len(Team)*0.75)])
    slices_teams.append(Team[int(len(Team)*0.75):int(len(Team)*0.80)])
    slices_teams.append(Team[int(len(Team)*0.80):int(len(Team)*0.85)])
    slices_teams.append(Team[int(len(Team)*0.85):int(len(Team)*0.90)])
    slices_teams.append(Team[int(len(Team)*0.90):int(len(Team)*0.95)])
    slices_teams.append(Team[int(len(Team)*0.95):])

    print("taille slices team :", len(slices_teams))

    # def decoupeur_liste (liste, pourcentage):
    #     """Cette fonction découpe une liste en liste de listes dont
    #     la taille corresponda à un pourcentage donné de celle de la
    #     liste en paramètre"""
    #     for i in range(1/pourcentage):

    for i in slices_teams :
        connexion.inserer_equipes_base(i)

main()