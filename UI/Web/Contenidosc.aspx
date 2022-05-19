<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Contenidosc.aspx.cs" Inherits="UI.Web.Contenidosc" %>

<%@ Register Assembly="DevExpress.Dashboard.v18.2.Web.WebForms, Version=18.2.14.0, Culture=neutral, PublicKeyToken=B88D1754D700E49A" Namespace="DevExpress.DashboardWeb" TagPrefix="dx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        // Esta funcion es para establecer Mobile Layout (CTP)
        // https://documentation.devexpress.com/Dashboard/119662/Building-the-Designer-and-Viewer-Applications/Web-Dashboard/Mobile-Layout-CTP
        function onBeforeRender(sender) {
            var control = sender.GetDashboardControl();
            control.registerExtension(new DevExpress.Dashboard.MobileLayoutExtension(control));

            // Aprovecho para ajustar la altura del control.
            setHeight();
        }

        // Esta funcion setea la altura del control del dashboard ya que el height=100% no funciona como se espera
        function setHeight() {
            var tamano = window.innerHeight + 15;
            if (window.innerHeight < 600) {
                tamano = tamano + 35;
            }

            document.getElementById("ContentPlaceHolder1_ASPxDashboard1").style.height = tamano + "px";
        }

        // Esta funcion es para que re-calcular el tamaño del dashboard cuando el la ventana del navegador cambia de tamaño.
        window.addEventListener("resize", function () {
            setHeight();
        }, false);
    </script>

    <style type="text/css">
        /* Si se quita esto, tomará el color gris claro del skin */
        .dx-dashboard-control {
            background-color: transparent;
        }

        /* El titulo estaba tomando una altura mas de la debida. Con estos dos estilos se corrige */
        dashboard-title {
            height: auto !important;
        }
        .dx-layout-root {
            top: 48px !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- A partir de la version DevExpress 17.1 se sugiere utilizar el AXPxDashboard en vez del ASPxDashboardViewer 
        https://www.devexpress.com/Support/Center/Question/Details/T505662/how-to-migrate-from-aspxdashboardviewer-to-aspxdashboard-working-in-the-vieweronly-mode
        -->
    <dx:ASPxDashboard ID="ASPxDashboard1"
        WorkingMode="ViewerOnly" 
        AllowExportDashboardItems="True" 
        Width="100%" 
        Height="100%"
        runat="server" 
        OnDashboardLoading="ASPxDashboard1_DashboardLoading" AllowExecutingCustomSql="True">
        <ClientSideEvents BeforeRender="onBeforeRender" />
    </dx:ASPxDashboard>
</asp:Content>