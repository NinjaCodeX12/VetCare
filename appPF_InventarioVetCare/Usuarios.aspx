<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="appPF_InventarioVetCare.Usuarios" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestión Usuarios - VetCare</title>

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

        .card {
            border-radius: 16px;
        }

        .badge-rol {
            padding: 0.5rem 1rem;
            border-radius: 50px;
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
                        <h2 class="fw-bold mb-0">Usuarios <span class="text-primary">VetCare</span></h2>
                        <div class="text-center">
                            <small class="text-muted d-block fw-bold">ACTIVOS</small>
                            <asp:Label ID="lblTotalUsuarios" runat="server"
                                Text="0"
                                CssClass="fw-bold h4 mb-0 text-primary"></asp:Label>
                        </div>
                    </div>

                    <div class="row g-4">

                        <!-- FORMULARIO -->
                        <div class="col-lg-4">
                            <div class="card shadow-sm p-4">
                                <h5 class="fw-bold mb-4">Registro Rápido</h5>

                                <asp:HiddenField ID="hfIdUsuario" runat="server" />

                                <div class="mb-4">
                                    <label>Empleado</label>
                                    <asp:DropDownList ID="ddlEmpleado" runat="server" CssClass="form-select"></asp:DropDownList>
                                </div>

                                <div class="mb-4">
                                    <label>Usuario</label>
                                    <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" placeholder="ej. jdoe" />
                                </div>

                                <div class="mb-4" id="divPassword" runat="server">
                                    <label>Contraseña</label>
                                    <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" TextMode="Password" />
                                </div>

                                <div class="mb-4">
                                    <label>Rol</label>
                                    <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select">
                                        <asp:ListItem Value="Admin">Administrador</asp:ListItem>
                                        <asp:ListItem Value="Veterinario">Veterinario</asp:ListItem>
                                        <asp:ListItem Value="Recepcionista">Recepcionista</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="d-grid gap-2">
                                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary w-100" OnClick="btnGuardar_Click" UseSubmitBehavior="false" />
                                    <asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" CssClass="btn btn-secondary w-100" OnClick="btnLimpiar_Click" UseSubmitBehavior="false" />
                                </div>
                            </div>
                        </div>

                        <!-- TABLA -->
                        <div class="col-lg-8">
                            <div class="card shadow-lg border-0 rounded-4">
                                <div class="card-body">

                                    <h5 class="fw-bold mb-4 text-primary">Lista de Usuarios</h5>

                                    <table id="tablaUsuarios" class="table table-hover align-middle">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Empleado</th>
                                                <th>Usuario</th>
                                                <th>Rol</th>
                                                <th class="text-center">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="rpUsuarios" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill">
                                                                <%# Eval("nombre_completo") %>
                                                            </span>
                                                            <small class="text-muted d-block">ID: <%# Eval("id_usuario") %></small>
                                                        </td>
                                                        <td><%# Eval("username") %></td>
                                                        <td>
                                                            <span class="badge bg-info-subtle text-info px-3 py-2 rounded-pill">
                                                                <%# Eval("rol") %>
                                                            </span>
                                                        </td>
                                                        <td class="text-center">
                                                            <button type="button" class="btn btn-warning btn-sm me-2"
                                                                onclick="editarUsuario('<%# Eval("id_usuario") %>', '<%# Eval("id_empleado") %>', '<%# Eval("username") %>', '<%# Eval("rol") %>')">
                                                                Editar
                                                            </button>
                                                            <button type="button" class="btn btn-danger btn-sm"
                                                                onclick="confirmarEliminar(<%# Eval("id_usuario") %>)">
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

                <!-- ELIMINAR -->
                <asp:Button ID="btnEliminarHidden" runat="server" Style="display: none;" OnClick="btnEliminar_Click" />
                <asp:HiddenField ID="hfEliminar" runat="server" />

            </ContentTemplate>
        </asp:UpdatePanel>

    </form>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        function cargarTabla() {
            $('#tablaUsuarios').DataTable({
                destroy: true,
                language: { url: "https://cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json" }
            });
        }

        $(document).ready(function () { cargarTabla(); });

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            cargarTabla();
        });

        function mensajeGuardado() { Swal.fire("¡Buen trabajo!", "El usuario ha sido registrado/actualizado.", "success"); }
        function mensajeEliminado() { Swal.fire("Eliminado", "La cuenta ha sido removida.", "success"); }
        function mensajeError(msg) { Swal.fire("Error", msg, "error"); }

        function confirmarEliminar(id) {
            Swal.fire({
                title: "¿Eliminar cuenta?",
                text: "El usuario perderá acceso al sistema.",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí, eliminar",
                cancelButtonText: "Cancelar"
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('<%= hfEliminar.ClientID %>').value = id;
                    document.getElementById('<%= btnEliminarHidden.ClientID %>').click();
                }
            });
        }

        function editarUsuario(id, idEmp, user, rol) {
            document.getElementById('<%= hfIdUsuario.ClientID %>').value = id;
            document.getElementById('<%= ddlEmpleado.ClientID %>').value = idEmp;
            document.getElementById('<%= txtUser.ClientID %>').value = user;
            document.getElementById('<%= ddlRol.ClientID %>').value = rol;

            document.getElementById('<%= divPassword.ClientID %>').style.display = 'none';

            Swal.fire({ toast: true, position: 'top-end', icon: 'info', title: 'Modo edición activado', showConfirmButton: false, timer: 2000 });
        }
    </script>
</body>
</html>
