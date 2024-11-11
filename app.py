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

connexion = mysql.connector.connect(
    host=db_host,
    user=db_user,
    password=db_password,
    database=db_name,
    port=db_port
)

nom = "";
telephone = "";
addresse = "";
croute = "";
sauce = "";
garniture1 = "";
garniture2 = "";
garniture3 = "";
garniture4 = "";

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/confirmeCommande', methods=['POST'])
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

if (__name__ == '__main__'):
    app.run(debug=True)
