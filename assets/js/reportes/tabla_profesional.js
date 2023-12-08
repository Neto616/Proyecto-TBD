document.getElementById("descargarBtn").addEventListener("click", exportarTabla);

function exportarTabla() {
    const tabla = document.getElementById("tablaProfesional");
    const tablaHTML = tabla.outerHTML;
    const blob = new Blob([tablaHTML], { type: 'application/vnd.ms-excel' });
    const a = document.createElement("a");
    a.href = URL.createObjectURL(blob);
    a.download = "Equipos-Profesional.xls"; // Nombre del archivo Excel
    a.style.display = "none";
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}