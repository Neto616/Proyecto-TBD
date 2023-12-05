import mysql.connector
from mysql.connector import Error

try:
    conexion = mysql.connector.connect(
        host = 'localhost',
        port = 3306,
        user = 'root',
        password = 'halo031003',
        db = 'evaluacionPrototipos'
    )

    if conexion.is_connected():
        print('Se conecto :)')
    
except Error as ex:
    print('Error en la conexion: ', ex)

