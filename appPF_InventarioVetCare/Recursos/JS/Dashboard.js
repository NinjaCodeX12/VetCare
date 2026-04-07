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
