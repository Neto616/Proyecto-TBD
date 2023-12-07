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

document.addEventListener('DOMContentLoaded',()=>{
    const btnRegistrar = document.getElementById('registroEscuela');

    btnRegistrar.addEventListener('click', (e)=>{
        e.preventDefault();

        const data = {
            instituto: document.getElementById('nombreInstituto').value,
            nivelAcademico: document.getElementById('niAcademico').value,
            direccion: document.getElementById('direccionInstituto').value,
            correo: validarCorreo(document.getElementById('correoInstituto').value),
            contraseña: document.getElementById('contrasenaInstituto').value
        }
        if(data.instituto.length > 0 && data.nivelAcademico.length > 0 && data.direccion.length > 0 && data.correo.length > 0 && data.contraseña.length > 0){
            fetch('/rt-alta-escuela', {
            method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data),
            } )
            .then((response) => response.json())
            .then((data) => {
                if(data.estatus === 'OK'){
                    Swal.fire({
                        title: "Proceso exitoso",
                        text: data.mensaje,
                        icon: "success"
                      }).then((result) => {
                        if (result.isConfirmed){
                            window.history.back();
                        }
                    });
                }else{
                    Swal.fire({
                        title: 'Proceso no exitoso',
                        text: data.mensaje,
                        icon: "warning"
                    })
                }
            })
            .catch((error) =>{
                console.log('registrarEscuela.js');
                console.log(error);
            })   
        }else if(data.correo === 'Correo no valido'){
            Swal.fire({
                position: "top-end",
                icon: "warning",
                title: 'Correo no aceptado favor de verificar',
                showConfirmButton: false,
                timer: 1.5 * 1000
            })
        }else{
            Swal.fire({
                position: "top-end",
                icon: "warning",
                title: 'Favor de llenar todos los datos',
                showConfirmButton: false,
                timer: 1.5 * 1000
            })
        }
    })
})