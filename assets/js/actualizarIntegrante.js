document.addEventListener('DOMContentLoaded', () => {
    const btnActualizar = document.getElementById('btnActualizar');

    btnActualizar.addEventListener('click', (e) => {
        e.preventDefault();

        const data = {
            nombreAntiguo: document.getElementById('nombreAntiguo').value,
            nombre: document.getElementById('nombreIn').value,
            apellido1: document.getElementById('apellido1').value,
            apellido2: document.getElementById('apellido2').value,
        };

        if (data.nombre.length > 0 && data.apellido1.length > 0 && data.apellido2.length > 0) {
            fetch('/rt-modificar-integrante', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data),
            })
            .then((response) => response.json())
            .then((data) => {
                if (data.estatus === 'OK') {
                    Swal.fire({
                        title: data.mensaje,
                        confirmButtonText: "Ok"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            location.href = "/alunmo";
                        }
                    });
                } else {
                    Swal.fire({
                        position: "top-end",
                        icon: "warning",
                        title: data.mensaje,
                        showConfirmButton: false,
                        timer: 2000
                    });
                }
            })
            .catch((error) => {
                console.log('actualizarIntegrante.js');
                console.log(error);
            });
        } else {
          
        }
    });
});
