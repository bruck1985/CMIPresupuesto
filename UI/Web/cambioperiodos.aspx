<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="cambioperiodos.aspx.cs" Inherits="UI.Web.cambioperiodos" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 22px;
        }
        .auto-style2 {
            width: 45px;
        }
        .auto-style3 {
            height: 22px;
            width: 11px;
        }
        .auto-style4 {
            height: 22px;
            width: 73px;
        }
        .auto-style5 {
            width: 73px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Cambio de Periodos de Trabajo"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="530px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Fechas de Trabajo" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Con Advertencia Ini" ColSpan="1" Name="FechaadvIni" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="Lform_E6" runat="server" Theme="SoftOrange">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

 


                    <dx:LayoutItem Caption="Con Advertencia Fin" ColSpan="1" Name="FechaadvFin" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="Lform_E5" runat="server" Theme="SoftOrange">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Periodo de Trabajo Ini" ColSpan="1" Name="FechatraIni" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="Lform_E4" runat="server" Theme="SoftOrange">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Periodo de Trabajo final" ColSpan="1" Name="FechatraFin" >
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="Lform_E2" runat="server" Theme="SoftOrange">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
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
                                <dx:ASPxButton ID="Lform_E3" runat="server" Height="32px" Width="32px" AutoPostBack="False">
                                    <ClientSideEvents Click="function(s, e) {
	  PDialogo.Show();
}" />
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
                  <dx:ASPxLabel runat="server" Font-Bold="True" Font-Size="12pt" ForeColor="Red" ID="Pmensaje"></dx:ASPxLabel>


                     
                    
                    
                    
                

                    

            </td>
            <td>
                &nbsp;</td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                Seleccione compañias a modificar: &nbsp;&nbsp;&nbsp;
                <asp:SqlDataSource ID="DS_Periodos" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand='portal.[dbo].[PORTAL_PERIODOS_CONTABLES]' SelectCommandType="StoredProcedure">
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
                    CssPostfix="RedWine" DataSourceID="DS_Periodos" KeyFieldName="CIA" 
                    Width="376px" ClientInstanceName="grid" EnableRowsCache="False" Theme="SoftOrange">
                    <ImagesFilterControl>
                        <LoadingPanel Url="~/App_Themes/RedWine/Editors/Loading.gif">
                        </LoadingPanel>
                    </ImagesFilterControl>
                    <Styles CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine">
                        <LoadingPanel ImageSpacing="8px">
                        </LoadingPanel>
                    </Styles>
                    <SettingsPager NumericButtonCount="20" PageSize="20">
                    </SettingsPager>
                    <SettingsLoadingPanel ImagePosition="Top" />
                    <Images SpriteCssFilePath="~/App_Themes/RedWine/{0}/sprite.css">
                        <LoadingPanelOnStatusBar Url="~/App_Themes/RedWine/GridView/gvLoadingOnStatusBar.gif">
                        </LoadingPanelOnStatusBar>
                        <LoadingPanel Url="~/App_Themes/RedWine/GridView/Loading.gif">
                        </LoadingPanel>
                    </Images>
                    <Columns>
                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="5">
                            <HeaderStyle HorizontalAlign="Center">
                                <Paddings PaddingBottom="1px" PaddingTop="1px" />
                            </HeaderStyle>
                            <HeaderTemplate>
                 				<input type="checkbox" onclick="grid.SelectAllRowsOnPage(this.checked);" style="vertical-align:middle;" title="Seleccione/Deseleccione todas las filas de la pagina"></input>
                            </HeaderTemplate>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="CIA" FixedStyle="Left" ReadOnly="True" Caption ="Compañia"
                            VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FECHA_ADV_INI" FixedStyle="Left" VisibleIndex="1" Caption ="Fecha Adv Ini"
                            Width="100%">
                            <SettingsHeaderFilter>
                                <DateRangePickerSettings DisplayFormatString="dd-MM-yy">
                                </DateRangePickerSettings>
                            </SettingsHeaderFilter>
                        </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn FieldName="FECHA_ADV_FIN" FixedStyle="Left" VisibleIndex="2"  Caption ="Fecha Adv Fin"
                            Width="100%">
                                                    <SettingsHeaderFilter>
                                                        <DateRangePickerSettings DisplayFormatString="dd-MM-yy">
                                                        </DateRangePickerSettings>
                                                    </SettingsHeaderFilter>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FECHA_TRABAJO_INI" FixedStyle="Left" VisibleIndex="3" Caption ="Periodo Ini"
                            Width="100%">
                            <SettingsHeaderFilter>
                                <DateRangePickerSettings DisplayFormatString="dd-MM-yy">
                                </DateRangePickerSettings>
                            </SettingsHeaderFilter>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="FECHA_TRABAJO_FIN" FixedStyle="Left" VisibleIndex="4"  Caption ="Periodo Fin"
                            Width="100%">
                            <SettingsHeaderFilter>
                                <DateRangePickerSettings DisplayFormatString="dd-MM-yy">
                                </DateRangePickerSettings>
                            </SettingsHeaderFilter>
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
    <dx:ASPxPopupControl ID="PDialogo" runat="server" Height="130px" Width="363px" HeaderText="Confirmación"  ClientInstanceName="PDialogo" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
                    <SettingsAdaptivity VerticalAlign="WindowCenter" />
                    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <table style="width:100%;">
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style5"></td>
            <td class="auto-style3" colspan="3">
                <dx:ASPxLabel ID="LabelMensaje" runat="server" Font-Bold="True" Text="Esta seguro que desea actualizar los periodos contables?" style="margin-left: 7px" Width="300px">
                    <DisabledStyle Font-Bold="True">
                    </DisabledStyle>
                </dx:ASPxLabel>
            </td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style4"></td>
            <td class="auto-style1"></td>
            <td class="auto-style1"></td>
            <td class="auto-style1"></td>
            <td class="auto-style1"></td>
        </tr>
        <tr>
            <td class="auto-style5"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="BTAceptar" runat="server" OnClick="BTAceptar_Click" Text="Aceptar" Width="80px">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo.Hide();
}" />
                    <Image IconID="businessobjects_bo_validation_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="BTCancelar" runat="server" Text="Cancelar">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo.Hide();
}" />
                    <Image Width="80px" IconID="iconbuilder_actions_delete_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
                        </dx:PopupControlContentControl>
</ContentCollection>
                </dx:ASPxPopupControl>


</asp:Content>
