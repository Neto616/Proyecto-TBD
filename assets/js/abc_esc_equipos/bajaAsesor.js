btnBaja = document.querySelectorAll('#btnEliminar');

btnBaja.forEach(baja => {
    baja.addEventListener('click', async(e) => {
        const id = e.target.getAttribute('data-id-asesor');

        await fetch (`/rt-baja-asesor/${id}`, {
            method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
        } )
        .then((response) => response.json())
        .then((data) =>{
            if(data.estatus === 'OK'){
                Swal.fire({
                    title: data.mensaje,
                    confirmButtonText: "Ok"
                }).then((result) => {
                    if (result.isConfirmed){
                        location.href = "/asesor";
                    }
                })
            }else{
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
            console.log('bajaAsesor.js');
            console.log(error);
        })
    })
})