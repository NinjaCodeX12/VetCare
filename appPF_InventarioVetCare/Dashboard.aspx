<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="appPF_InventarioVetCare.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard VetCare</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>
        body, html {
            height: 100%;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            background-color: #f4f6f9;
        }

        .sidebar {
            background: #0a1f44;
            min-height: 100vh;
            padding-top: 20px;
        }

            .sidebar h4 {
                color: white;
                font-weight: bold;
                padding: 10px 20px;
            }

            .sidebar .nav-link {
                color: rgba(255,255,255,0.8);
                padding: 12px 20px;
                transition: 0.3s;
                font-size: 15px;
            }

                .sidebar .nav-link:hover {
                    background: #133a7c;
                    color: white;
                }

        /* TITULOS DEL MENU */
        .menu-title {
            color: rgba(255,255,255,0.5);
            font-size: 12px;
            padding: 10px 20px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .navbar-custom {
            background: #0a1f44;
            padding: 10px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .busqueda {
            width: 400px;
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            color: white;
        }

            .busqueda::placeholder {
                color: rgba(255,255,255,0.5);
            }

            .busqueda:focus {
                background: rgba(255,255,255,0.2);
                color: white;
                box-shadow: none;
                border-color: white;
            }

        .btn-buscar {
            color: white;
            border: 1px solid rgba(255,255,255,0.2);
            margin-left: -5px;
        }

        .main-content {
            padding: 0;
        }

        .dashboard-container {
            padding: 30px;
        }

        .card {
            border: none;
            border-radius: 10px;
        }

        #frameContenido {
            width: 100%;
            height: calc(100vh - 120px);
            border: none;
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">

        <div class="container-fluid p-0">
            <div class="row g-0">

                <!-- SIDEBAR -->
                <div class="col-md-2 sidebar shadow">

                    <h4 class="text-center mb-4">VetCare</h4>

                    <ul class="nav flex-column">

                        <li class="menu-title">GENERAL</li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="mostrarInicio()">
                                <i class="fa fa-home me-2"></i>Inicio
                            </a>
                        </li>

                        <li class="menu-title">GESTIÓN</li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="cargarPagina('Productos.aspx')">
                                <i class="fa fa-box me-2"></i>Productos
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="cargarPagina('Categorias.aspx')">
                                <i class="fa fa-tags me-2"></i>Categorías
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="cargarPagina('Proveedores.aspx')">
                                <i class="fa fa-truck me-2"></i>Proveedores
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="cargarPagina('Clientes.aspx')">
                                <i class="fa fa-users me-2"></i>Clientes
                            </a>
                        </li>

                        <li class="menu-title">INVENTARIO</li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="cargarPagina('Movimientos.aspx')">
                                <i class="fa fa-exchange-alt me-2"></i>Movimientos
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="cargarPagina('AjustesInventario.aspx')">
                                <i class="fa fa-clipboard-list me-2"></i>Ajustes
                            </a>
                        </li>

                        <li class="menu-title">ADMIN</li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="cargarPagina('Empleados.aspx')">
                                <i class="fa fa-user-tie me-2"></i>Empleados
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="cargarPagina('Usuarios.aspx')">
                                <i class="fa fa-user-cog me-2"></i>Usuarios
                            </a>
                        </li>

                        <li class="nav-item mt-3">
                            <a class="nav-link text-danger" href="Login.aspx">
                                <i class="fa fa-sign-out-alt me-2"></i>Cerrar Sesión
                            </a>
                        </li>

                    </ul>

                </div>

                <!-- CONTENIDO -->
                <div class="col-md-10 main-content">

                    <nav class="navbar navbar-expand-lg navbar-custom shadow-sm">
                        <div class="container-fluid">

                            <div class="d-flex w-100 align-items-center justify-content-between">

                                <div class="d-flex">
                                    <input class="form-control me-2 busqueda" type="search" placeholder="Buscar productos..." />
                                    <button class="btn btn-buscar" type="button">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>

                                <div class="text-white d-flex align-items-center">
                                    <i class="fa fa-bell me-4"></i>
                                    <i class="fa fa-envelope me-4"></i>

                                    <div class="d-flex align-items-center">
                                        <span class="me-2">Admin</span>
                                        <i class="fa fa-user-circle fa-lg"></i>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </nav>

                    <div class="dashboard-container" id="inicio">

                        <div id="panelInicio">

                            <h3 class="mb-4">Dashboard Inventario VetCare</h3>

                            <div class="row g-4">

                                <div class="col-md-3">
                                    <div class="card border-start border-4 border-primary shadow-sm h-100">
                                        <div class="card-body">
                                            <h6 class="text-muted">Total Productos</h6>
                                            <h2 class="fw-bold">
                                                <asp:Label ID="lblProductos" runat="server" Text="120"></asp:Label>
                                            </h2>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card border-start border-4 border-success shadow-sm h-100">
                                        <div class="card-body">
                                            <h6 class="text-muted">Stock Disponible</h6>
                                            <h2 class="fw-bold text-success">85</h2>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card border-start border-4 border-warning shadow-sm h-100">
                                        <div class="card-body">
                                            <h6 class="text-muted">Stock Bajo</h6>
                                            <h2 class="fw-bold text-warning">10</h2>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card border-start border-4 border-danger shadow-sm h-100">
                                        <div class="card-body">
                                            <h6 class="text-muted">Movimientos Hoy</h6>
                                            <h2 class="fw-bold text-danger">25</h2>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="row mt-5">

                                <div class="col-md-8">
                                    <div class="card shadow-sm">
                                        <div class="card-header bg-white fw-bold">Movimientos de Inventario</div>
                                        <div class="card-body">
                                            <canvas id="graficoInventario" style="max-height: 300px;"></canvas>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="card shadow-sm">
                                        <div class="card-header bg-white fw-bold">Categoría Productos</div>
                                        <div class="card-body">
                                            <canvas id="graficoCategorias" style="max-height: 300px;"></canvas>
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>

                        <iframe id="frameContenido" style="display: none;"></iframe>

                    </div>

                </div>
            </div>
        </div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>

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

        // Grafico Linea
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

        // Grafico Dona
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

    </script>

</body>
</html>
