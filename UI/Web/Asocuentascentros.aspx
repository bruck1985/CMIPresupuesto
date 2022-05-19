<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Asocuentascentros.aspx.cs" Inherits="UI.Web.Asocuentascentros" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .auto-style1 {
            height: 14px;
        }
        .auto-style2 {
            height: 14px;
            width: 128px;
        }
        .auto-style3 {
            width: 128px;
        }
        .auto-style4 {
            height: 14px;
            width: 71px;
        }
        .auto-style8 {
            width: 72px;
        }
        .auto-style9 {
            width: 72px;
            height: 21px;
        }
        .auto-style10 {
            width: 88px;
        }
        .auto-style11 {
            width: 88px;
            height: 21px;
        }
    </style>
       <script type="text/javascript">
             var command;
             var commandcbp;

        function onTextChanged(s, e) {
           
            //CBListaAbuelo.PerformCallback(CBListaAbuelo.GetText());
            //var n = CBListaAbuelo.GetText().length;
            //if (n > 4) {
            //    tbnombreabuelo.SetText(CBListaAbuelo.GetText().substring(4));
            //} else {
            //    tbnombreabuelo.SetText("");
           // }
        }

        function onBeginCallback(s, e) {
            command = e.command;
        }

        function onEndCallback(s, e) {
            if (command == "") {
                s.SetText(s.cpText);
                s.cpText = null;
            }
        }

        function OnSelectedIndexChangedCallback(s, e) {
            var n = CBListaAbuelo.GetText().length;
             if (n > 4) {
                 tbnombreabuelo.SetText(CBListaAbuelo.GetText().substring(4));
             } else {
                 tbnombreabuelo.SetText("");
             }
             CBListaPadre.PerformCallback(CBListaAbuelo.GetValue());
        }

            function onTextChangedcbp(s, e) {
               // CBListaPadre.PerformCallback(CBListaPadre.GetText());
            }

            function onBeginCallbackcbp(s, e) {
                commandcbp = e.command;
            }

            function onEndCallbackcbp(s, e) {
                if (commandcbp == "") {
                    s.SetText(s.cpTextcbp);
                    s.cpTextcbp = null;
                }
            }

            function OnSelectedIndexChangedCallbackcbp(s, e) {
                var n = CBListaPadre.GetText().length;
                if (n > 4) {
                    tbnombrepadre.SetText(CBListaPadre.GetText().substring(4));
                } else {
                    tbnombrepadre.SetText("");
                }

              }



        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Asociación Cuentas a Centro de Costos "></asp:Label>
    &nbsp;<br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="1124px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="10" ColSpan="1" ColumnCount="10" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione Compañia" ColSpan="1" Name="CBUsuario" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E4" runat="server" DataSourceID="DS_Companias" EnableTheming="True" TextField="nombre" Theme="SoftOrange" ValueField="conjunto" Width="250px">
                                    <ClientSideEvents SelectedIndexChanged="function(s, e) {
	cbcuenta.PerformCallback(s.GetSelectedItem().value);
}" />
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Seleccione Cuenta Contable" ColSpan="1" Name="CBCuentas" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E2" runat="server" DataSourceID="DS_CuentaContable_CB" EnableTheming="True" TextField="DESCRIPCION" Theme="SoftOrange" ValueField="CUENTA_CONTABLE" ClientInstanceName="cbcuenta" OnCallback="Lform_E2_Callback" OnSelectedIndexChanged="Lform_E2_SelectedIndexChanged">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Rango de Centro Inicial" ColSpan="1" Name="TXCentroIni" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="Lform_E5" runat="server">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Rango de Centro Final" ColSpan="1"  Name="TXCentroFin" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="Lform_E6" runat="server">
                                </dx:ASPxTextBox>
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
                                <dx:ASPxButton ID="Lform_E3" runat="server" Height="32px" Width="32px" AutoPostBack="False" OnClick="Lform_E3_Click1">
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
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                Seleccione para asociar Centros: &nbsp;&nbsp;&nbsp;
                <asp:SqlDataSource ID="DS_Companias" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="System.Data.SqlClient" SelectCommand='  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + &#039; &#039; + c.nombre nombre
  FROM [erpadmin].[PRIVILEGIO_EX] P, erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or (&#039;PortalRep&#039; = REPLACE(@PUsuarioCia, CHAR(10), &#039;&#039;))) and P.[ACTIVO] = &#039;S&#039; and P.conjunto = c.conjunto
order by 2'>
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="PUsuarioCia24" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="DS_CuentaContable_CB" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="System.Data.SqlClient" SelectCommand='portal.[dbo].[PORTAL_CUENTACONTABLE_CB3]' SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCia24" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <dx:ASPxGridView ID="GPermisos" runat="server" AutoGenerateColumns="False" DataSourceID="DS_CENTRO_COSTO_GRID" KeyFieldName="CENTRO_COSTO" 
                    Width="376px" ClientInstanceName="grid" EnableRowsCache="False" Theme="SoftOrange">
                    <SettingsPager NumericButtonCount="30" PageSize="30">
                    </SettingsPager>
                    <Settings ShowFilterRow="True" />
                    <SettingsLoadingPanel ImagePosition="Top" />
                    <Columns>
                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="2" ShowClearFilterButton="True">
                            <HeaderStyle HorizontalAlign="Center">
                                <Paddings PaddingBottom="1px" PaddingTop="1px" />
                            </HeaderStyle>
                            <HeaderTemplate>
                 				<input type="checkbox" onclick="grid.SelectAllRowsOnPage(this.checked);" style="vertical-align:middle;" title="Seleccione/Deseleccione todas las filas de la pagina"></input>
                            </HeaderTemplate>
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="CENTRO_COSTO" FixedStyle="Left" ReadOnly="True"
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
                <asp:SqlDataSource ID="DS_CENTRO_COSTO_GRID" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="System.Data.SqlClient" SelectCommand="portal.[dbo].[PORTAL_CENTROSCOSTOS_CB2]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCia24" Type="String" />
                        <asp:SessionParameter DefaultValue="" Name="PCentroini" SessionField="PCentroini24" Type="String" />
                        <asp:SessionParameter DefaultValue="" Name="PCentrofin" SessionField="PCentrofin24" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <dx:ASPxGridViewExporter ID="Exportador" runat="server" GridViewID="GPermisos" PrintSelectCheckBox="True">
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


   <dx:ASPxPopupControl ID="Popup" runat="server" AllowDragging="True" ClientInstanceName="Popup" CloseAction="OuterMouseClick" HeaderText="Crear nuevo centro de costo" Modal="true" OnWindowCallback="Popup_WindowCallback" PopupAction="None" PopupElementID="MasterGrid" PopupHorizontalAlign="Center" PopupVerticalAlign="Middle" ShowCloseButton="false">
            <ContentCollection>
                <dx:PopupControlContentControl runat="server">

                    <table style="width: 100%;">
                        <tr>
                            <td class="auto-style2" colspan="3">
                                

                                Abuelo</td>
                            <td class="auto-style1">  


                                Descripción</td>
                        </tr>
                        <tr>
                            <td class="auto-style2" colspan="3">
                                <dx:ASPxComboBox ID="CBListaAbuelo" runat="server" DataSourceID="DS_CentrosCostoLista1" TextField="DESC_CENTRO_COSTO" ValueField="CENTRO_COSTO" OnCallback="CBListaAbuelo_Callback" ClientInstanceName="CBListaAbuelo"  DropDownStyle="DropDown">
                                    <ClientSideEvents TextChanged="onTextChanged" BeginCallback="onBeginCallback" EndCallback="onEndCallback" SelectedIndexChanged="OnSelectedIndexChangedCallback"/>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="auto-style1">
                                <dx:ASPxTextBox ID="tbnombreabuelo" runat="server" Width="170px" ClientInstanceName="tbnombreabuelo">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style3" colspan="3">Padre</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style3" colspan="3">
                                <dx:ASPxComboBox ID="CBListaPadre" runat="server" DataSourceID="DS_CentrosCostoLista2" TextField="DESC_CENTRO_COSTO" ValueField="CENTRO_COSTO" ClientInstanceName="CBListaPadre" OnCallback="CBListaPadre_Callback" DropDownStyle="DropDown">
                                    <ClientSideEvents TextChanged="onTextChangedcbp" BeginCallback="onBeginCallbackcbp" EndCallback="onEndCallbackcbp" SelectedIndexChanged="OnSelectedIndexChangedCallbackcbp"/>
                                </dx:ASPxComboBox>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="tbnombrepadre" runat="server" Width="170px" ClientInstanceName="tbnombrepadre">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style3" colspan="3">Hijo</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style3" colspan="3">
                                <dx:ASPxTextBox ID="tbcentrocostohijo" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="tbnombrehijo" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2" colspan="3"></td>
                            <td class="auto-style1"></td>
                        </tr>
                        <tr>
                            <td class="auto-style2" colspan="3">&nbsp;</td>
                            <td class="auto-style1">
                                <dx:ASPxCheckBox ID="ASPxCheckBox1" runat="server" CheckState="Unchecked" OnCheckedChanged="ASPxCheckBox1_CheckedChanged" Text="Asociar todos los centros?">
                                </dx:ASPxCheckBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2" colspan="3">&nbsp;</td>
                            <td class="auto-style1">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style2">&nbsp; </td>
                            <td class="auto-style4">
                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Aceptar" OnClick="ASPxButton1_Click" AutoPostBack="False">
                                    <ClientSideEvents Click="function(s, e) {
	 PDialogo2.Show();
}" />
                                </dx:ASPxButton>
                            </td>
                            <td class="auto-style1">&nbsp;</td>
                            <td class="auto-style1">
                                <dx:ASPxButton ID="BotonCerrarCc" runat="server" Text="Cancelar" AutoPostBack="False" ClientInstanceName="botonCerrarCC">
                                    <ClientSideEvents Click="function(s, e) {
	Popup.Hide();
}" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
    <br />
                    <div>
                        <dx:ASPxLabel ID="Pmensaje" runat="server">
                        </dx:ASPxLabel>
                        <br />

                     </div>
                    <div>

                        <asp:SqlDataSource ID="DS_CentrosCostoLista1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="System.Data.SqlClient" SelectCommand="portal.[dbo].[PORTAL_CENTROSCOSTOS_CB_LISTA1]" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCia24" Type="String" />
                                <asp:SessionParameter DefaultValue=" " Name="PAdicional" SessionField="PAdicional241" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="DS_CentrosCostoLista2" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="System.Data.SqlClient" SelectCommand="portal.[dbo].[PORTAL_CENTROSCOSTOS_CB_LISTA2]" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCia24" Type="String" />
                                <asp:SessionParameter DefaultValue="059" Name="PAbuelo" SessionField="PAbuelo24" Type="String" />
                                <asp:SessionParameter DefaultValue="022" Name="PAdicional" SessionField="PAdicional242" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </div>
                    <div>
                        <br />
                    </div>
                </dx:PopupControlContentControl>
            </ContentCollection>
        </dx:ASPxPopupControl>

    <dx:ASPxPopupControl ID="PDialogo" runat="server" Height="130px" Width="363px" HeaderText="Confirmación"  ClientInstanceName="PDialogo" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
                    <SettingsAdaptivity VerticalAlign="WindowCenter" />
                    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <table style="width:100%;">
        <tr>
            <td class="auto-style8">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8"></td>
            <td class="auto-style3" colspan="3">
                <dx:ASPxLabel ID="LabelMensaje" runat="server" Font-Bold="True" Text="Esta seguro que desea asociar los centros de costos?" style="margin-left: 7px" Width="300px">
                    <DisabledStyle Font-Bold="True">
                    </DisabledStyle>
                </dx:ASPxLabel>
            </td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
        </tr>
        <tr>
            <td class="auto-style9"></td>
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
            <td class="auto-style8">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
    </table>
                        </dx:PopupControlContentControl>
</ContentCollection>
                </dx:ASPxPopupControl>


    <dx:ASPxPopupControl ID="PDialogo2" runat="server" Height="130px" Width="363px" HeaderText="Confirmación"  ClientInstanceName="PDialogo2" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
                    <SettingsAdaptivity VerticalAlign="WindowCenter" />
                    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <table style="width:100%;">
        <tr>
            <td class="auto-style10">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10"></td>
            <td class="auto-style3" colspan="3">
                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Font-Bold="True" Text="Esta seguro de crear los centros de costos?" style="margin-left: 7px" Width="300px">
                    <DisabledStyle Font-Bold="True">
                    </DisabledStyle>
                </dx:ASPxLabel>
            </td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style10"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
        </tr>
        <tr>
            <td class="auto-style11"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Aceptar" Width="80px" OnClick="ASPxButton2_Click">
                    <Image IconID="businessobjects_bo_validation_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Cancelar">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo2.Hide();
}" />
                    <Image Width="80px" IconID="iconbuilder_actions_delete_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
        </tr>
        <tr>
            <td class="auto-style10">&nbsp;</td>
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
