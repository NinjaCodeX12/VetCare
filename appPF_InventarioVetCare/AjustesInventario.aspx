<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AjustesInventario.aspx.cs" Inherits="appPF_InventarioVetCare.AjustesInventario" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Ajuste de Inventario</title>

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
            padding: 30px;
            box-shadow: 0 4px 25px rgba(0,0,0,0.05);
        }

        .custom-grid th {
            background: #f1f5f9 !important;
            padding: 20px !important;
        }

        .custom-grid td {
            padding: 22px !important;
        }

        .badge-ajuste {
            padding: 6px 12px;
            border-radius: 8px;
            font-weight: 600;
        }

        .positivo {
            background: #dcfce7;
            color: #16a34a;
        }

        .negativo {
            background: #fee2e2;
            color: #dc2626;
        }
    </style>
</head>

<body>
    <form runat="server">

        <div class="container py-5">

            <h2 class="fw-bold mb-5">Ajustes <span class="text-primary">Inventario</span></h2>

            <!-- 🔥 ALERTA -->
            <asp:Panel ID="alerta" runat="server" Visible="false" CssClass="alert">
                <asp:Label ID="lblAlerta" runat="server"></asp:Label>
            </asp:Panel>

            <div class="row g-4">

                <!-- FORMULARIO -->
                <div class="col-lg-4">
                    <div class="glass-card">

                        <h5 class="fw-bold mb-4">Registro Rápido</h5>

                        <div class="mb-4">
                            <label class="fw-bold">Producto</label>
                            <asp:DropDownList ID="ddlProducto" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="mb-4">
                            <label class="fw-bold">Cantidad (+ / -)</label>
                            <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control form-control-lg" />
                        </div>

                        <div class="mb-4">
                            <label class="fw-bold">Motivo</label>
                            <asp:TextBox ID="txtMotivo" runat="server" CssClass="form-control form-control-lg" />
                        </div>

                        <div class="d-grid gap-2">
                            <asp:Button ID="btnAjustar" runat="server"
                                Text="Guardar Ajuste"
                                CssClass="btn btn-primary"
                                OnClick="btnAjustar_Click" />

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

                        <h5 class="fw-bold mb-4">Historial</h5>

                        <asp:GridView ID="gvAjustes" runat="server"
                            CssClass="table custom-grid"
                            AutoGenerateColumns="False">

                            <Columns>

                                <asp:BoundField DataField="id_ajuste" HeaderText="ID" />

                                <asp:BoundField DataField="fecha_ajuste" HeaderText="Fecha" />

                                <asp:TemplateField HeaderText="Producto">
                                    <ItemTemplate>
                                        <span class="fw-bold"><%# Eval("producto") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Cantidad">
                                    <ItemTemplate>
                                        <span class='<%# Convert.ToInt32(Eval("cantidad_ajustada")) > 0 ? "badge-ajuste positivo" : "badge-ajuste negativo" %>'>
                                            <%# Eval("cantidad_ajustada") %>
                                        </span>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="motivo" HeaderText="Motivo" />
                                <asp:BoundField DataField="usuario" HeaderText="Usuario" />

                            </Columns>
                        </asp:GridView>

                    </div>
                </div>

            </div>

        </div>

    </form>
</body>
</html>
