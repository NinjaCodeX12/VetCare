<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Movimientos.aspx.cs" Inherits="appPF_InventarioVetCare.Movimientos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Movimientos de Almacén - VetCare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet" />
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8f9fa;
        }

        .card {
            border-radius: 12px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid mt-4">

            <div class="d-flex align-items-center mb-4">
                <div class="bg-primary text-white rounded-circle p-3 me-3 shadow-sm">
                    <i class="fa-solid fa-right-left fa-xl"></i>
                </div>
                <div>
                    <h2 class="mb-0 fw-bold">Gestión de Inventario</h2>
                    <p class="text-muted mb-0">Registrar Entradas y Salidas de Productos</p>
                </div>
            </div>

            <div class="row">
                <div class="col-md-5">
                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-body p-4">
                            <h5 class="card-title fw-bold mb-4 text-primary">
                                <i class="fa-solid fa-file-invoice me-2"></i>1. Datos de Cabecera
                            </h5>

                            <div class="mb-3">
                                <label class="form-label small fw-bold text-secondary text-uppercase">Tipo de Operación</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-arrow-right-arrow-left text-primary"></i></span>
                                    <asp:DropDownList ID="ddlTipoMovimiento" runat="server" CssClass="form-select border-start-0">
                                        <asp:ListItem Text="-- Seleccione Movimiento --" Value="" />
                                        <asp:ListItem Text="Entrada (+)" Value="Entrada" />
                                        <asp:ListItem Text="Salida (-)" Value="Salida" />
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label small fw-bold text-secondary text-uppercase">Documento de Referencia</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="fa-solid fa-hashtag text-primary"></i></span>
                                    <asp:TextBox ID="txtReferencia" runat="server" CssClass="form-control border-start-0" placeholder="Ej: Factura, Guía o Boleta"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-7">
                    <div class="card shadow-sm border-0 mb-4 border-top border-success border-4">
                        <div class="card-body p-4">
                            <h5 class="card-title fw-bold mb-4 text-success">
                                <i class="fa-solid fa-box-open me-2"></i>2. Detalle del Movimiento
                            </h5>

                            <div class="row g-2">
                                <div class="col-md-7">
                                    <label class="form-label small fw-bold text-secondary">PRODUCTO</label>
                                    <asp:DropDownList ID="ddlProducto" runat="server" CssClass="form-select"></asp:DropDownList>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label small fw-bold text-secondary">CANTIDAD</label>
                                    <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" TextMode="Number" placeholder="0"></asp:TextBox>
                                </div>
                                <div class="col-md-2 d-flex align-items-end">
                                    <asp:LinkButton ID="btnAgregar" runat="server" CssClass="btn btn-success w-100" OnClick="btnAgregar_Click">
                                        <i class="fa-solid fa-plus"></i>
                                    </asp:LinkButton>
                                </div>
                            </div>

                            <hr class="my-4" />

                            <div class="table-responsive">
                                <asp:GridView ID="gvDetalleTemporal" runat="server" CssClass="table table-hover align-middle"
                                    AutoGenerateColumns="False" EmptyDataText="Aún no has agregado productos a la lista.">
                                    <Columns>
                                        <asp:BoundField DataField="NombreProducto" HeaderText="PRODUCTO" />
                                        <asp:BoundField DataField="Cantidad" HeaderText="CANT." ItemStyle-CssClass="fw-bold" />
                                        <asp:TemplateField HeaderText="ACCIÓN" ItemStyle-CssClass="text-end">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnQuitar" runat="server" CommandName="Delete" CssClass="text-danger">
                                                    <i class="fa-solid fa-trash-can"></i>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="table-light small text-uppercase fw-bold" />
                                </asp:GridView>
                            </div>

                            <div class="mt-4">
                                <asp:Button ID="btnProcesar" runat="server" Text="Finalizar y Actualizar Almacén"
                                    CssClass="btn btn-primary btn-lg w-100 fw-bold shadow-sm" OnClick="btnProcesar_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
