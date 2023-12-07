const btnBaja = document.querySelectorAll('#btnEliminar');

btnBaja.forEach(baja => {
    baja.addEventListener('click', async(e) => {
        const nombre_instituto = e.target.getAttribute('data-id-nombre');
        const nivel_instituto  = e.target.getAttribute('data-id-nivelEscolar');

        await fetch(`/rt-baja-instituto/${nombre_instituto}/${nivel_instituto}`, {
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
                        location.href = "/escuela";
                    }
                })
            }else{
                Swal.fire({
                    position: "top-end",
                    icon: "warning",
                    title: estatus.mensaje,
                    showConfirmButton: false,
                    timer: 1.5 * 1000
                })
            }
        })
        .catch((error) => {
            console.log('bajaInstitutos.js')
            console.log(error)
        })
    })
})