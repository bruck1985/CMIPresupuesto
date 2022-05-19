<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Presupuesto_Dash_Det.aspx.cs" Inherits="UI.Web.Presupuesto_Dash_Det" %>
<%@ Register assembly="DevExpress.Dashboard.v18.2.Web.WebForms, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.DashboardWeb" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <dx:ASPxDashboard ID="ASPxDashboard1" runat="server" DashboardXmlPath="~/App_Data/Dashboards/dashboard_Det.xml" WorkingMode="Viewer">
    </dx:ASPxDashboard>
</asp:Content>
