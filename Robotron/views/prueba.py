import flet as ft
# from assets.login import iniciar_sesion

def main(page: ft.Page) -> None:
    page.title = "Login"
    
    #Titulo:
    c1 = ft.Container(
        content=ft.Text("Evento Robotica", style= ft.TextThemeStyle.DISPLAY_MEDIUM),
        padding=50  ,
    )

    #Medida de ventana
    page.window_width = 500        # window's width is 200 px
    page.window_height = 500       # window's height is 200 px
    page.window_resizable = False  # window is not resizable

    #Text Flied
    correo = ft.TextField(label="Correo", icon= ft.icons.ACCOUNT_CIRCLE, width= 400)
    contrasena = ft.TextField(label='Contraseña', password=True ,icon= ft.icons.PASSWORD, width=400)
    
    #Boton para iniciar sesion
    btnLogIn = ft.FilledTonalButton("Iniciar Sesión")

    #Actualizar la pagina
    page.vertical_alignment = ft.MainAxisAlignment.CENTER 
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER  
    page.add(c1, correo, contrasena, btnLogIn)
    page.update()


ft.app(target=main)