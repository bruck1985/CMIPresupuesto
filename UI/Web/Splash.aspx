<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Splash.aspx.cs" Inherits="UI.Web.Splash" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <dx:ASPxImage ID="ASPxImage1" runat="server" Height="100%" ImageUrl="~/Imagenes/Splash.jpg" ShowLoadingImage="true" Width="100%">
    </dx:ASPxImage>
</asp:Content>
