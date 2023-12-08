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
      input.value = input.value.replace(/[^a-zA-Z0-9 ]/g, '');
  
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
  
  function exportTableToExcel(tableID, filename) {
    // Tipo de exportación
    if (!filename) filename = 'excel_data.xls';
    let dataType = 'application/vnd.ms-excel';
  
    // Origen de los datos
    let tableSelect = document.getElementById(toString(tableID));
    let tableHTML = tableSelect.outerHTML;
     
    // Crea el archivo descargable
    let blob = new Blob([tableHTML], {type: dataType});
    
    // Crea un enlace de descarga en el navegador
    if (window.navigator && window.navigator.msSaveOrOpenBlob) { // Descargar para IExplorer
      window.navigator.msSaveOrOpenBlob(blob, filename);
    } else { // Descargar para Chrome, Firefox, etc.
      let a = document.createElement("a");
      document.body.appendChild(a);
      a.style = "display: none";
      let csvUrl = URL.createObjectURL(blob);
      a.href = csvUrl;
      a.download = filename;
      a.click();
      URL.revokeObjectURL(a.href)
      a.remove();
    }
  }