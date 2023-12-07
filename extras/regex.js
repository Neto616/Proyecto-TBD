function validarCorreo(correo = '') {
  if(correo.length > 0){
      if(correo.match(/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)){
          return correo
      }else{
          return 'Correo no valido'
      }
  }else{
      return ''
  }
}

function validarNum(input) {
    // Remover cualquier carácter no numérico o negativo
    input.value = input.value.replace(/[^0-9 ]/g, '');

    // Verificar si el número es positivo
    const numero = parseFloat(input.value);
 
}

function validarNumDec(input) {
    // Remover cualquier carácter no numérico o negativo
    input.value = input.value.replace(/[^0-9 .]/g, '');

    // Verificar si el número es positivo
    const numero = parseFloat(input.value);
 
}

function validarLet(input) {
    // Remover cualquier carácter no numérico o negativo
    input.value = input.value.replace(/[^aA-zZ ]/g, '');

    // Verificar si el número es positivo
    const numero = parseFloat(input.value);
 
}

function validarqe(input){
    // Solo permite numeros y letras  
    input.value = input.value.replace(/[^a-zA-Z0-9]/g, '');

    const numero = parseFloat(input.value);
}

// Variable para rastrear el estado del botón
var botonDesactivado = false;

function desactivarBoton() {
  // Obtén el botón
  var boton = document.getElementById("miBoton");

  // Verifica si el botón está desactivado
  if (!botonDesactivado) {
    // Desactiva el botón
    boton.disabled = true;
    
    // Marca el botón como desactivado
    botonDesactivado = true;

    // Después de 30 sg minuto (30000 milisegundos), vuelve a activar el botón
    setTimeout(function() {
      // Verifica nuevamente que el botón esté desactivado
      if (botonDesactivado) {
        boton.disabled = false;
        
        // Marca el botón como activado
        botonDesactivado = false;
      }
    }, 30000);
  }
}

function validarqe(input){
    input.value = input.value.replace(/[^a-zA-Z0-9]/g, '');
}


// function validarqe(input){
//     input.value = input.value.replace(/^[a-zA-Z0-9]/g, '');
// }