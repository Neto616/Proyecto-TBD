const btnBaja = document.querySelectorAll('#btnEliminar');

btnBaja.forEach(baja => {
    baja.addEventListener('click', async(e) => {
        const nombre_evento = e.target.getAttribute('data-id-nombre');

        await fetch (`/rt-baja-evento/${nombre_evento}`, {
            method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
        })
        .then((response) => response.json())
        .then((data) =>{
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
            console.log('eliminarEvento.js');
            console.log(error);
        })
    })
})