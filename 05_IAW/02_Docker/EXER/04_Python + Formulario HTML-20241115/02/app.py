# -*- coding: utf-8 -*-
"""
Created on Tue Nov  7 10:39:59 2023

@author: EL Jonkler
"""

from flask import Flask, request, render_template

app = Flask(__name__)

@app.route("/", methods=["POST", "GET"])
def hola():
    peso = ""
    altura = ""
    if (request.method == "POST"):
        peso = float(request.form.get("peso"))
        altura = float(request.form.get("altura"))
        imc=(peso/(altura*altura))
        if(imc<=25):
            IMC="Normal"
        elif(imc>=25 and imc<=29):
            IMC="Sobrepeso"
        elif(imc>=29):
            IMC="Gordo"
    return render_template("index.html",IMC=IMC,imc=imc)



app.run()

