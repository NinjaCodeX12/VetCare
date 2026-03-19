<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="appPF_InventarioVetCare.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard VetCare</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="Recursos/CSS/Dashboard.css" rel="stylesheet" />
</head>

<body>

    <form id="form1" runat="server">

        <div class="container-fluid p-0">
            <div class="row g-0">

                <!-- SIDEBAR -->
                <div class="col-md-2 sidebar shadow">
                    <h4 class="text-center mb-4 d-flex align-items-center justify-content-center gap-2">VetCare</h4>

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

                    </ul>
                </div>

                <!-- CONTENIDO -->
                <div class="col-md-10 main-content">

                    <nav class="navbar navbar-expand-lg navbar-custom shadow-sm">
                        <div class="container-fluid">

                            <div class="d-flex w-100 align-items-center justify-content-end">

                                <div class="text-white d-flex align-items-center">

                                    <i class="fa fa-bell me-4"></i>
                                    <i class="fa fa-envelope me-4"></i>

                                    <div class="dropdown">
                                        <div class="d-flex align-items-center" data-bs-toggle="dropdown" style="cursor: pointer;">
                                            <span class="me-2">Admin</span>
                                            <i class="fa fa-user-circle fa-lg"></i>
                                        </div>

                                        <ul class="dropdown-menu dropdown-menu-end">
                                            <li>
                                                <a class="dropdown-item" href="#">
                                                    <i class="fa fa-user me-2"></i>Mi Perfil
                                                </a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item text-danger" href="#" onclick="event.preventDefault()" data-bs-toggle="modal" data-bs-target="#modalCerrarSesion">
                                                    <i class="fa fa-sign-out-alt me-2"></i>Cerrar sesión
                                                </a>
                                            </li>
                                        </ul>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </nav>

                    <!-- DASHBOARD -->
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
                                            <canvas id="graficoInventario"></canvas>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <div class="card shadow-sm">
                                        <div class="card-header bg-white fw-bold">Categoría Productos</div>
                                        <div class="card-body">
                                            <canvas id="graficoCategorias"></canvas>
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

    <!-- MODAL -->
    <div class="modal fade" id="modalCerrarSesion" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title">Confirmar cierre de sesión</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body text-center">
                    <p>¿Estás seguro de cerrar sesión?</p>

                    <div id="loadingCerrar" style="display: none;">
                        <div class="spinner-border text-primary mt-3"></div>
                        <p class="mt-2">Cerrando sesión...</p>
                    </div>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button class="btn btn-danger" onclick="cerrarSesion()">Sí, cerrar</button>
                </div>

            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="Recursos/JS/Dashboard.js"></script>

</body>
</html>
