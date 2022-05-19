<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MenuDashboard.Web.Login" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" style="background: url('Imagenes/Login/2.jpg'); background-position:center center; background-repeat:repeat; background-attachment:fixed; background-size:cover">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <meta http-equiv="cache-control" content="max-age=0" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta http-equiv="expires" content="0" />
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
    <meta http-equiv="pragma" content="no-cache" />

    <!-- CSS -->
    <%--<link rel="stylesheet" href="assets/css/reset.css"/>--%>
    <%--<link rel="stylesheet" href="assets/css/supersized.css"/>--%>
    <link rel="stylesheet" href="assets/css/style.css" />

    <title>CMI Data Analisis </title>

    <script type="text/javascript">

        function SesionExpirada() {
            alert('Su sesión ha expirado...');
        }


    </script>

</head>
<body style="background: none">
    <div class="page-container">

        <form id="form1" runat="server">

            <asp:LinkButton ID="BTN_Logo" runat="server" OnClientClick="window.open('http://www.fulltechnology.com/')" style="text-decoration:none">
                <img id="Logo" src="Imagenes/Login/logo3.png" border="0" />
            </asp:LinkButton><br />
            <br />

            <asp:TextBox ID="TB_Usuario" runat="server" placeholder="Usuario"></asp:TextBox><br />

            <asp:TextBox ID="TB_Password" runat="server" TextMode="Password" placeholder="Contrasena"></asp:TextBox>

            <asp:DropDownList ID="DDL_Empresas" runat="server" Visible="false"></asp:DropDownList>

            <br />
            <br />
            <asp:Label ID="LBL_Mensaje" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label><br />

            <asp:Button ID="BTN_Ejecutar" runat="server" Text="Cargar" OnClick="BTN_Ejecutar_Click" />

            <asp:Button ID="BTN_CerrarSesion" runat="server" Text="Atras" Visible="false" OnClick="BTN_Atras_Click"></asp:Button>
        </form>

    </div>

    <!-- Javascript -->
    <%--<script src="assets/js/jquery-1.8.2.min.js"></script>--%>
    <%--<script src="assets/js/supersized.3.2.7.min.js"></script>--%>
    <%--<script src="assets/js/supersized-init.js"></script>--%>
    <%--<script src="assets/js/scripts.js"></script>--%>
</body>
</html>
