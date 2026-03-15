<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="appPF_InventarioVetCare.Productos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

    <title>Productos</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>
        body {
            background: #f4f6f9;
            padding: 20px;
        }

        .card {
            border: none;
            border-radius: 10px;
        }
    </style>

</head>

<body>

    <form id="form1" runat="server">

        <div class="container-fluid">

            <h3 class="mb-4">Gestión de Productos</h3>

            <div class="row">

                <!-- FORMULARIO -->

                <div class="col-md-4">

                    <div class="card shadow-sm">

                        <div class="card-header bg-primary text-white">
                            Nuevo Producto
                        </div>

                        <div class="card-body">

                            <div class="mb-3">
                                <label class="form-label">Nombre</label>
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Categoría</label>
                                <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select">
                                    <asp:ListItem>Medicamentos</asp:ListItem>
                                    <asp:ListItem>Alimentos</asp:ListItem>
                                    <asp:ListItem>Accesorios</asp:ListItem>
                                    <asp:ListItem>Higiene</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Precio</label>
                                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Stock</label>
                                <asp:TextBox ID="txtStock" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="d-grid gap-2">

                                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success" />

                                <asp:Button ID="btnNuevo" runat="server" Text="Nuevo" CssClass="btn btn-secondary" />

                            </div>

                        </div>

                    </div>

                </div>

                <!-- TABLA -->

                <div class="col-md-8">

                    <div class="card shadow-sm">

                        <div class="card-header bg-dark text-white">
                            Lista de Productos
                        </div>

                        <div class="card-body">

                            <asp:GridView ID="gvProductos" runat="server" CssClass="table table-striped table-hover" AutoGenerateColumns="False">

                                <Columns>

                                    <asp:BoundField DataField="IdProducto" HeaderText="ID" />

                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />

                                    <asp:BoundField DataField="Categoria" HeaderText="Categoría" />

                                    <asp:BoundField DataField="Precio" HeaderText="Precio" />

                                    <asp:BoundField DataField="Stock" HeaderText="Stock" />

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
