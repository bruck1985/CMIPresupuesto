<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Permisos.aspx.cs" Inherits="UI.Web.Permisos" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Permisos de Usuarios"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="530px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione Usuario" ColSpan="1" Name="CBUsuario" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E4" runat="server" DataSourceID="DS_Usuarios" EnableTheming="True" TextField="NOMBRE" Theme="SoftOrange" ValueField="USUARIO" Width="250px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

 


                    <dx:LayoutItem Caption="" ColSpan="1" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_Click" Theme="SoftOrange" Width="32px" ToolTip="Generar información">
                                  <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E3" runat="server" Height="32px" Width="32px" OnClick="Lform_E3_Click">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/SaveAll_32x32.png" Repeat="NoRepeat" VerticalPosition="center" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/SaveAll_32x32.png">
                        </TabImage>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px" ToolTip="Exportar Excel">
                                   <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

        <table style="width: 496px; height: 192px">
        <tr>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                Seleccione Usuario: &nbsp;&nbsp;&nbsp;
                <asp:SqlDataSource ID="DS_Usuarios" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep; Password=P0rta1R3p.2766$"
                    ProviderName="System.Data.SqlClient" SelectCommand='SELECT USUARIO
      ,USUARIO + &#039; &#039; + NOMBRE NOMBRE
  FROM [ME].[erpadmin].[USUARIO]
  where activo = &#039;S&#039;
order by 2'>
                </asp:SqlDataSource>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxGridView ID="GPermisos" runat="server" AutoGenerateColumns="False" CssFilePath="~/App_Themes/RedWine/{0}/styles.css"
                    CssPostfix="RedWine" DataSourceID="DS_Menu" KeyFieldName="ID_MENU" 
                    Width="376px" ClientInstanceName="grid" EnableRowsCache="False" Theme="SoftOrange">
                    <ImagesFilterControl>
                        <LoadingPanel Url="~/App_Themes/RedWine/Editors/Loading.gif">
                        </LoadingPanel>
                    </ImagesFilterControl>
                    <Styles CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine">
                        <LoadingPanel ImageSpacing="8px">
                        </LoadingPanel>
                    </Styles>
                    <SettingsLoadingPanel ImagePosition="Top" />
                    <Images SpriteCssFilePath="~/App_Themes/RedWine/{0}/sprite.css">
                        <LoadingPanelOnStatusBar Url="~/App_Themes/RedWine/GridView/gvLoadingOnStatusBar.gif">
                        </LoadingPanelOnStatusBar>
                        <LoadingPanel Url="~/App_Themes/RedWine/GridView/Loading.gif">
                        </LoadingPanel>
                    </Images>
                    <Columns>
                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="2">
                            <HeaderStyle HorizontalAlign="Center">
                                <Paddings PaddingBottom="1px" PaddingTop="1px" />
                            </HeaderStyle>
                            <HeaderTemplate>
                 				<input type="checkbox" onclick="grid.SelectAllRowsOnPage(this.checked);" style="vertical-align:middle;" title="Seleccione/Deseleccione todas las filas de la pagina"></input>
                            </HeaderTemplate>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="ID_MENU" FixedStyle="Left" ReadOnly="True"
                            VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DESCRIPCION" FixedStyle="Left" VisibleIndex="1"
                            Width="100%">
                        </dx:GridViewDataTextColumn>
                    </Columns>
                    <StylesEditors>
                        <CalendarHeader Spacing="1px">
                        </CalendarHeader>
                        <ProgressBar Height="25px">
                        </ProgressBar>
                    </StylesEditors>
                    <ImagesEditors>
                        <DropDownEditDropDown >
                            <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_RedWine" />
                        </DropDownEditDropDown>
                    </ImagesEditors>
                </dx:ASPxGridView>
                <asp:SqlDataSource ID="DS_Menu" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep; Password=P0rta1R3p.2766$"
                    ProviderName="System.Data.SqlClient" SelectCommand="SELECT [ID] ID_MENU
      ,[nombre] DESCRIPCION
  FROM [PORTAL].[dbo].[Menu]
  order by ID">
                </asp:SqlDataSource>
                <dx:ASPxGridViewExporter ID="Exportador" runat="server">
                </dx:ASPxGridViewExporter>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
