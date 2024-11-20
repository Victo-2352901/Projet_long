import os
from dotenv import load_dotenv
from flask import Flask, render_template, request
import mysql.connector

app = Flask(__name__)

# Charge les variables d'environnement à partir du fichier .env
load_dotenv()

# Récupère les variables d'environnement
db_host = os.getenv('DB_HOST')
db_user = os.getenv('DB_USER')
db_password = os.getenv('DB_PASSWORD')
db_name = os.getenv('DB_NAME')
db_port = os.getenv('DB_PORT')

# Connecte à la base de donnée
connexion = mysql.connector.connect(
    host=db_host,
    user=db_user,
    password=db_password,
    database=db_name,
    port=db_port
)

# Vérifie si la connexion est établie
if connexion.is_connected():
    print("Connexion réussie à la base de données")
else:
    print("Échec de la connexion à la base de données")

@app.route('/')
# Redirige sur la page index.html
def index():
    return render_template('index.html')

@app.route('/formulairePizza')
# Récupère les informations de la pizza de la la base de donnée pour que l'utilisateur puisse choisir ce qu'il désire
def formulairePizza():
    cursor = connexion.cursor()
    cursor.execute("SELECT * FROM garnitures")
    garnitures = cursor.fetchall()

    cursor.execute("SELECT * FROM sauces")
    sauces = cursor.fetchall()

    cursor.execute("SELECT * FROM croutes")
    croutes = cursor.fetchall()


    cursor.close()


    return render_template('formulairePizza.html', garnitures=garnitures, sauces=sauces,croutes=croutes)


@app.route('/confirmeCommande', methods=['POST'])
# Récupère les informations entrée par l'utilisateur pour ensuite affiché un résumé
def greet():
    nom = request.form['nom']
    telephone = request.form['telephone']
    addresse = request.form['addresse']
    croute = request.form['croute']
    sauce = request.form['sauce']
    garniture1 = request.form['garniture1']
    garniture2 = request.form['garniture2']
    garniture3 = request.form['garniture3']
    garniture4 = request.form['garniture4']
    return render_template('confirmeCommande.html', nom=nom, telephone=telephone,addresse=addresse,croute=croute,sauce=sauce,garniture1=garniture1,garniture2=garniture2,garniture3=garniture3,garniture4=garniture4)

@app.route('/insertionPizza', methods=['POST'])
# Insère les informations de l'utilisateur dans la base de donnée
def insertion():
    nom = request.form['nom']
    telephone = request.form['telephone']
    addresse = request.form['addresse']
    croute = request.form['croute']
    sauce = request.form['sauce']
    garniture1 = request.form['garniture1']
    garniture2 = request.form['garniture2']
    garniture3 = request.form['garniture3']
    garniture4 = request.form['garniture4']

    cursor = connexion.cursor()
    cursor.execute("INSERT INTO clients (nom, telephone) VALUES (%s, %s)", (nom, telephone))
    new_id = cursor.lastrowid
    connexion.commit()
    cursor.close()
    
    cursor = connexion.cursor()
    cursor.execute("INSERT INTO commandes (client_id, sauce, croute, garniture1, garniture2, garniture3, garniture4, addresse) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", (new_id, sauce, croute, garniture1, garniture2, garniture3, garniture4, addresse))
    connexion.commit()
    cursor.close()

    return render_template('/index.html')


@app.route('/afficheCommande')
# Récupère les informations des livraisons en attente
def afficheCommande():

    attente = "En attente"
    cursor = connexion.cursor()
    cursor.execute("SELECT * FROM livraisons WHERE status = %s", (attente,))
    commandes = cursor.fetchall()
    cursor.close()

    return render_template('afficheCommandes.html', commandes=commandes)

@app.route('/changerEtat', methods=['POST'])
# Change l'état des livraisons en attente pour livré quand elle sont livré
def changerEtat():
    id_livraison = request.form['id_livraison']
    
    cursor = connexion.cursor()
    cursor.execute("UPDATE livraisons SET status = %s WHERE id = %s", ("Livré",id_livraison))
    connexion.commit()
    cursor.close()

    return render_template('/index.html')


if (__name__ == '__main__'):
    app.run(debug=True)
