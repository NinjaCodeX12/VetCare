<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="appPF_InventarioVetCare.Usuarios" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>VetCare - Gestión de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f4f7f6;
            font-family: 'Segoe UI', sans-serif;
        }

        .glass-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .grid-view {
            border-radius: 10px;
            overflow: hidden;
            background: white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <div class="container py-5">
            <h2 class="fw-bold mb-4 text-primary"><i class="fas fa-user-shield me-2"></i>Gestión de Usuarios</h2>

            <asp:UpdatePanel ID="upUsuarios" runat="server">
                <ContentTemplate>
                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="glass-card">
                                <h5 class="fw-bold mb-3">Datos de Usuario</h5>
                                <asp:HiddenField ID="hfIdUsuario" runat="server" Value="0" />

                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">Asignar a Empleado</label>
                                    <asp:DropDownList ID="ddlEmpleado" runat="server" CssClass="form-select">
                                    </asp:DropDownList>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-muted">Nombre de Usuario (Login)</label>
                                    <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" placeholder="Ej. rgareca"></asp:TextBox>
                                </div>

                                <div class="mb-3" id="divPassword" runat="server">
                                    <label class="form-label small fw-bold text-muted">Contraseña</label>
                                    <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label small fw-bold text-muted">Rol de Acceso</label>
                                    <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select">
                                        <asp:ListItem Value="Admin">Administrador</asp:ListItem>
                                        <asp:ListItem Value="Veterinario">Veterinario</asp:ListItem>
                                        <asp:ListItem Value="Recepcionista">Recepcionista</asp:ListItem>
                                    </asp:DropDownList>
                                </div>

                                <div class="d-grid gap-2">
                                    <asp:Button ID="btnGuardar" runat="server" Text="Registrar Usuario" CssClass="btn btn-primary fw-bold" OnClick="btnGuardar_Click" />
                                    <asp:LinkButton ID="btnLimpiar" runat="server" CssClass="btn btn-link text-muted" OnClick="btnLimpiar_Click">Cancelar / Nuevo</asp:LinkButton>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-8">
                            <div class="glass-card grid-view">
                                <h5 class="fw-bold mb-3">Personal con Acceso</h5>
                                <div class="table-responsive">

                                    <div class="mb-3 d-flex gap-2">
                                        <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" placeholder="Buscar por nombre, usuario o ID..."></asp:TextBox>
                                        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-secondary" OnClick="btnBuscar_Click" />
                                    </div>
                                    <asp:GridView ID="gvUsuarios" runat="server" CssClass="table table-hover" AutoGenerateColumns="False"
                                        DataKeyNames="id_usuario,username,rol,id_empleado"
                                        OnSelectedIndexChanged="gvUsuarios_SelectedIndexChanged"
                                        OnRowDeleting="gvUsuarios_RowDeleting" GridLines="None">
                                        <Columns>
                                            <asp:BoundField DataField="id_usuario" HeaderText="ID" />
                                            <asp:BoundField DataField="nombre_completo" HeaderText="Empleado" />
                                            <asp:BoundField DataField="username" HeaderText="Usuario" />
                                            <asp:BoundField DataField="rol" HeaderText="Rol" />
                                            <asp:TemplateField HeaderText="Acciones">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnEdit" runat="server" CommandName="Select" CssClass="text-warning me-2"><i class="fas fa-edit"></i></asp:LinkButton>
                                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="text-danger" OnClientClick="return confirm('¿Eliminar acceso?');"><i class="fas fa-trash"></i></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
