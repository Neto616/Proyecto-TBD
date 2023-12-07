const btnBaja = document.querySelectorAll('#btnBorrar');

btnBaja.forEach(baja => {
    baja.addEventListener('click', async(e) => {
        const nombre_sede = e.target.getAttribute('data-id-sede');

        await fetch(`/rt-baja-sede/${nombre_sede}`, {
            method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
        } )
        .then((response) => response.json())
        .then((data) => {
            if(data.estatus === 'OK'){
                Swal.fire({
                    title: data.mensaje,
                    confirmButtonText: "Ok"
                }).then((result) => {
                    if (result.isConfirmed){
                        location.href = "/sedes";
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
            console.log(error);
        })
    })
});