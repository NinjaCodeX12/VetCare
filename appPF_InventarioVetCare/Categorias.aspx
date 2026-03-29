<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="appPF_InventarioVetCare.Categorias" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>VetCare Pro - Categorías</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet" />

<link href="Recursos/CSS/Productos.css" rel="stylesheet" />

<!-- 🔥 ESTILO EXTRA SOLO PARA PAGINACIÓN -->
<style>
    .pagination {
        justify-content: center;
        margin-top: 15px;
    }

    .pagination a,
    .pagination span {
        padding: 6px 12px;
        margin: 2px;
        border-radius: 8px;
        text-decoration: none;
        border: 1px solid #e2e8f0;
        color: #334155;
        font-weight: 500;
    }

    .pagination span {
        background: #3b82f6;
        color: white;
        border: none;
    }

    .pagination a:hover {
        background: #f1f5f9;
    }
</style>

</head>

<body>
<form id="form1" runat="server">

<div class="container py-5">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-5">
        <h2 class="fw-bold mb-0">
            Categorías <span class="text-primary">VetCare</span>
        </h2>

        <div class="glass-card d-flex gap-5 py-3 px-4 shadow-sm">
            <div class="text-center">
                <small class="text-muted d-block fw-bold">TOTAL</small>
                <asp:Label ID="lblTotalCat" runat="server"
                    Text="0"
                    CssClass="fw-bold h4 mb-0 text-primary"></asp:Label>
            </div>
        </div>
    </div>

    <div class="row g-4">

        <!-- FORM -->
        <div class="col-lg-4">
            <div class="glass-card">
                <h5 class="fw-bold mb-4">Registro Rápido</h5>

                <div class="mb-4">
                    <label class="form-label small fw-bold">Nombre Categoría</label>
                    <asp:TextBox ID="txtNombreCat" runat="server"
                        CssClass="form-control form-control-lg"
                        placeholder="Ej. Medicinas"></asp:TextBox>
                </div>

                <div class="d-grid gap-2">
                    <asp:Button ID="btnGuardarCat" runat="server"
                        Text="Guardar"
                        CssClass="btn btn-modern btn-primary shadow-sm"
                        OnClick="btnGuardarCat_Click" />
                </div>
            </div>
        </div>

        <!-- TABLA -->
        <div class="col-lg-8">
            <div class="glass-card shadow-sm">
                <h5 class="fw-bold mb-4 text-secondary">Lista de Categorías</h5>

                <div class="table-responsive">

                    <asp:GridView ID="gvCategorias" runat="server"
                        CssClass="table custom-grid"
                        AutoGenerateColumns="False"
                        AllowPaging="True"
                        PageSize="5"
                        DataKeyNames="id_categoria"
                        OnPageIndexChanging="gvCategorias_PageIndexChanging"
                        OnRowDeleting="gvCategorias_RowDeleting"
                        
                        PagerStyle-CssClass="pagination"
                        PagerSettings-Mode="Numeric"
                        PagerSettings-Position="Bottom">

                        <Columns>

                            <asp:TemplateField HeaderText="#">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 + (gvCategorias.PageIndex * gvCategorias.PageSize) %>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="id_categoria" HeaderText="ID" />

                            <asp:BoundField DataField="nombre" HeaderText="Categoría" />

                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server"
                                        CommandName="Delete"
                                        CssClass="btn btn-sm btn-light text-danger"
                                        OnClientClick="return confirm('¿Eliminar categoría?');">
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