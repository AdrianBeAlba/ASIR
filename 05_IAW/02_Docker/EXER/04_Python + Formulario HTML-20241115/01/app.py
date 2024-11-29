# -*- coding: utf-8 -*-
"""
Created on Tue Nov  7 10:39:59 2023

@author: Alberto
"""

from flask import Flask, request, render_template

app = Flask(__name__)

@app.route("/", methods=["POST", "GET"])
def hola():
    user = ""
    password = ""
    if (request.method == "POST"):
        user = request.form.get("usuario")
        password = request.form.get("contrasena")
        print(user, password)
    return render_template("index.html", user=user, password=password)

@app.route("/login")
def baloncesto():
    return "Hola, esta es la web de baloncesto!"

@app.route("/pruebaPost", methods=["POST", "GET"])
def pruebaPost():
    if (request.method == "POST"):
        return "Esto es un POST"
    elif (request.method == "GET"):
        return "Estoy haciendo un get"
    return "Hola, esta es la web de baloncesto!"

app.run()

