<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="appPF_InventarioVetCare.Clientes" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Gestión de Clientes</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet" />

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
    </style>
</head>
<body>
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="container py-5">
                    <div class="d-flex justify-content-between align-items-center mb-5">
                        <h2 class="fw-bold mb-0">Clientes <span class="text-primary">VetCare</span></h2>
                        <div class="text-center">
                            <small class="text-muted d-block fw-bold">TOTAL</small>
                            <asp:Label ID="lblTotalClientes" runat="server" Text="0" CssClass="fw-bold h4 mb-0 text-primary"></asp:Label>
                        </div>
                    </div>

                    <div class="row g-4">
                        <!-- FORMULARIO -->
                        <div class="col-lg-4">
                            <div class="card shadow-sm p-4">
                                <h5 class="fw-bold mb-4">Registro de Cliente</h5>
                                <asp:HiddenField ID="hfIdCliente" runat="server" Value="0" />

                                <div class="mb-3">
                                    <label>DNI / RUC</label>
                                    <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" placeholder="Documento de identidad"></asp:TextBox>
                                </div>

                                <div class="mb-3">
                                    <label>Nombre Completo</label>
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Nombre del propietario"></asp:TextBox>
                                </div>

                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label>Teléfono</label>
                                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="999..."></asp:TextBox>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label>Email</label>
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="correo@ejemplo.com"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label>Dirección</label>
                                    <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                                </div>

                                <div class="d-grid gap-2">
                                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cliente" CssClass="btn btn-primary w-100" OnClick="btnGuardar_Click" UseSubmitBehavior="false" />
                                    <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn btn-secondary w-100" OnClick="btnLimpiar_Click" UseSubmitBehavior="false" />
                                </div>
                            </div>
                        </div>

                        <!-- TABLA -->
                        <div class="col-lg-8">
                            <div class="card shadow-lg border-0 rounded-4">
                                <div class="card-body">
                                    <h5 class="fw-bold mb-4 text-primary">Lista de Clientes</h5>
                                    <table id="tablaClientes" class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>DNI / RUC</th>
                                                <th>Cliente</th>
                                                <th>Teléfono</th>
                                                <th>Email</th>
                                                <th>Dirección</th>
                                                <th class="text-center">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="rpClientes" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td><%# Eval("dni_ruc") %></td>
                                                        <td><span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill"><%# Eval("nombre_completo") %></span></td>
                                                        <td><%# Eval("telefono") %></td>
                                                        <td><%# Eval("email") %></td>
                                                        <td><%# Eval("direccion") %></td>
                                                        <td class="text-center">
                                                            <button type="button" class="btn btn-warning btn-sm me-2"
                                                                onclick="editarCliente('<%# Eval("id_cliente") %>', '<%# Eval("dni_ruc") %>', '<%# Eval("nombre_completo") %>', '<%# Eval("telefono") %>', '<%# Eval("email") %>', '<%# Eval("direccion") %>')">
                                                                Editar</button>

                                                            <button type="button" class="btn btn-danger btn-sm"
                                                                onclick="confirmarEliminar('<%# Eval("id_cliente") %>')">
                                                                Eliminar</button>
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

                <asp:HiddenField ID="hfEliminarCliente" runat="server" />
                <asp:Button ID="btnEliminarHidden" runat="server" Style="display: none;" OnClick="EliminarCliente" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        function cargarTabla() {
            $('#tablaClientes').DataTable({
                destroy: true,
                language: { url: "https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json" }
            });
        }

        $(document).ready(function () { cargarTabla(); });

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () { cargarTabla(); });

        function mostrarMensaje(tipo, mensaje) {
            Swal.fire({ icon: tipo, title: mensaje, timer: 2000, toast: true, position: 'top-end', showConfirmButton: false });
        }

        function confirmarEliminar(id) {
            Swal.fire({
                title: "¿Eliminar?",
                text: "¿Seguro que deseas eliminar este cliente?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí",
                cancelButtonText: "No"
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('<%= hfEliminarCliente.ClientID %>').value = id;
                    document.getElementById('<%= btnEliminarHidden.ClientID %>').click();
                }
            });
        }

        function editarCliente(id, dni, nombre, telefono, email, direccion) {
            document.getElementById('<%= hfIdCliente.ClientID %>').value = id;
            document.getElementById('<%= txtDni.ClientID %>').value = dni;
            document.getElementById('<%= txtNombre.ClientID %>').value = nombre;
            document.getElementById('<%= txtTelefono.ClientID %>').value = telefono;
            document.getElementById('<%= txtEmail.ClientID %>').value = email;
            document.getElementById('<%= txtDireccion.ClientID %>').value = direccion;

            document.getElementById('<%= btnGuardar.ClientID %>').className = "btn btn-warning w-100";
            document.getElementById('<%= btnGuardar.ClientID %>').value = "Actualizar Cliente";

            Swal.fire({ toast: true, position: 'top-end', icon: 'info', title: 'Modo edición activado', showConfirmButton: false, timer: 2000 });
        }
    </script>
</body>
</html>
