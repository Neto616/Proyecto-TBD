document.addEventListener('DOMContentLoaded',() => {
    
    const btnCalEqu = document.getElementById('cal-equ');
        btnCalEqu.addEventListener('click',(event)  =>{
            event.preventDefault(); 
            const criPro=document.getElementById('cri-pro').checked
            const criCon=document.getElementById('cri-con').checked
            const criDis=document.getElementById('cri-dis').checked          
            const data={
                criCon,criDis,
                criPro,
                codEqu:document.getElementById('cod-equ').value
            }
               fetch('/rt-calificar-equipo', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(data),
                } )
                .then((response) => response.json())
                .then((data) => {
                    if(data.estatus=='OK'){
                        Swal.fire({
                            icon:'success',
                            title:'Calificado',
                            text:`${data.message}`
                        }).then(()=>{
                            location.reload()
                        })
                     }else{
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: `${data.message}`
                          })
                     }
                } )
                .catch((error) =>{
                    console.log(error);
                } );
                   
            } );
    
        } );