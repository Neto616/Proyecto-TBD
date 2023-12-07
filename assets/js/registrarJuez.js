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
    const btnRegistro = document.getElementById('btnRegistrar');

    btnRegistro.addEventListener('click', (e) => {
        e.preventDefault();

        const data = {
            nombre: document.getElementById('nombreJuez').value,
            apellidoP: document.getElementById('apePJuez').value,
            apellidoM: document.getElementById('apeMJuez').value,
            direccion: document.getElementById('direccionJuez').value,
            nivelAcademico: document.getElementById('lvlAcademicoJuez').value,
            institucionJuez: document.getElementById('institucionJuez').value,
            correoJuez: validarCorreo(document.getElementById('correoJuez').value),
            contrasena: document.getElementById('contrasenaJuez').value,
        }

        if(data.nombre.length > 0 && data.apellidoP.length > 0 && data.apellidoM.length > 0 && data.institucionJuez.length > 0 && data.nivelAcademico.length > 0 && data.direccion.length > 0 && data.correoJuez.length > 0 && data.contrasena.length > 0){
            fetch('/rt-alta-juez', {
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
                console.log('registrarJuez.js');
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