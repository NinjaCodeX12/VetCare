<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="appPF_InventarioVetCare.Clientes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid mt-4">
            <div class="row">
                <div class="col-md-4">
                    <div class="card shadow-sm p-4">
                        <h4 class="mb-4">Registro de Cliente</h4>
                        <asp:HiddenField ID="hfIdCliente" runat="server" Value="0" />

                        <div class="mb-3">
                            <label class="form-label small fw-bold">DNI / RUC</label>
                            <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" placeholder="Documento de identidad"></asp:TextBox>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold">Nombre Completo</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Nombre del propietario"></asp:TextBox>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label small fw-bold">Teléfono</label>
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="999..."></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label small fw-bold">Email</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="correo@ejemplo.com"></asp:TextBox>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold">Dirección</label>
                            <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                        </div>

                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cliente"
                            CssClass="btn btn-primary w-100 shadow-sm" OnClick="btnGuardar_Click" />

                        <div class="text-center mt-3">
                            <asp:LinkButton ID="btnLimpiar" runat="server" CssClass="text-muted small" OnClick="btnLimpiar_Click">Limpiar campos</asp:LinkButton>
                        </div>
                    </div>
                </div>

                <div class="col-md-8">
                    <div class="card shadow-sm p-4">
                        <h4 class="mb-4">Lista Maestra de Clientes</h4>
                        <asp:GridView ID="gvClientes" runat="server" CssClass="table table-hover border-0"
                            AutoGenerateColumns="False" DataKeyNames="id_cliente,dni_ruc,nombre_completo,telefono,email,direccion"
                            OnSelectedIndexChanged="gvClientes_SelectedIndexChanged" OnRowDeleting="gvClientes_RowDeleting">
                            <Columns>
                                <asp:BoundField DataField="dni_ruc" HeaderText="DNI/RUC" />
                                <asp:BoundField DataField="nombre_completo" HeaderText="CLIENTE" />
                                <asp:BoundField DataField="telefono" HeaderText="TELÉFONO" />

                                <asp:TemplateField HeaderText="ACCIONES">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Select" CssClass="text-warning me-2"><i class="bi bi-pencil-square"></i> Editar</asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete"
                                            OnClientClick="return confirm('¿Eliminar cliente?');" CssClass="text-danger"><i class="bi bi-trash"></i>Eliminar</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="table-light text-secondary small fw-bold" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
