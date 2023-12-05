# def llenarDatos(nombre, apellido):
#    nombre = nombre
#    apellido = apellido

#    return [nombre, apellido]

# nombreCompleto = llenarDatos('Nestor Ivan', 'Balderas Soto')

# hola = {
#    'nombres': nombreCompleto[0],
#    'apellidos': nombreCompleto[1]
#    }

# for n in hola.values():
#    print(n, end=' ') if len(hola) > 1 else print(n)

import sys

from views.login_robotron_ui import Ui_MainWindow
from PyQt5.QtWidgets import *

class MainWin(QMainWindow):

    def __init__(self):
        QMainWindow.__init__(self)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        self.show()

if __name__ == "__main__":
    print("Iniciando proyecto")
    app = QApplication(sys.argv)
    window = MainWin()
    sys.exit(app.exec_())