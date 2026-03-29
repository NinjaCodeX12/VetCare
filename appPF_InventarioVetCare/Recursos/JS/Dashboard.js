// Función para cargar una página dentro del iframe
function cargarPagina(pagina) {
    // Oculta el panel de inicio
    document.getElementById("panelInicio").style.display = "none";
    // Obtiene el iframe donde se cargará el contenido
    var frame = document.getElementById("frameContenido");
    // Muestra el iframe
    frame.style.display = "block";
    // Asigna la página que se quiere cargar
    frame.src = pagina;
}

// Función para mostrar nuevamente el inicio
function mostrarInicio() {
    // Muestra el panel de inicio
    document.getElementById("panelInicio").style.display = "block";
    // Obtiene el iframe
    var frame = document.getElementById("frameContenido");
    // Oculta el iframe
    frame.style.display = "none";
}

// 🔥 Función para cerrar sesión con animación de carga
function cerrarSesion() {
    // Muestra el loader (pantalla de carga)
    document.getElementById("loadingCerrar").style.display = "block";
    // Espera 2 segundos antes de redirigir
    setTimeout(function () {
        // Redirige al login
        window.location.href = "Login.aspx";
    }, 2000);
}

// Gráfico de líneas para mostrar movimientos de inventario
new Chart(document.getElementById('graficoInventario'), {
    type: 'line', // Tipo de gráfico: línea
    data: {
        labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo'], // Meses
        datasets: [{
            label: 'Movimientos', // Nombre del dataset
            data: [40, 55, 60, 45, 70], // Datos del gráfico
            borderColor: '#0a1f44', // Color de la línea
            tension: 0.3, // Suavizado de la línea
            fill: true, // Relleno debajo de la línea
            backgroundColor: 'rgba(10,31,68,0.1)' // Color del relleno
        }]
    }
});

// Gráfico tipo dona para categorías de productos
new Chart(document.getElementById('graficoCategorias'), {
    type: 'doughnut', // Tipo de gráfico: dona
    data: {
        labels: ['Medicamentos', 'Alimentos', 'Accesorios', 'Higiene'], // Categorías
        datasets: [{
            data: [35, 40, 15, 10], // Valores de cada categoría
            backgroundColor: ['#0d6efd', '#198754', '#ffc107', '#dc3545'] // Colores de cada sección
        }]
    }
});