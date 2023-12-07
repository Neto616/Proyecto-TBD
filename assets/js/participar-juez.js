document.addEventListener('DOMContentLoaded',() => {
    
    const btnEliPro = document.querySelectorAll('#par');
    btnEliPro.forEach(button => {
        
        button.addEventListener('click',async (event)  =>{
            event.preventDefault();           
            const id=event.target.getAttribute('data-nom')
                
    
               await fetch('/rt-participar-juez', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({id}),
                } )
                .then((response) => response.json())
                .then((data) => {
                    if(data.estatus=='OK'){
                        Swal.fire({
                            icon:'success',
                            title:'Juez',
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
    });
    