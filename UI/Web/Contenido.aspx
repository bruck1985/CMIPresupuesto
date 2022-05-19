<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Contenido.aspx.cs" Inherits="UI.Web.Contenido" %>


<%@ Register Assembly="DevExpress.Dashboard.v18.2.Web.WebForms, Version=18.2.14.0, Culture=neutral, PublicKeyToken=B88D1754D700E49A" Namespace="DevExpress.DashboardWeb" TagPrefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%--  <div runat="server" visible="false"  id="FiltradoDiv">

                            <div class="col-xs-5 col-md-12" >
                               
                                <div class="col-xs-12 col-md-5" >
                                     <asp:Label ID="Label1" runat="server" Text="Filtrado de Fechas : " Font-Bold="True"></asp:Label>
                               
                                    <asp:DropDownList ID="DD_Filt" CssClass="dropdown-navbar"    runat="server">
                                        <asp:ListItem Text="Seleccionar" Value="-1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Mes Actual" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Mes Anterior" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Últimos 2 Meses" Value="2"></asp:ListItem> 
                                        <asp:ListItem Text="Últimos 3 Meses" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="Últimos 6 Meses" Value="6"></asp:ListItem>
                                    </asp:DropDownList>

                                </div>
                                <div class="col-md-3" >
                                    <asp:DropDownList CssClass="dropdown-navbar"  ID="DD_DataSources" runat="server">
                                    </asp:DropDownList>
                               </div>
                                <div class="col-md-3" >
                                      <asp:Button CssClass="btn btn-link btn-md"  OnClick="btnFiltro_Click"  runat="server" Text="Aplicar Filtro" ID="btnFiltro" Font-Bold="True" />
                                </div>
                             </div>
      </div>--%>
    

       <dx:ASPxDashboardViewer ID="ASPxDashboardViewer1"  OnDashboardLoaded="ASPxDashboardViewer1_DashboardLoaded"   OnDashboardLoading="ASPxDashboardViewer1_DashboardLoading" AllowExportDashboardItems="True" CalculateHiddenTotals="True"  Width="100%"  Height="100%"    runat="server">
       
       
       </dx:ASPxDashboardViewer>  

   
  
</asp:Content>

