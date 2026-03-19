<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="appPF_InventarioVetCare.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - VetCare</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet" />

    <style>
        body {
            margin: 0;
            height: 100vh;
            font-family: 'Poppins', sans-serif;
        }

        .bg-login {
            background: url('Recursos/IMG/img_Login.png') no-repeat center center;
            background-size: cover;
            height: 100vh;
        }

        .info-box {
            padding: 80px;
        }

        /* TITULO BONITO */
        .titulo-bonito {
            font-size: 52px;
            font-weight: 700;
            background: linear-gradient(90deg, #f39c12, #e67e22);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: 1px;
        }

        .login-card {
            background-color: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0px 5px 20px rgba(0,0,0,0.2);
        }

        .btn-vetcare {
            background-color: #f39c12;
            border: none;
            color: white;
        }

            .btn-vetcare:hover {
                background-color: #e67e22;
            }
    </style>
</head>
<body>

    <form id="form1" runat="server">

        <div class="container-fluid bg-login">
            <div class="row h-100">

                <!-- IZQUIERDA -->
                <div class="col-md-7 d-flex flex-column justify-content-center info-box text-dark">

                    <h1 class="titulo-bonito mb-3">Bienvenido a VetCare 🐾
                    </h1>

                    <p class="mt-3 fs-5" style="line-height: 1.6;">
                        <strong>Sistema de Inventario VetCare S.A.C.</strong><br />
                        Gestiona eficientemente el ingreso y salida de productos,<br />
                        optimiza el control de tu almacén y mejora la rentabilidad<br />
                        de tu empresa veterinaria.
                    </p>

                    <div class="mt-4" style="font-size: 22px;">
                        <i class="fab fa-facebook me-3"></i>
                        <i class="fab fa-twitter me-3"></i>
                        <i class="fab fa-instagram me-3"></i>
                        <i class="fab fa-youtube"></i>
                    </div>

                </div>

                <!-- DERECHA LOGIN -->
                <div class="col-md-5 d-flex justify-content-center align-items-center">
                    <div class="login-card w-75">

                        <h3 class="text-center mb-4">Iniciar Sesión</h3>

                        <!-- CORREO -->
                        <div class="mb-3">
                            <label class="form-label">Correo Electrónico</label>
                            <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" placeholder="Ingrese su correo"></asp:TextBox>
                        </div>

                        <!-- PASSWORD -->
                        <div class="mb-3">
                            <label class="form-label">Contraseña</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Ingrese su contraseña"></asp:TextBox>
                        </div>

                        <!-- RECORDAR -->
                        <div class="form-check mb-3">
                            <asp:CheckBox ID="chkRecordar" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label">Recordarme</label>
                        </div>

                        <!-- BOTON -->
                        <div class="d-grid">
                            <asp:Button
                                OnClick="btnLogin_Click"
                                runat="server"
                                Text="Ingresar"
                                CssClass="btn btn-vetcare" />
                        </div>

                        <!-- EXTRA -->
                        <div class="text-center mt-3">
                            <small>¿Olvidaste tu contraseña?</small><br />
                            <small>Al iniciar sesión aceptas los términos del sistema VetCare</small>
                        </div>

                    </div>
                </div>

            </div>
        </div>

    </form>

    <!-- SCRIPTS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- VALIDACIONES FRONTEND -->
    <script>
        document.getElementById("<%= form1.ClientID %>").addEventListener("submit", function (e) {

            var correo = document.getElementById("<%= txtCorreo.ClientID %>").value.trim();
            var password = document.getElementById("<%= txtPassword.ClientID %>").value.trim();

            if (correo === "" && password === "") {
                e.preventDefault();
                Swal.fire({
                    icon: "error",
                    title: "Campos vacíos",
                    text: "Debes ingresar correo y contraseña"
                });
                return;
            }

            if (correo === "") {
                e.preventDefault();
                Swal.fire({
                    icon: "warning",
                    title: "Falta correo",
                    text: "Por favor ingresa tu correo"
                });
                return;
            }

            if (password === "") {
                e.preventDefault();
                Swal.fire({
                    icon: "warning",
                    title: "Falta contraseña",
                    text: "Por favor ingresa tu contraseña"
                });
                return;
            }

            // LOADING
            setTimeout(() => {
                Swal.fire({
                    title: 'Verificando...',
                    text: 'Validando usuario',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });
            }, 100);
        });
    </script>

</body>
</html>
