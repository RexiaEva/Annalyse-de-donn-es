import pandas as pd 
import numpy as np
import mysql.connector

def liste_to_tuple(df, table):
    df = np.array(df)
    liste = df.tolist()   
    for i in range(len(liste)):
        liste[i].insert(0, table)
        liste[i] = tuple(liste[i])
    return liste

athlete = pd.read_csv("archive/athlete_event_small.csv")
noc = pd.read_csv("archive/noc_regions.csv")

NOC = noc[["NOC", "region", "notes"]]

JO = athlete[["City", "Season"]]
participer = athlete[["Age","Medal","Height", "Weight"]]
team = athlete[["Team"]]
_athlete = athlete[["Name", "Sex"]]
evenelent = athlete[["Event"]]
sport = athlete[["Sport"]]

values_counts_name = _athlete.groupby(by=["Name"]).sum()
print(values_counts_name)
