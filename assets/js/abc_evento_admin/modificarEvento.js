document.addEventListener('DOMContentLoaded', () =>{
    const btnActualizar = document.getElementById('actualizar');

    btnActualizar.addEventListener('click', (e) => {
        e.preventDefault();

        const data = {
            nombreActual: document.getElementById('nombreEvActual').value,
            nombre: document.getElementById('nombreEv').value,
            sede: document.getElementById('sede').value
        }

        if (data.nombreActual.length > 0 && data.nombre.length > 0 && data.sede.length > 0) {
            fetch('/rt-actualizar-eventos',{
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                }, body: JSON.stringify(data),
            })
            .then((response) => response.json())
            .then((data) => {
                if(data.estatus === 'OK'){
                    Swal.fire({
                        title: data.mensaje,
                        confirmButtonText: "Ok"
                    }).then((result) => {
                        if (result.isConfirmed){
                            location.href = "/eventos";
                        }
                    })
            }else{
                Swal.fire({
                    position: "top-end",
                    icon: "warning",
                    title: data.mensaje,
                    showConfirmButton: false,
                    timer: 2 * 1000
                })
            }
            })
            .catch((error) => {
                console.log('modificarEvento.js');
                console.log(error);
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