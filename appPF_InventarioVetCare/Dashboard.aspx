<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="appPF_InventarioVetCare.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>

<title>Dashboard VetCare</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>

<style>

.sidebar{
background:#1f2d3d;
height:100vh;
color:white;
padding-top:20px;
}

.sidebar a{
display:block;
color:white;
padding:12px;
text-decoration:none;
font-size:16px;
}

.sidebar a:hover{
background:#0d6efd;
}

</style>

</head>

<body>

<form id="form1" runat="server">

<div class="container-fluid">
<div class="row">

<!-- MENU LATERAL -->

<div class="col-md-2 sidebar">

<h4 class="text-center">VetCare</h4>

<hr/>

<a href="Dashboard.aspx">
<i class="fa fa-home"></i> Inicio
</a>

<a href="Login.aspx" target="contenido">
<i class="fa fa-box"></i> Productos
</a>

<a href="Proveedores.aspx" target="contenido">
<i class="fa fa-truck"></i> Proveedores
</a>

<a href="Clientes.aspx" target="contenido">
<i class="fa fa-users"></i> Clientes
</a>

<a href="Entradas.aspx" target="contenido">
<i class="fa fa-arrow-down"></i> Entradas
</a>

<a href="Salidas.aspx" target="contenido">
<i class="fa fa-arrow-up"></i> Salidas
</a>

<a href="Reportes.aspx" target="contenido">
<i class="fa fa-file"></i> Reportes
</a>

</div>

<!-- CONTENIDO PRINCIPAL -->

<div class="col-md-10 p-4">

<h2 class="mb-4">Dashboard Inventario VetCare</h2>

<!-- TARJETAS -->

<div class="row g-4">

<div class="col-md-3">
<div class="card shadow border-primary">
<div class="card-body">
<h6>Total Productos</h6>
<h3>
<asp:Label ID="lblProductos" runat="server" Text="120"></asp:Label>
</h3>
</div>
</div>
</div>

<div class="col-md-3">
<div class="card shadow border-success">
<div class="card-body">
<h6>Stock Disponible</h6>
<h3>85</h3>
</div>
</div>
</div>

<div class="col-md-3">
<div class="card shadow border-warning">
<div class="card-body">
<h6>Stock Bajo</h6>
<h3>10</h3>
</div>
</div>
</div>

<div class="col-md-3">
<div class="card shadow border-danger">
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

<div class="card shadow">

<div class="card-header">
Movimientos de Inventario
</div>

<div class="card-body">
<canvas id="graficoInventario"></canvas>
</div>

</div>

</div>

<div class="col-md-4">

<div class="card shadow">

<div class="card-header">
Categoría Productos
</div>

<div class="card-body">
<canvas id="graficoCategorias"></canvas>
</div>

</div>

</div>

</div>

<!-- TABLA -->

<div class="row mt-4">

<div class="col-md-12">

<div class="card shadow">

<div class="card-header">
Últimos Movimientos
</div>

<div class="card-body">

<asp:GridView
ID="gvMovimientos"
runat="server"
CssClass="table table-striped"
AutoGenerateColumns="true">
</asp:GridView>

</div>

</div>

</div>

</div>

<!-- AREA DONDE CARGAN LAS PAGINAS -->

<div class="row mt-4">

<div class="col-md-12">

<div class="card shadow">

<div class="card-header bg-dark text-white">
Área de Trabajo
</div>

<div class="card-body">

<iframe name="contenido"
src="Login.aspx"
style="width:100%; height:700px; border:none;">
</iframe>

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
                data: [40, 55, 60, 45, 70],
                borderWidth: 3
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
