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
            nombreA: document.getElementById('nomAsesor').value,
            apellido1A: document.getElementById('apellido1').value,
            apellido2A: document.getElementById('apellido2').value,
            nivelIns: document.getElementById('lvlacademicoAsesor').value,
            correoA: validarCorreo(document.getElementById('correoA').value),
            contrasenaA: document.getElementById('contraA').value,
        }

        if(data.nombreA.length > 0 && data.apellido1A.length > 0 && data.apellido2A.length > 0 &&  data.nivelIns.length > 0 && data.correoA.length > 0 && data.contrasenaA.length > 0){
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
                        title: "Exito",
                        showConfirmButton: false,
                        timer: 1.5 * 1000
                    });
                } else {
                    Swal.fire({
                        position: "top-end",
                        icon: "warning",
                        title: "Ya existe ese asesor",
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