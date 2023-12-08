const btnBaja = document.querySelectorAll('#btnBorrar');

btnBaja.forEach(baja => {
    baja.addEventListener('click', async(e) => {
        const nombre = e.target.getAttribute('data-id-nombre');
        const apellidoPat = e.target.getAttribute('data-id-apellidoPat'); 
        const apellidoMat = e.target.getAttribute('data-id-apellidoMat');

        await fetch(`/rt-baja-alumno/${nombre}/${apellidoPat}/${apellidoMat}`, {
            method:'POST',
                headers: {
                    'Content-Type': 'application/json',                    
                },
        })
        .then((response) => response.json())
        .then((data) => {
            if(data.estatus === 'OK'){
                Swal.fire({
                    title: data.mensaje,
                    confirmButtonText: "Ok"
                }).then((result) => {
                    if (result.isConfirmed){
                        location.href = "/alunmo";
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
            console.log('bajaIntegrante.js');
            console.log(error)
        })
    })   
})