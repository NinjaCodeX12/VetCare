<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Empleados.aspx.cs" Inherits="appPF_InventarioVetCare.Empleados" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestión Empleados</title>

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
                        <h2 class="fw-bold mb-0">Empleados <span class="text-primary">VetCare</span></h2>

                        <div class="text-center">
                            <small class="text-muted d-block fw-bold">TOTAL</small>
                            <asp:Label ID="lblTotalEmp" runat="server"
                                Text="0"
                                CssClass="fw-bold h4 mb-0 text-primary"></asp:Label>
                        </div>
                    </div>

                    <div class="row g-4">

                        <!-- FORM -->
                        <div class="col-lg-4">
                            <div class="card shadow-sm p-4">
                                <h5 class="fw-bold mb-4">Registro Rápido</h5>

                                <asp:HiddenField ID="hfId" runat="server" />

                                <div class="mb-4">
                                    <label>Nombre</label>
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
                                </div>

                                <div class="mb-4">
                                    <label>Apellido</label>
                                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" />
                                </div>

                                <div class="mb-4">
                                    <label>DNI</label>
                                    <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" />
                                </div>

                                <div class="mb-4">
                                    <label>Teléfono</label>
                                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" />
                                </div>

                                <div class="d-grid gap-2">

                                    <!-- BOTÓN GUARDAR -->
                                    <asp:Button ID="btnGuardar" runat="server"
                                        Text="Guardar"
                                        CssClass="btn btn-primary w-100"
                                        OnClick="btnGuardar_Click"
                                        UseSubmitBehavior="false" />

                                    <!-- BOTÓN LIMPIAR -->
                                    <asp:Button ID="btnLimpiar" runat="server"
                                        Text="Limpiar"
                                        class="btn btn-secondary w-100"
                                        OnClick="btnLimpiar_Click"
                                        UseSubmitBehavior="false" />

                                </div>
                            </div>
                        </div>

                        <!-- TABLA -->
                        <div class="col-lg-8">
                            <div class="card shadow-lg border-0 rounded-4">
                                <div class="card-body">

                                    <h5 class="fw-bold mb-4 text-primary">Lista de Empleados</h5>

                                    <table id="tablaEmpleados" class="table table-hover align-middle">

                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Empleado</th>
                                                <th>DNI</th>
                                                <th>Teléfono</th>
                                                <th class="text-center">Acciones</th>
                                            </tr>
                                        </thead>

                                        <tbody>
                                            <asp:Repeater ID="rpEmpleados" runat="server">
                                                <ItemTemplate>
                                                    <tr>

                                                        <td><%# Eval("id_empleado") %></td>

                                                        <td>
                                                            <span class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill">
                                                                <%# Eval("nombre") %> <%# Eval("apellido") %>
                                                            </span>
                                                        </td>

                                                        <td><%# Eval("dni") %></td>

                                                        <td><%# Eval("telefono") %></td>

                                                        <td class="text-center">

                                                            <button type="button"
                                                                class="btn btn-warning btn-sm me-2"
                                                                onclick="editarEmpleado(
                                                '<%# Eval("id_empleado") %>',
                                                '<%# Eval("nombre") %>',
                                                '<%# Eval("apellido") %>',
                                                '<%# Eval("dni") %>',
                                                '<%# Eval("telefono") %>')">
                                                                Editar
                                                            </button>

                                                            <button type="button"
                                                                class="btn btn-danger btn-sm"
                                                                onclick="confirmarEliminar(<%# Eval("id_empleado") %>)">
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
                <asp:Button ID="btnEliminarHidden" runat="server" Style="display: none;" OnClick="EliminarEmpleado" />
                <asp:HiddenField ID="hfEliminar" runat="server" />

            </ContentTemplate>
        </asp:UpdatePanel>

    </form>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>

        function cargarTabla() {
            $('#tablaEmpleados').DataTable({
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

        function mensajeGuardado() {
            Swal.fire("Éxito", "Empleado guardado correctamente", "success");
        }

        function mensajeEliminado() {
            Swal.fire("Eliminado", "Empleado eliminado", "success");
        }


        function mensajeError(msg) {
            Swal.fire("Error", msg, "error");
        }

        function confirmarEliminar(id) {
            Swal.fire({
                title: "¿Eliminar?",
                text: "¿Seguro que deseas eliminar este empleado?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí",
                cancelButtonText: "No"
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('<%= hfEliminar.ClientID %>').value = id;
                    document.getElementById('<%= btnEliminarHidden.ClientID %>').click();
                }
            });
        }

        function editarEmpleado(id, nombre, apellido, dni, telefono) {
            document.getElementById('<%= hfId.ClientID %>').value = id;
            document.getElementById('<%= txtNombre.ClientID %>').value = nombre;
            document.getElementById('<%= txtApellido.ClientID %>').value = apellido;
            document.getElementById('<%= txtDni.ClientID %>').value = dni;
            document.getElementById('<%= txtTelefono.ClientID %>').value = telefono;

            Swal.fire({ toast: true, position: 'top-end', icon: 'info', title: 'Modo edición activado', showConfirmButton: false, timer: 2000 });
        }

    </script>

</body>
</html>
