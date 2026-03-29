<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="appPF_InventarioVetCare.Productos" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>VetCare Pro - Gestión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet" />
    <link href="Recursos/CSS/Productos.css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="container py-5">
            <div class="d-flex justify-content-between align-items-center mb-5">
                <h2 class="fw-bold mb-0">Inventario <span class="text-primary">VetCare</span></h2>
                <div class="glass-card d-flex gap-5 py-3 px-4 shadow-sm">
                    <div class="text-center">
                        <small class="text-muted d-block fw-bold">PRODUCTOS</small>
                        <asp:Label ID="lblTotal" runat="server" Text="0" CssClass="fw-bold h4 mb-0 text-primary"></asp:Label>
                    </div>
                    <div class="vr"></div>
                    <div class="text-center">
                        <small class="text-muted d-block fw-bold">CRÍTICO</small>
                        <asp:Label ID="lblCritico" runat="server" Text="0" CssClass="fw-bold h4 mb-0 text-danger"></asp:Label>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="glass-card">
                        <h5 class="fw-bold mb-4">Registro Rápido</h5>
                        <asp:HiddenField ID="hfIdProducto" runat="server" Value="0" />
                        <div class="mb-4">
                            <label class="form-label small fw-bold">Nombre del Producto</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control form-control-lg" placeholder="Ej. Antipulgas"></asp:TextBox>
                        </div>
                        <div class="mb-4">
                            <label class="form-label small fw-bold">Categoría</label>
                            <!-- Quitamos los ListItems manuales, se llenarán desde el CodeBehind -->
                            <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select form-select-lg">
                            </asp:DropDownList>
                        </div>
                        <div class="row mb-4">
                            <div class="col-6">
                                <label class="form-label small fw-bold">Precio (S/)</label>
                                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control form-control-lg" placeholder="0.00"></asp:TextBox>
                            </div>
                            <div class="col-6">
                                <label class="form-label small fw-bold">Stock</label>
                                <asp:TextBox ID="txtStock" runat="server" CssClass="form-control form-control-lg" placeholder="Cant."></asp:TextBox>
                            </div>
                        </div>
                        <div class="d-grid gap-2">
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn btn-modern btn-primary shadow-sm" OnClick="btnGuardar_Click" />
                            <asp:LinkButton ID="btnLimpiar" runat="server" CssClass="btn btn-link text-decoration-none text-muted" OnClick="btnLimpiar_Click">Limpiar campos</asp:LinkButton>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="glass-card shadow-sm">
                        <h5 class="fw-bold mb-4 text-secondary">Lista Maestra de Productos</h5>
                        <div class="table-responsive">
                            <asp:GridView ID="gvProductos" runat="server" CssClass="table custom-grid" AutoGenerateColumns="False"
                                OnSelectedIndexChanged="gvProductos_SelectedIndexChanged"
                                OnRowDeleting="gvProductos_RowDeleting"
                                DataKeyNames="id_producto,nombre,precio_venta,stock_actual,id_categoria">
                                <Columns>
                                    <asp:BoundField DataField="id_producto" HeaderText="ID" ItemStyle-Font-Bold="true" />

                                    <asp:TemplateField HeaderText="Descripción">
                                        <ItemTemplate>
                                            <div class="fw-bold text-dark"><%# Eval("nombre") %></div>
                                            <small class="text-muted"><%# Eval("categoria_nombre") %></small>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Precio Venta">
                                        <ItemTemplate>
                                            <span class="fw-bold">S/ <%# Eval("precio_venta", "{0:F2}") %></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Stock">
                                        <ItemTemplate>
                                            <span class='<%# Convert.ToInt32(Eval("stock_actual")) < 5 ? "badge-stock stock-bajo" : "badge-stock" %>'>
                                                <%# Eval("stock_actual") %> Und.
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Acciones">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Select" CssClass="btn btn-sm btn-light text-warning me-2">
                    <i class="fas fa-edit"></i>
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-light text-danger"
                                                OnClientClick="return confirm('¿Eliminar definitivamente?');">
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
        </div>
    </form>
</body>
</html>
