function validarCorreo(correo = '') {
    if(correo.length > 0){
        if(correo.match(/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)){
            return correo
        }else{
            return 'Correo no valido'
        }
    }else{
        return ''
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const btnContra = document.getElementById('btnOlvidarContrasena');

    btnContra.addEventListener('click', (e) =>{
        e.preventDefault();

        console.log("Olvidar contrasena click");

        const data = {
            correo: validarCorreo(document.getElementById('usCorreo').value)
        };
        console.log(data.correo)
        fetch('/rt-olvidar-contrasena', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        } )
        .then((response) => response.json())
        .then((data) =>{
            if(data.estatus === "OK"){
                Swal.fire({
                    title: "Su contraseña es: ",
                    html: data.contraUsuario,
                    confirmButtonText: "Siguiente"
                }).then((result) => {
                    if (result.isConfirmed){
                        location.href = "/iniciar";
                    }
                })
            }else{
                window.alert('No jala')
            }
        })
        .catch((error) => {
            console.log('olvidarContrasena.js');
            console.log(error)
        })
    })
})