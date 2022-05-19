<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AprobacionCambio.aspx.cs" Inherits="UI.AprobacionCambio" %>

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

            <asp:Label ID="LBL_Mensaje" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label><br />

        </form>

    </div>

</body>
</html>