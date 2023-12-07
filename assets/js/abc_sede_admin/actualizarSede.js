document.addEventListener('DOMContentLoaded', ()=> {
    btnModificar = document.getElementById('btnActualizar');

    btnModificar.addEventListener('click', (e) => {
        e.preventDefault();

        const data = {
            nombreAntiguo: document.getElementById('nombreAntiguo').value,
            nombre: document.getElementById('nombreSede').value,
            direccion: document.getElementById('direccionSede').value
        }

        if (data.nombre.length > 0 && data.direccion.length > 0 ) {
            fetch('/rt-modificar-sede',{
                method: 'POST',
                headers:{
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data),
            })
            .then((response) => response.json())
            .then((data) =>{
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
                        title: data.mensaje,
                        showConfirmButton: false,
                        timer: 2 * 1000
                    })
                }})
            .catch((error) => {
                console.log('actualizarSede.js');
                console.log(error);
            })
        } else {
            
        }
    })

})