function cargarPagina(pagina) {
    document.getElementById("panelInicio").style.display = "none";
    var frame = document.getElementById("frameContenido");
    frame.style.display = "block";
    frame.src = pagina;
}

function mostrarInicio() {
    document.getElementById("panelInicio").style.display = "block";
    var frame = document.getElementById("frameContenido");
    frame.style.display = "none";
}

// 🔥 NUEVO
function cerrarSesion() {
    document.getElementById("loadingCerrar").style.display = "block";

    setTimeout(function () {
        window.location.href = "Login.aspx";
    }, 2000);
}

new Chart(document.getElementById('graficoInventario'), {
    type: 'line',
    data: {
        labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo'],
        datasets: [{
            label: 'Movimientos',
            data: [40, 55, 60, 45, 70],
            borderColor: '#0a1f44',
            tension: 0.3,
            fill: true,
            backgroundColor: 'rgba(10,31,68,0.1)'
        }]
    }
});

new Chart(document.getElementById('graficoCategorias'), {
    type: 'doughnut',
    data: {
        labels: ['Medicamentos', 'Alimentos', 'Accesorios', 'Higiene'],
        datasets: [{
            data: [35, 40, 15, 10],
            backgroundColor: ['#0d6efd', '#198754', '#ffc107', '#dc3545']
        }]
    }
});