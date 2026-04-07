<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="appPF_InventarioVetCare.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
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
                <div class="col-md-2 sidebar">
                    <h4 class="text-center text-white">VetCare</h4>

                    <ul class="nav flex-column">

                        <li class="menu-title">GENERAL</li>
                        <li><a class="nav-link" href="#" onclick="mostrarInicio()"><i class="fa fa-home me-2"></i>Inicio</a></li>

                        <li class="menu-title">GESTIÓN</li>
                        <li><a class="nav-link" onclick="cargarPagina('Productos.aspx')"><i class="fa fa-box me-2"></i>Productos</a></li>
                        <li><a class="nav-link" onclick="cargarPagina('Categorias.aspx')"><i class="fa fa-tags me-2"></i>Categorías</a></li>
                        <li><a class="nav-link" onclick="cargarPagina('Proveedores.aspx')"><i class="fa fa-truck me-2"></i>Proveedores</a></li>
                        <li><a class="nav-link" onclick="cargarPagina('Clientes.aspx')"><i class="fa fa-users me-2"></i>Clientes</a></li>

                        <li class="menu-title">INVENTARIO</li>
                        <li><a class="nav-link" onclick="cargarPagina('Movimientos.aspx')"><i class="fa fa-exchange-alt me-2"></i>Movimientos</a></li>
                        <li><a class="nav-link" onclick="cargarPagina('AjustesInventario.aspx')"><i class="fa fa-clipboard-list me-2"></i>Ajustes</a></li>

                        <li class="menu-title">ADMIN</li>
                        <li><a class="nav-link" onclick="cargarPagina('Empleados.aspx')"><i class="fa fa-user-tie me-2"></i>Empleados</a></li>
                        <li><a class="nav-link" onclick="cargarPagina('Usuarios.aspx')"><i class="fa fa-user-cog me-2"></i>Usuarios</a></li>
                        <li><a class="nav-link" onclick="cargarPagina('Reportes.aspx')"><i class="fa fa-chart-line me-2"></i>Reportes</a></li>

                    </ul>
                </div>

                <!-- CONTENIDO -->
                <div class="col-md-10">

                    <nav class="navbar navbar-dark navbar-custom">
                        <div class="ms-auto text-white">
                            Admin <i class="fa fa-user-circle"></i>
                        </div>
                    </nav>

                    <div class="dashboard-container">

                        <div id="panelInicio">

                            <h3 class="mb-1">Dashboard</h3>
                            <p class="text-muted">Resumen general del inventario</p>

                            <!-- CARDS -->
                            <div class="row g-4 mt-2">

                                <div class="col-md-3">
                                    <div class="card shadow-sm p-3">
                                        <div class="d-flex justify-content-between">
                                            <i class="fa fa-box fa-2x text-primary"></i>
                                            <span class="text-success">+12%</span>
                                        </div>
                                        <h6 class="mt-3 text-muted">Total Productos</h6>
                                        <h3>
                                            <asp:Label ID="lblProductos" runat="server" /></h3>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card shadow-sm p-3">
                                        <div class="d-flex justify-content-between">
                                            <i class="fa fa-database fa-2x text-success"></i>
                                        </div>
                                        <h6 class="mt-3 text-muted">Stock Total</h6>
                                        <h3>
                                            <asp:Label ID="lblStockDisponible" runat="server" /></h3>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card shadow-sm p-3">
                                        <div class="d-flex justify-content-between">
                                            <i class="fa fa-exclamation fa-2x text-warning"></i>
                                        </div>
                                        <h6 class="mt-3 text-muted">Stock Bajo</h6>
                                        <h3>
                                            <asp:Label ID="lblStockBajo" runat="server" /></h3>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="card shadow-sm p-3">
                                        <div class="d-flex justify-content-between">
                                            <i class="fa fa-exchange-alt fa-2x text-danger"></i>
                                        </div>
                                        <h6 class="mt-3 text-muted">Movimientos Hoy</h6>
                                        <h3>
                                            <asp:Label ID="lblMovimientosHoy" runat="server" /></h3>
                                    </div>
                                </div>

                            </div>

                            <!-- TABLAS -->
                            <div class="row mt-4">

                                <!-- MOVIMIENTOS -->
                                <div class="col-md-7">
                                    <div class="card shadow-sm">
                                        <div class="card-header fw-bold">Movimientos Recientes</div>
                                        <div class="card-body">
                                            <asp:Repeater ID="rpMovimientos" runat="server">
                                                <ItemTemplate>
                                                    <div class="d-flex justify-content-between mb-3">
                                                        <div>
                                                            <strong><%# Eval("producto") %></strong><br />
                                                            <small class="text-muted"><%# Eval("usuario") %></small>
                                                        </div>
                                                        <span><%# Eval("cantidad") %></span>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </div>

                                <!-- STOCK BAJO -->
                                <div class="col-md-5">
                                    <div class="card shadow-sm">
                                        <div class="card-header fw-bold text-danger">⚠ Stock Bajo</div>
                                        <div class="card-body">
                                            <asp:Repeater ID="rpStockBajo" runat="server">
                                                <ItemTemplate>
                                                    <div class="mb-3">
                                                        <strong><%# Eval("nombre") %></strong>
                                                        <div class="progress">
                                                            <div class="progress-bar bg-danger" style='width: <%# Eval("porcentaje") %>%'></div>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
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
    <script src="Recursos/JS/Dashboard.js"></script>
</body>
</html>
