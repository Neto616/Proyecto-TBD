document.addEventListener('DOMContentLoaded',()=>{
    const btnRegistrar = document.getElementById('integranteN');

    btnRegistrar.addEventListener('click', (e)=>{
        e.preventDefault();

        const data = {
            nombre: document.getElementById('nombreInte').value,
            apellido1: document.getElementById('apellido1I').value,
            apellido2: document.getElementById('apellido2I').value,
            fecha_nacimiento: document.getElementById('fechaNacio').value,
        }
        if(data.nombre.length > 0 && data.apellido1.length > 0 && data.apellido2.length > 0 && data.fecha_nacimiento.length > 0){
            fetch('/rt-integrante-nuevo', {
            method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data),
            } )
            .then((response) => response.json())
            .then((data) => {
                if(data.estatus === 'OK'){
                    Swal.fire({
                        title: "Proceso exitoso",
                        text: "Agregado con exito",
                        icon: "success"
                      }).then((result) => {
                        if (result.isConfirmed){
                            location.href = '/alunmo';
                        }
                    });
                }else{
                    Swal.fire({
                        title: 'Proceso no exitoso',
                        text: "Este integrante ya existe",
                        icon: "warning"
                    })
                }
            })
            .catch((error) =>{
                console.log('integrante Nuevo.js');
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