document.addEventListener('DOMContentLoaded', () =>{
    const btnSede = document.getElementById('btnGuardar');

    btnSede.addEventListener('click', (e) => {
        e.preventDefault();

        const data = {
            nombreSede: document.getElementById('nombreSede').value,
            direccion: document.getElementById('direccion').value
        }

        if(data.nombreSede.length > 0 && data.direccion.length > 0){
            fetch('/rt-alta-sede', {
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
                        title: "Proceso correcto: ",
                        html: data.mensaje,
                        confirmButtonText: "Siguiente"
                    }).then((result) => {
                        if (result.isConfirmed){
                            location.href = "/sedes";
                        }
                    })
                } else {
                    Swal.fire({
                        position: "top-end",
                        icon: "warning",
                        title: 'Favor de llenar todos los datos',
                        showConfirmButton: false,
                        timer: 1.5 * 1000
                    })
                }
            })
            .catch((error) => {
                console.log('agregarSede.js');
                console.log(error)
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