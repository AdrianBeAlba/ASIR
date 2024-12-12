import mysql.connector
#prueba 5dic
database = mysql.connector.connect(
    host='localhost',
    user='root',
    password='notSecureChangeMe',
    database='adrian'
)
