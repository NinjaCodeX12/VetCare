<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="appPF_InventarioVetCare.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8" />

    <title>Dashboard VetCare</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

</head>

<body>

    <form runat="server">

        <div class="container-fluid">

            <div class="row">

                <!-- SIDEBAR -->

                <div class="col-md-2 bg-primary text-white min-vh-100 p-3">

                    <h4 class="text-center mb-4">VetCare</h4>

                    <ul class="nav flex-column">

                        <li class="nav-item mb-2">
                            <a class="nav-link text-white" onclick="mostrarInicio()">
                                <i class="fa fa-home me-2"></i>Inicio
                    </a>
                        </li>

                        <li class="nav-item mb-2">
                            <a class="nav-link text-white" onclick="cargarPagina('Productos.aspx')">
                                <i class="fa fa-box me-2"></i>Productos
                    </a>
                        </li>

                        <li class="nav-item mb-2">
                            <a class="nav-link text-white" onclick="cargarPagina('Proveedores.aspx')">
                                <i class="fa fa-truck me-2"></i>Proveedores
                    </a>
                        </li>

                        <li class="nav-item mb-2">
                            <a class="nav-link text-white" onclick="cargarPagina('Clientes.aspx')">
                                <i class="fa fa-users me-2"></i>Clientes
                    </a>
                        </li>

                        <li class="nav-item mb-2">
                            <a class="nav-link text-white" onclick="cargarPagina('Entradas.aspx')">
                                <i class="fa fa-arrow-down me-2"></i>Entradas
                    </a>
                        </li>

                        <li class="nav-item mb-2">
                            <a class="nav-link text-white" onclick="cargarPagina('Salidas.aspx')">
                                <i class="fa fa-arrow-up me-2"></i>Salidas
                    </a>
                        </li>

                        <li class="nav-item mb-2">
                            <a class="nav-link text-white" onclick="cargarPagina('Reportes.aspx')">
                                <i class="fa fa-file me-2"></i>Reportes
                    </a>
                        </li>

                    </ul>

                </div>

                <!-- CONTENIDO -->

                <div class="col-md-10">

                    <!-- NAVBAR -->

                    <nav class="navbar navbar-light bg-light shadow-sm">

                        <div class="container-fluid">

                            <form class="d-flex">

                                <input class="form-control me-2" type="search" placeholder="Buscar" />

                                <button class="btn btn-primary">
                                    <i class="fa fa-search"></i>
                                </button>

                            </form>

                            <span class="navbar-text">
                                <i class="fa fa-bell me-3"></i>
                                <i class="fa fa-envelope me-3"></i>
                                Admin
                            </span>

                        </div>

                    </nav>

                    <!-- DASHBOARD -->

                    <div class="container mt-4" id="inicio">

                        <h3 class="mb-4">Dashboard Inventario VetCare</h3>

                        <div class="row g-4">

                            <div class="col-md-3">

                                <div class="card border-primary shadow-sm">

                                    <div class="card-body">

                                        <h6>Total Productos</h6>

                                        <h3>
                                            <asp:Label ID="lblProductos" runat="server" Text="120"></asp:Label>
                                        </h3>

                                    </div>

                                </div>

                            </div>

                            <div class="col-md-3">

                                <div class="card border-success shadow-sm">

                                    <div class="card-body">

                                        <h6>Stock Disponible</h6>

                                        <h3>85</h3>

                                    </div>

                                </div>

                            </div>

                            <div class="col-md-3">

                                <div class="card border-warning shadow-sm">

                                    <div class="card-body">

                                        <h6>Stock Bajo</h6>

                                        <h3>10</h3>

                                    </div>

                                </div>

                            </div>

                            <div class="col-md-3">

                                <div class="card border-danger shadow-sm">

                                    <div class="card-body">

                                        <h6>Movimientos Hoy</h6>

                                        <h3>25</h3>

                                    </div>

                                </div>

                            </div>

                        </div>

                        <!-- GRAFICOS -->

                        <div class="row mt-4">

                            <div class="col-md-8">

                                <div class="card shadow-sm">

                                    <div class="card-header">
                                        Movimientos de Inventario

                                    </div>

                                    <div class="card-body">

                                        <canvas id="graficoInventario"></canvas>

                                    </div>

                                </div>

                            </div>

                            <div class="col-md-4">

                                <div class="card shadow-sm">

                                    <div class="card-header">
                                        Categoría Productos

                                    </div>

                                    <div class="card-body">

                                        <canvas id="graficoCategorias"></canvas>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                    </div>

                </div>

            </div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>

        var ctx = document.getElementById('graficoInventario');

        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo'],
                datasets: [{
                    label: 'Movimientos',
                    data: [40, 55, 60, 45, 70]
                }]
            }
        });

        var ctx2 = document.getElementById('graficoCategorias');

        new Chart(ctx2, {
            type: 'doughnut',
            data: {
                labels: ['Medicamentos', 'Alimentos', 'Accesorios', 'Higiene'],
                datasets: [{
                    data: [35, 40, 15, 10]
                }]
            }
        });

    </script>

</body>
</html>
