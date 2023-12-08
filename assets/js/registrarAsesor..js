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

document.addEventListener('DOMContentLoaded', () =>{
    const btnRegistro = document.getElementById('aseN');

    btnRegistro.addEventListener('click', (e) => {
        e.preventDefault();

        const data = {
            nombre: document.getElementById('nomAsesor').value,
            apellido1: document.getElementById('apellido1').value,
            apellido2: document.getElementById('apellido2').value,
            nivel_institucion: document.getElementById('lvlacademicoAsesor').value,
            correo: validarCorreo(document.getElementById('correoA').value),
            contraseña: document.getElementById('contraA').value,
        }
        console.log('front')
        if(data.nombre.length > 0 && data.apellido1.length > 0 && data.apellido2.length > 0 &&  data.nivel_institucion.length > 0 && data.correo.length > 0 && data.contraseña.length > 0){
           console.log('aca')
            fetch('/rt-alta-asesor', {
                method: 'POST',
                    headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data),
            } )
            .then((response) => response.json())
            .then((data) => {
                if (data.estatus === 'OK') {
                    Swal.fire({
                        position: "top-end",
                        icon: "success",
                        title: data.mensaje,
                        showConfirmButton: false,
                        timer: 1.5 * 1000
                    });
                } else {
                    Swal.fire({
                        position: "top-end",
                        icon: "warning",
                        title: data.mensaje,
                        showConfirmButton: false,
                        timer: 1.5 * 1000
                    })
                }
            })
            .catch((error) => {
                console.log('registrarA.js');
                console.log(error);
            })
        }else if(data.correo === 'Correo no valido'){
            Swal.fire({
                position: "top-end",
                icon: "warning",
                title: 'Correo no aceptado favor de verificar',
                showConfirmButton: false,
                timer: 1.5 * 1000
            });
        }else{
            Swal.fire({
                position: "top-end",
                icon: "warning",
                title: 'Favor de llenar todos los datos',
                showConfirmButton: false,
                timer: 1.5 * 1000
            });
        }

    })
})