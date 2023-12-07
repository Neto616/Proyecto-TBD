document.addEventListener('DOMContentLoaded', () => {
    const botonesEliminar = document.querySelectorAll('.delete-btn btnEliminar');

    botonesEliminar.forEach(boton => {
        boton.addEventListener('click', async (e) => {
            const nombre = e.target.getAttribute('data-id-nombre');
            const apellido1 = e.target.getAttribute('data-id-apellido1');
            const apellido2 = e.target.getAttribute('data-id-apellido2');
            const fecha_nacimiento = e.target.getAttribute('data-id-fecha_nacimiento');

            try {
                const response = await fetch(`/rt-baja-integrante/${nombre}/${apellido1}/${apellido2}/${fecha_nacimiento}`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                });

                const data = await response.json();
                if (data.estatus === 'OK') {
                    Swal.fire({
                        title: data.mensaje,
                        confirmButtonText: "Ok"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            location.reload(); 
                        }
                    })
                } else {
                    Swal.fire({
                        position: "top-end",
                        icon: "warning",
                        title: data.mensaje,
                        showConfirmButton: false,
                        timer: 1500
                    });
                }
            } catch (error) {
                console.error('Error en la solicitud:', error);
            }
        });
    });
});
