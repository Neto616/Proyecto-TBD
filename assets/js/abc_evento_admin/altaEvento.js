function fechaHora (fecha = ''){
    nuevaFecha = '';
    for(let i=0; i<fecha.length; i++){
        if (fecha[i] != 'T') nuevaFecha = nuevaFecha.concat(fecha[i]);
        else nuevaFecha = nuevaFecha.concat(' ');
    }
    return nuevaFecha;
}

document.addEventListener('DOMContentLoaded', () => {
    const altaEvento = document.getElementById('altaEv');

    altaEvento.addEventListener('click', (e) => {
        e.preventDefault();

        const data = {
            nombreEvento: document.getElementById('nombreEv').value,
            nombreSede: document.getElementById('nombreSede').value,
            direccionSede: document.getElementById('direccionSede').value,
            fechaInicio: fechaHora(document.getElementById('fechaIEvento').value),
            fechaFin: fechaHora(document.getElementById('fechaFEvento').value)
        }

        console.log('Fecha inicio: ',data.fechaInicio,'\n', 'Fecha fin: ', data.fechaFin)
        if(data.nombreEvento.length > 0 && data.nombreSede.length > 0 && data.direccionSede.length > 0 && data.fechaInicio.length > 0 && data.fechaFin.length > 0){
            fetch('rt-alta-evento', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data),
            } )
            .then((response) => response.json())
            .then((data) =>{
                if(data.estatus === 'OK'){
                    Swal.fire({
                        title: data.mensaje,
                        confirmButtonText: "Ok"
                    }).then((result) => {
                        if (result.isConfirmed){
                            location.href = "/eventos";
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
                console.log('altaEvento.js');
                console.log(error)
            })
        }else{
            Swal.fire({
                position: "top-end",
                icon: "warning",
                title: 'Favor de llenar todos los datos',
                showConfirmButton: false,
                timer: 1.5 * 1000
            });
        }
    })
})