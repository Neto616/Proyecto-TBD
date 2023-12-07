function validarCorreo(correo = '') {
    if(correo.length > 0){
        if(correo.match(/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)){
            return correo
        }else{
            return 'Correo no valido'
        }
    }else{
        return ''
    }
}

document.addEventListener('DOMContentLoaded', () =>{
    const btnInicio = document.getElementById('btnLogin')
    btnInicio.addEventListener('click', (e)=>{
        e.preventDefault();

        const data = {
            correo: validarCorreo(document.getElementById('usCorreo').value),
            contraseña: document.getElementById('usPass').value 
        }

    if(data.correo == "Correo no valido" || data.correo === "") {
        Swal.fire({
            position: "top-end",
            icon: "warning",
            title: 'Correo no valido',
            showConfirmButton: false,
            timer: 1.5 * 1000
        });
    }else{
        fetch('/rt-iniciar-sesion', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        })
        .then((response) => response.json())
        .then((data) =>{
            if(data.estatus ==='OK'){
                setTimeout(() => {
                    location.href = '/vista-principal'
                  }, 1.5 * 1000);
                Swal.fire({
                    position: "top-end",
                    icon: "success",
                    title: data.mensaje,
                    showConfirmButton: false,
                    timer: 1.5 * 1000
                });
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
}
    })
})