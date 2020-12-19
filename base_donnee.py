import mysql.connector as mysqlcon

class Base_donnee():

    def __init__ (self):
        self.host = 'localhost'
        self.port = 8081
        self.user = 'root'
        self.mdp = 'root'
        self.nom = 'jo'
        self.conn = None
        self.curseur = None 

    #############
    # CONNEXION #
    #############

    #Générer la connexion:
    def gen_connexion (self):

        #On teste si la connexion à la bdd n'existe pas :
        if self.conn == None:
            #Si pas de connexion, on en crée une à la bdd souhaitée en paramètre de la méthode :
            connexion = mysqlcon.connect(port = self.port,
                                        host = self.host,
                                        user = self.user,
                                        password = self.mdp,
                                        database = self.nom)

            setattr(self, "conn", connexion)       
    
    def fermer_connexion (self):
        self.conn.close()


    ###########
    # CURSEUR #
    ###########

    def creer_curseur (self):
        self.curseur = self.conn.cursor(buffered=True)

    def fermer_curseur (self, curseur):
        self.curseur.close()


    ############
    # REQUÊTES #
    ############

    def inserer_nocs_base(self, var):    
        sql = "INSERT INTO nocs (id_noc, noc, region, notes) VALUES (NULL,%s,%s,%s);"
        self.curseur.executemany(sql, var)
        self.conn.commit()

    def inserer_equipes_base(self, var):
        """
        docstring
        """
        sql = "INSERT INTO equipes (id_equipe, nom, id_noc) VALUES (NULL, %s, (SELECT nocs.id_noc FROM nocs WHERE nocs.noc =%s));"
        self.curseur.executemany(sql, var)
        self.conn.commit()