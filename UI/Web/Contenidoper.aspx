<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Contenidoper.aspx.cs" Inherits="UI.Web.Contenidoper" %>


<%@ Register Assembly="DevExpress.Dashboard.v18.2.Web.WebForms, Version=18.2.14.0, Culture=neutral, PublicKeyToken=B88D1754D700E49A" Namespace="DevExpress.DashboardWeb" TagPrefix="dx" %>


<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

   

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
                <dx:ASPxComboBox ID="BEPeriodo" runat="server" ClientIDMode="AutoID" 
                                    ValueType="System.String" BackColor="LightCyan" RenderIFrameForPopupElements="False" SelectedIndex="0" Width="136px">
                                    <ButtonStyle Width="13px" Cursor="pointer"></ButtonStyle>
                                    <ItemStyle BackColor="LightCyan" />
                                      <Items>
                                         <dx:ListEditItem Text="Mes Actual" Value="Mes Actual" />
                                         <dx:ListEditItem Text="Mes Anterior" Value="Mes Anterior" />
                                         <dx:ListEditItem Text="Ultimos 3 Meses" Value="Ultimos 3 Meses" />
                                         <dx:ListEditItem Text="Ultimos 6 Meses" Value="Ultimos 6 Meses" />
                                         <dx:ListEditItem Text="Ultimo A&#241;o" Value="Ultimo A&#241;o" />
                                         <dx:ListEditItem Text="Rango de Fechas" Value="Rango de Fechas" />
                                      </Items>
                                </dx:ASPxComboBox>
       <dx:ASPxDashboardViewer ID="ASPxDashboardViewer1"  OnDashboardLoaded="ASPxDashboardViewer1_DashboardLoaded"   OnDashboardLoading="ASPxDashboardViewer1_DashboardLoading" AllowExportDashboardItems="True" CalculateHiddenTotals="True"  Width="100%"  Height="100%"    runat="server">
       
       
       </dx:ASPxDashboardViewer>  
   <asp:TextBox ID="TBPInicial" runat="server" Visible="False"></asp:TextBox><br />
    <asp:TextBox ID="TBPFinal" runat="server" Visible="False"></asp:TextBox><br />
    <dx:ASPxPopupControl ID="Selector_RangoFechas" runat="server" HeaderText="Select date"
        Height="72px" 
       EnableHotTrack ="False" >
        <HeaderStyle>
        <Paddings PaddingRight="6px" />
        </HeaderStyle>
        <ContentCollection>
            <dx:PopupControlContentControl runat="server">
            </dx:PopupControlContentControl>
        </ContentCollection>
        <Windows>
            <dx:PopupWindow Name="Sel_RangoFechas">
                <ContentCollection>
                    <dx:PopupControlContentControl runat="server">
                        <table style="width: 176px; height: 88px">
                            <tr>
                                <td style="width: 173px">
                                    <dx:ASPxDateEdit ID="CB_PerIni" runat="server" 
                                        Width="120px">
                                        <ButtonStyle Width="13px">
                                        </ButtonStyle>
                                    </dx:ASPxDateEdit>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <dx:ASPxDateEdit ID="Cb_PerFin" runat="server" 
                                        Width="112px">
                                        <ButtonStyle Width="13px">
                                        </ButtonStyle>
                                    </dx:ASPxDateEdit>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 173px">
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" style="width: 173px">
                                    <dx:ASPxButton ID="SelPer_Aceptar" runat="server"  Text="OK" >
                                    </dx:ASPxButton>
                                </td>
                                <td align="center">
                                </td>
                                <td>
                                    <dx:ASPxButton ID="SelPer_Cancelar" runat="server" Text="Cancel" >
                                    </dx:ASPxButton>
                                </td>
                            </tr>
                        </table>
                    </dx:PopupControlContentControl>
                </ContentCollection>
            </dx:PopupWindow>
        </Windows>
    </dx:ASPxPopupControl>
   
  
                <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server">
                </dx:ASPxPopupControl>
   
  
                <br />
  
  
</asp:Content>

