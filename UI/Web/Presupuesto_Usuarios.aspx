<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Presupuesto_Usuarios.aspx.cs" Inherits="UI.Web.Presupuesto_Usuarios" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <asp:ScriptManager ID="MyScripts" runat="server" EnablePageMethods="true" EnablePartialRendering="true" LoadScriptsBeforeUI="true" ScriptMode="Auto"> 
       
    </asp:ScriptManager>
        <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Permisos de Usuarios en Presupuestos"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="216px" Theme="SoftOrange" Width="422px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione Usuario" ColSpan="1" Name="CBUsuario" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxGridView ID="GUsuarios" runat="server" AutoGenerateColumns="False" ClientInstanceName="grid" CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine" DataSourceID="DS_Usuarios" EnableRowsCache="False" KeyFieldName="USUARIO" Theme="SoftOrange" Width="376px">
                                    <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                    <SettingsPopup>
                                        <HeaderFilter MinHeight="140px">
                                        </HeaderFilter>
                                    </SettingsPopup>
                                    <SettingsLoadingPanel ImagePosition="Top" />
                                    <ImagesEditors>
                                        <DropDownEditDropDown>
                                            <SpriteProperties HottrackedCssClass="dxEditors_edtDropDownHover_RedWine" />
                                        </DropDownEditDropDown>
                                    </ImagesEditors>
                                    <StylesEditors>
                                        <CalendarHeader Spacing="1px">
                                        </CalendarHeader>
                                        <ProgressBar Height="25px">
                                        </ProgressBar>
                                    </StylesEditors>
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="NOMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="3">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="USUARIO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="2">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewCommandColumn Name="Check" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                        </dx:GridViewCommandColumn>
                                    </Columns>
                                    <Styles CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine">
                                        <LoadingPanel ImageSpacing="8px">
                                        </LoadingPanel>
                                    </Styles>
                                    <Images SpriteCssFilePath="~/App_Themes/RedWine/{0}/sprite.css">
                                        <LoadingPanelOnStatusBar Url="~/App_Themes/RedWine/GridView/gvLoadingOnStatusBar.gif">
                                        </LoadingPanelOnStatusBar>
                                        <LoadingPanel Url="~/App_Themes/RedWine/GridView/Loading.gif">
                                        </LoadingPanel>
                                    </Images>
                                    <ImagesFilterControl>
                                        <LoadingPanel Url="~/App_Themes/RedWine/Editors/Loading.gif">
                                        </LoadingPanel>
                                    </ImagesFilterControl>
                                </dx:ASPxGridView>
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
                                <asp:UpdatePanel ID="update" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                    <ContentTemplate>
                                        <dx:ASPxButton ID="Lform_E3" runat="server" Height="32px" OnClick="Lform_E3_Click" Width="32px">
                                            <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/SaveAll_32x32.png" Repeat="NoRepeat" VerticalPosition="center" />
                                        </dx:ASPxButton>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
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
                Permisos&nbsp; &nbsp;&nbsp;&nbsp;
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
                <asp:SqlDataSource ID="DS_Presupuesto_Usuarios" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexionPortal %>" SelectCommand="PORTAL_GET_PRIVILEGIOS_USUARIOS_PRESUPUESTOS" SelectCommandType="StoredProcedure" ProviderName="<%$ ConnectionStrings:SQLConexionPortal.ProviderName %>">
                    <SelectParameters>
                        <asp:SessionParameter Name="USUARIO" SessionField="CBUsuario" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <dx:ASPxGridViewExporter ID="Exportador" runat="server" GridViewID="GUsuarios">
                </dx:ASPxGridViewExporter>
                          <asp:UpdatePanel runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true" >
                             <ContentTemplate>
                                            <asp:GridView ID ="gridview" runat="server" CssClass ="table table-hover table-bordered" AutoGenerateColumns="false"  >
                                                <Columns>
                                                    <asp:BoundField DataField ="NUM" HeaderText ="Código"  />
                                                    <asp:BoundField DataField ="PRESUPUESTO" HeaderText="Presupuesto" />
                                                    <asp:BoundField DataField ="EMPRESA" HeaderText="Empresa" />
                                                    <asp:BoundField DataField ="USUARIO" HeaderText="Usuario" />
                <asp:templatefield HeaderText="PRIV_MODIFICACION">
                    <itemtemplate>
                        <asp:checkbox ID="PRIV_MODIFICACION" 
                        CssClass="gridCB" runat="server" Checked='<%# Eval("PRIV_MODIFICACION") %>'></asp:checkbox>
                    </itemtemplate>
                </asp:templatefield>
                <asp:templatefield HeaderText="PRIV_EJECUCION">
                    <itemtemplate>
                        <asp:checkbox ID="PRIV_EJECUCION" 
                        CssClass="gridCB" runat="server" Checked='<%# Eval("PRIV_EJECUCION") %>'></asp:checkbox>
                    </itemtemplate>
                </asp:templatefield>
               <asp:templatefield HeaderText="PRIV_LECTURA">
                    <itemtemplate>
                        <asp:checkbox ID="PRIV_LECTURA" 
                        CssClass="gridCB" runat="server" Checked='<%# Eval("PRIV_LECTURA") %>'></asp:checkbox>
                    </itemtemplate>
                </asp:templatefield>
                                                </Columns>
                                                <PagerSettings  Mode="NextPreviousFirstLast"/>
                                            </asp:GridView>
                                              </ContentTemplate>
                            </asp:UpdatePanel>
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
