<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="AccesoRestringuido.aspx.cs" Inherits="UI.Web.AccesoRestringuido" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="Usuario no esta vinculado a un cluster-departamento, comuniquese con el administrador del sitio."></asp:Label>
    <br />
</asp:Content>
