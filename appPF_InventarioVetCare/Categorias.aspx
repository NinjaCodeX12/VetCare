<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="appPF_InventarioVetCare.Categorias" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>VetCare Pro - Categorías</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
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
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <!-- IMPORTANTE -->
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <div class="container py-5">

                    <div class="d-flex justify-content-between align-items-center mb-5">
                        <h2 class="fw-bold mb-0">Categorías <span class="text-primary">VetCare</span></h2>

                        <div class="text-center">
                            <small class="text-muted d-block fw-bold">TOTAL</small>
                            <asp:Label ID="lblTotalCat" runat="server"
                                Text="0"
                                CssClass="fw-bold h4 mb-0 text-primary"></asp:Label>
                        </div>
                    </div>

                    <div class="row g-4">

                        <!-- FORM -->
                        <div class="col-lg-4">
                            <div class="card shadow-sm p-4">
                                <h5 class="fw-bold mb-4">Registro Rápido</h5>

                                <div class="mb-4">
                                    <label class="form-label">Nombre Categoría</label>
                                    <asp:TextBox ID="txtNombreCat" runat="server"
                                        CssClass="form-control"
                                        placeholder="Ej. Medicinas"></asp:TextBox>
                                </div>

                                <asp:Button ID="btnGuardarCat" runat="server"
                                    Text="Guardar"
                                    CssClass="btn btn-primary w-100"
                                    OnClick="btnGuardarCat_Click"
                                    UseSubmitBehavior="false" />
                            </div>
                        </div>

                        <!-- TABLA -->
                        <div class="col-lg-8">
                            <div class="card shadow-lg border-0 rounded-4">
                                <div class="card-body">

                                    <h5 class="fw-bold mb-4 text-primary">Lista de Categorías</h5>

                                    <table id="tablaCategorias" class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Categoría</th>
                                                <th class="text-center">Acciones</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <asp:Repeater ID="rpCategorias" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td><%# Eval("id_categoria") %></td>

                                                        <td>
                                                            <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill">
                                                                <%# Eval("nombre") %>
                                                            </span>
                                                        </td>

                                                        <td class="text-center">
                                                            <button type="button"
                                                                class="btn btn-outline-danger btn-sm"
                                                                onclick="confirmarEliminar(<%# Eval("id_categoria") %>)">
                                                                Eliminar
                                                            </button>
                                                        </td>
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

                <asp:Button ID="btnEliminarHidden" runat="server" Style="display: none;" OnClick="EliminarCategoria" />
                <asp:HiddenField ID="hfIdEliminar" runat="server" />

            </ContentTemplate>
        </asp:UpdatePanel>

    </form>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>

        function cargarTabla() {
            $('#tablaCategorias').DataTable({
                destroy: true,
                language: {
                    url: "https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json"
                }
            });
        }

        $(document).ready(function () {
            cargarTabla();
        });

        // REINICIAR DATATABLE DESPUÉS DEL UPDATEPANEL
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            cargarTabla();
        });

        function mensajeGuardado() {
            Swal.fire("Éxito", "Categoría registrada correctamente", "success");
        }

        function mensajeEliminado() {
            Swal.fire("Eliminado", "La categoría fue eliminada", "success");
        }

        function confirmarEliminar(id) {
            Swal.fire({
                title: "¿Eliminar?",
                text: "¿Estas Seguro de Eliminar esta Categoria?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí",
                cancelButtonText: "No"
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('<%= hfIdEliminar.ClientID %>').value = id;
                    document.getElementById('<%= btnEliminarHidden.ClientID %>').click();
                }
            });
        }

    </script>

</body>
</html>
