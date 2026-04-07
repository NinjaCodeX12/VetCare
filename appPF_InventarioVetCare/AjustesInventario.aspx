<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AjustesInventario.aspx.cs" Inherits="appPF_InventarioVetCare.AjustesInventario" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Ajuste de Inventario - VetCare</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <!-- DataTables -->
    <link href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" rel="stylesheet" />

    <style>
        body {
            background-color: #f8fafc;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        div.dataTables_filter {
            float: right;
            margin-bottom: 15px;
        }

        div.dataTables_length {
            float: left;
            margin-bottom: 15px;
        }

        .card {
            border-radius: 16px;
        }

        .badge-ajuste {
            padding: 6px 12px;
            border-radius: 12px;
            font-weight: 600;
        }

        .positivo {
            background: #dcfce7;
            color: #16a34a;
        }

        .negativo {
            background: #fee2e2;
            color: #dc2626;
        }
    </style>
</head>

<body>
    <form runat="server">

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <div class="container py-5">

                    <!-- HEADER -->
                    <div class="d-flex justify-content-between align-items-center mb-5">
                        <h2 class="fw-bold mb-0">Ajustes <span class="text-primary">Inventario</span></h2>
                        <div class="text-center">
                            <small class="text-muted d-block fw-bold">TOTAL AJUSTES</small>
                            <asp:Label ID="lblTotalAjustes" runat="server" Text="0" CssClass="fw-bold h4 mb-0 text-primary"></asp:Label>
                        </div>
                    </div>

                    <div class="row g-4">

                        <!-- FORMULARIO -->
                        <div class="col-lg-4">
                            <div class="card shadow-sm p-4">
                                <h5 class="fw-bold mb-4">Registro Rápido</h5>

                                <div class="mb-4">
                                    <label>Producto</label>
                                    <asp:DropDownList ID="ddlProducto" runat="server" CssClass="form-select"></asp:DropDownList>
                                </div>

                                <div class="mb-4">
                                    <label>Cantidad (+ / -)</label>
                                    <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" />
                                </div>

                                <div class="mb-4">
                                    <label>Motivo</label>
                                    <asp:TextBox ID="txtMotivo" runat="server" CssClass="form-control" />
                                </div>

                                <div class="d-grid gap-2">

                                    <!-- BOTÓN GUARDAR -->
                                    <asp:Button ID="btnAjustar" runat="server" Text="Guardar Ajuste"
                                        CssClass="btn btn-primary w-100"
                                        OnClick="btnAjustar_Click"
                                        UseSubmitBehavior="false" />

                                    <!-- BOTÓN LIMPIAR -->
                                    <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar"
                                        CssClass="btn btn-secondary w-100"
                                        OnClick="btnLimpiar_Click"
                                        UseSubmitBehavior="false" />

                                </div>

                            </div>
                        </div>

                        <!-- TABLA -->
                        <div class="col-lg-8">
                            <div class="card shadow-lg border-0 rounded-4">
                                <div class="card-body">

                                    <h5 class="fw-bold mb-4 text-primary">Historial de Ajustes</h5>

                                    <table id="tablaAjustes" class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Fecha</th>
                                                <th>Producto</th>
                                                <th>Cantidad</th>
                                                <th>Motivo</th>
                                                <th>Usuario</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="rpAjustes" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td><%# Eval("id_ajuste") %></td>
                                                        <td><%# Eval("fecha_ajuste") %></td>
                                                        <td>
                                                            <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill">
                                                                <%# Eval("producto") %>
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span class="badge-ajuste <%# Convert.ToInt32(Eval("cantidad_ajustada")) > 0 ? "positivo" : "negativo" %>">
                                                                <%# Eval("cantidad_ajustada") %>
                                                            </span>
                                                        </td>
                                                        <td><%# Eval("motivo") %></td>
                                                        <td><%# Eval("usuario") %></td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>

                    </div>

                </div>

            </ContentTemplate>
        </asp:UpdatePanel>

    </form>

    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        function cargarTabla() {
            $('#tablaAjustes').DataTable({
                destroy: true,
                language: {
                    url: "https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
                }
            });
        }

        $(document).ready(function () {
            cargarTabla();
        });

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            cargarTabla();
        });

        function mostrarMensaje(tipo, mensaje) {
            if (tipo === "success") Swal.fire("¡Éxito!", mensaje, "success");
            else if (tipo === "error") Swal.fire("Error", mensaje, "error");
            else if (tipo === "info") Swal.fire("Información", mensaje, "info");
        }
    </script>
</body>
</html>
