<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="appPF_InventarioVetCare.Reportes" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reportes VetCare</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- DataTable -->
    <link href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" rel="stylesheet" />
</head>

<body>
<form id="form1" runat="server">

<div class="container mt-4">

    <h3 class="mb-4">📊 Reportes VetCare</h3>

    <!-- 🔥 HIDDENFIELDS -->
    <asp:HiddenField ID="hfNombres" runat="server" />
    <asp:HiddenField ID="hfStock" runat="server" />
    <asp:HiddenField ID="hfCategorias" runat="server" />
    <asp:HiddenField ID="hfCantidades" runat="server" />

    <!-- BOTONES -->
    <div class="mb-3">
        <button type="button" class="btn btn-danger" onclick="exportarPDF()">Exportar PDF</button>
        <button type="button" class="btn btn-success" onclick="exportarExcel()">Exportar Excel</button>
    </div>

    <!-- TABLA -->
    <table id="tablaReportes" class="display">
        <thead>
            <tr>
                <th>Producto</th>
                <th>Stock</th>
                <th>Categoría</th>
            </tr>
        </thead>
        <tbody>
            <asp:Repeater ID="rpReporte" runat="server">
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("nombre") %></td>
                        <td><%# Eval("stock_actual") %></td>
                        <td><%# Eval("categoria") %></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </tbody>
    </table>

    <!-- GRAFICOS -->
    <div class="row mt-5">

        <div class="col-md-6">
            <h5 class="text-center">📦 Stock por Producto</h5>
            <canvas id="grafico1"></canvas>
        </div>

        <div class="col-md-6">
            <h5 class="text-center">📊 Productos por Categoría</h5>
            <canvas id="grafico2"></canvas>
        </div>

    </div>

    <div class="row mt-4">
        <div class="col-md-12">
            <h5 class="text-center">📈 Tendencia de Stock</h5>
            <canvas id="grafico3"></canvas>
        </div>
    </div>

</div>

</form>

<!-- LIBRERIAS -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- EXPORTAR -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

<script>

    // 🔥 DATATABLE EN ESPAÑOL
    $(document).ready(function () {
        $('#tablaReportes').DataTable({
            language: {
                url: "https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
            }
        });
    });

    // 🔥 DATOS DESDE ASP.NET
    var nombres = JSON.parse(document.getElementById('<%= hfNombres.ClientID %>').value || "[]");
    var stock = JSON.parse(document.getElementById('<%= hfStock.ClientID %>').value || "[]");
    var categorias = JSON.parse(document.getElementById('<%= hfCategorias.ClientID %>').value || "[]");
    var cantidadesCat = JSON.parse(document.getElementById('<%= hfCantidades.ClientID %>').value || "[]");

    // 🔹 GRAFICO 1 (BARRAS)
    new Chart(document.getElementById('grafico1'), {
        type: 'bar',
        data: {
            labels: nombres,
            datasets: [{
                label: 'Stock de productos',
                data: stock
            }]
        }
    });

    // 🔹 GRAFICO 2 (PIE)
    new Chart(document.getElementById('grafico2'), {
        type: 'pie',
        data: {
            labels: categorias,
            datasets: [{
                label: 'Cantidad por categoría',
                data: cantidadesCat
            }]
        }
    });

    // 🔹 GRAFICO 3 (LINEA)
    new Chart(document.getElementById('grafico3'), {
        type: 'line',
        data: {
            labels: nombres,
            datasets: [{
                label: 'Evolución del stock',
                data: stock
            }]
        }
    });

    // 🔥 EXPORTAR PDF
    function exportarPDF() {
        const { jsPDF } = window.jspdf;
        var doc = new jsPDF();

        doc.text("Reporte VetCare", 10, 10);

        var filas = document.querySelectorAll("#tablaReportes tbody tr");
        var y = 20;

        filas.forEach(f => {
            var c = f.querySelectorAll("td");
            doc.text(c[0].innerText + " | " + c[1].innerText + " | " + c[2].innerText, 10, y);
            y += 8;
        });

        doc.save("Reporte.pdf");
    }

    // 🔥 EXPORTAR EXCEL
    function exportarExcel() {
        var tabla = document.getElementById("tablaReportes");
        var wb = XLSX.utils.table_to_book(tabla, { sheet: "Reporte" });
        XLSX.writeFile(wb, "Reporte.xlsx");
    }

</script>

</body>
</html>