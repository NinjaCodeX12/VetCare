<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Empleados.aspx.cs" Inherits="appPF_InventarioVetCare.Empleados" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestión Empleados</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet" />

    <style>
        body {
            background-color: #f8fafc;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        .glass-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 25px rgba(0,0,0,0.05);
            padding: 30px;
            border: 1px solid #edf2f7;
        }

        .btn-modern {
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
        }

        .custom-grid th {
            background: #f1f5f9 !important;
            font-size: 0.75rem;
            padding: 20px !important;
        }

        .custom-grid td {
            padding: 22px !important;
        }
    </style>
</head>

<body>
    <form runat="server">

        <div class="container py-5">

            <!-- HEADER -->
            <div class="d-flex justify-content-between align-items-center mb-5">
                <h2 class="fw-bold mb-0">Gestión <span class="text-primary">Empleados</span></h2>
            </div>

            <!-- ALERTA -->
            <asp:Panel ID="alerta" runat="server" Visible="false" CssClass="alert">
                <asp:Label ID="lblAlerta" runat="server"></asp:Label>
            </asp:Panel>

            <div class="row g-4">

                <!-- FORMULARIO -->
                <div class="col-lg-4">
                    <div class="glass-card">

                        <h5 class="fw-bold mb-4">Registro Rápido</h5>

                        <asp:HiddenField ID="hfId" runat="server" />

                        <div class="mb-4">
                            <label class="fw-bold">Nombre</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control form-control-lg" />
                        </div>

                        <div class="mb-4">
                            <label class="fw-bold">Apellido</label>
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control form-control-lg" />
                        </div>

                        <div class="mb-4">
                            <label class="fw-bold">DNI</label>
                            <asp:TextBox ID="txtDni" runat="server" CssClass="form-control form-control-lg" />
                        </div>

                        <div class="mb-4">
                            <label class="fw-bold">Teléfono</label>
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control form-control-lg" />
                        </div>

                        <div class="d-grid gap-2">
                            <asp:Button ID="btnGuardar" runat="server"
                                Text="Guardar Cambios"
                                CssClass="btn btn-modern btn-primary"
                                OnClick="btnGuardar_Click" />

                            <asp:LinkButton ID="btnLimpiar" runat="server"
                                CssClass="btn btn-link text-muted"
                                OnClick="btnLimpiar_Click">
                        Limpiar campos
                            </asp:LinkButton>
                        </div>

                    </div>
                </div>

                <!-- TABLA -->
                <div class="col-lg-8">
                    <div class="glass-card">
                        <h5 class="fw-bold mb-4 text-secondary">Lista de Empleados</h5>

                        <asp:GridView ID="gvEmpleados" runat="server"
                            CssClass="table custom-grid"
                            AutoGenerateColumns="False"
                            OnSelectedIndexChanged="gvEmpleados_SelectedIndexChanged"
                            OnRowDeleting="gvEmpleados_RowDeleting"
                            DataKeyNames="id_empleado,nombre,apellido,dni,telefono">

                            <Columns>

                                <asp:BoundField DataField="id_empleado" HeaderText="ID" />

                                <asp:TemplateField HeaderText="Empleado">
                                    <ItemTemplate>
                                        <div class="fw-bold">
                                            <%# Eval("nombre") %> <%# Eval("apellido") %>
                                        </div>
                                        <small class="text-muted">DNI: <%# Eval("dni") %></small>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="telefono" HeaderText="Teléfono" />

                                <asp:TemplateField HeaderText="Acciones">
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" CommandName="Select"
                                            CssClass="btn btn-sm btn-light text-warning me-2">
                                    <i class="fas fa-edit"></i>
                                        </asp:LinkButton>

                                        <asp:LinkButton runat="server" CommandName="Delete"
                                            CssClass="btn btn-sm btn-light text-danger"
                                            OnClientClick="return confirm('¿Eliminar?');">
                                    <i class="fas fa-trash"></i>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

            </div>

        </div>

    </form>
</body>
</html>
