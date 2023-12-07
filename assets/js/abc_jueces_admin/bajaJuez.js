const btnBaja = document.querySelectorAll('#btnEliminar');

btnBaja.forEach(baja =>{
    baja.addEventListener('click', async(e) =>{
        const nombre_juez = e.target.getAttribute('data-id-nombre');
        const apellidop_Juez = e.target.getAttribute('data-id-apellidoP');
        const apellidom_juez = e.target.getAttribute('data-id-apellidoM');

        await fetch(`/rt-baja-juez/${nombre_juez}/${apellidop_Juez}/${apellidom_juez}`, {
            method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },  
        } )
        .then((response) => response.json())
        .then ((data) =>{
            if(data.estatus === 'OK'){
                Swal.fire({
                    title: data.mensaje,
                    confirmButtonText: "Ok"
                }).then((result) => {
                    if (result.isConfirmed){
                        location.href = "/jueces";
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
        .catch((error) =>{
            console.log('bajaJuez.js');
            console.log(error);
        })
    })
})