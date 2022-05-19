<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Asocentroscia.aspx.cs" Inherits="UI.Web.Asocentroscia" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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

       <style type="text/css">
           .auto-style1 {
               width: 48px;
           }
           .auto-style2 {
               width: 440px;
           }
           .auto-style3 {
               height: 14px;
           }
           .auto-style4 {
               width: 42px;
           }
           .auto-style5 {
               height: 14px;
               width: 42px;
           }
           .auto-style6 {
               width: 53px;
           }
           .auto-style7 {
               height: 14px;
               width: 53px;
           }
       </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Copiar Centro de Costos entre compañias"></asp:Label>
    &nbsp;<br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="1124px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="10" ColSpan="1" ColumnCount="10" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Seleccione Compañia Origen" ColSpan="1" Name="CBUsuario" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E4" runat="server" DataSourceID="DS_Companias" EnableTheming="True" TextField="nombre" Theme="SoftOrange" ValueField="conjunto" Width="250px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Seleccione Centro Origen" ColSpan="1" Name="TXCentroIni" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="Lform_E6" runat="server">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Seleccione Compañia Destino" ColSpan="1" Name="CBCiafin" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="CBCiaFinx" runat="server" DataSourceID="DS_Companias" EnableTheming="True" TextField="nombre" Theme="SoftOrange" ValueField="conjunto" Width="250px">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <CaptionSettings Location="Top" />
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Seleccione Centro Final" ColSpan="1" Name="TXCentroFin" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxTextBox ID="Lform_E5" runat="server">
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
                    <dx:EmptyLayoutItem ColSpan="1">
                    </dx:EmptyLayoutItem>
                    <dx:EmptyLayoutItem ColSpan="1">
                    </dx:EmptyLayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>

        <table style="width: 496px; height: 192px">
        <tr>
            <td>
                &nbsp;</td>
            <td class="auto-style1">
                &nbsp;</td>
            <td class="auto-style2">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                Centro de Costos Original: &nbsp;&nbsp;&nbsp;
                <asp:SqlDataSource ID="DS_Companias" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="System.Data.SqlClient" SelectCommand='  SELECT distinct P.[CONJUNTO] conjunto, P.[CONJUNTO] + &#039; &#039; + c.nombre nombre
  FROM [erpadmin].[PRIVILEGIO_EX] P, erpadmin.conjunto C
  where (P.usuario = @PUsuarioCia or (&#039;PortalRep&#039; = REPLACE(@PUsuarioCia, CHAR(10), &#039;&#039;))) and P.[ACTIVO] = &#039;S&#039; and P.conjunto = c.conjunto
order by 2'>
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="PortalRep" Name="PUsuarioCia" SessionField="PUsuarioCia24" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="DS_CentrosCosto" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="System.Data.SqlClient" SelectCommand='portal.[dbo].[PORTAL_CENTROSCOSTOS_CB]' SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="PCia24" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="auto-style1">
            </td>
            <td class="auto-style2">
                Centro de Costos Destino: &nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
            <td>
                <dx:ASPxGridView ID="GPCentrosCia" runat="server" AutoGenerateColumns="False" DataSourceID="DS_CENTRO_COSTO_GRID" 
                    Width="376px" ClientInstanceName="grid" EnableRowsCache="False" Theme="SoftOrange">
                    <SettingsPager NumericButtonCount="30" PageSize="30">
                    </SettingsPager>
                    <Settings ShowFilterRow="True" />
                    <SettingsLoadingPanel ImagePosition="Top" />
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="CENTRO_COSTO"
                            VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DESCRIPCION" VisibleIndex="1">
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
            </td>
            <td class="auto-style1">
            </td>
            <td class="auto-style2">
                <dx:ASPxGridView ID="GCentro_New" runat="server" AutoGenerateColumns="False" DataSourceID="DS_CENTRO_COSTO_GRID_show" 
                    Width="376px" ClientInstanceName="grid" EnableRowsCache="False" Theme="SoftOrange">
                    <SettingsPager NumericButtonCount="30" PageSize="30">
                    </SettingsPager>
                    <Settings ShowFilterRow="True" />
                    <SettingsLoadingPanel ImagePosition="Top" />
                    <Columns>
                        <dx:GridViewDataTextColumn FieldName="CENTRO_COSTO"
                            VisibleIndex="0">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="DESCRIPCION" VisibleIndex="1">
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
            </td>
        </tr>
        <tr>
            <td>
                        <dx:ASPxLabel runat="server" ID="Pmensaje"></dx:ASPxLabel>

            </td>
            <td class="auto-style1">
                &nbsp;</td>
            <td class="auto-style2">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="DS_CENTRO_COSTO_GRID" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="System.Data.SqlClient" SelectCommand="portal.[dbo].[PORTAL_CENTROSCOSTOS_CB2]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCia24" Type="String" />
                        <asp:SessionParameter DefaultValue="" Name="PCentroini" SessionField="PCentroini24" Type="String" />
                        <asp:SessionParameter DefaultValue="" Name="PCentrofin" SessionField="PCentrofin24" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <dx:ASPxGridViewExporter ID="Exportador" runat="server">
                </dx:ASPxGridViewExporter>
                <br />
                <br />
                
                <br />
            </td>
            <td class="auto-style1">
            </td>
            <td class="auto-style2">
                <asp:SqlDataSource ID="DS_CENTRO_COSTO_GRID_show" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>"
                    ProviderName="System.Data.SqlClient" SelectCommand="portal.[dbo].[PORTAL_CENTROSCOSTOS_CB_COPIA_SH]" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="CROMSA" Name="PCia1" SessionField="CBCia24" Type="String" />
                        <asp:SessionParameter DefaultValue="034" Name="PCentroini" SessionField="PCentroini24" Type="String" />
                        <asp:SessionParameter DefaultValue="" Name="PCiafin" SessionField="CBCiades24" Type="String" />
                        <asp:SessionParameter DefaultValue="802" Name="PCentrofin" SessionField="PCentrodes24" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>

    <dx:ASPxPopupControl ID="PDialogo" runat="server" Height="130px" Width="413px" HeaderText="Confirmación"  ClientInstanceName="PDialogo" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
                    <SettingsAdaptivity VerticalAlign="WindowCenter" />
                    <ContentCollection>
<dx:PopupControlContentControl runat="server">
    <table style="width:100%;">
        <tr>
            <td class="auto-style6">&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7"></td>
            <td class="auto-style3" colspan="3">
                <dx:ASPxLabel ID="LabelMensaje" runat="server" Font-Bold="True" Text="Esta seguro que desea copiar los centros de costos?">
                    <DisabledStyle Font-Bold="True">
                    </DisabledStyle>
                </dx:ASPxLabel>
            </td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style7"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
        </tr>
        <tr>
            <td class="auto-style6">&nbsp;</td>
            <td>
                <dx:ASPxButton ID="BTAceptar" runat="server" OnClick="BTAceptar_Click" Text="Aceptar" Width="80px">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo.Hide();
}" />
                    <Image IconID="businessobjects_bo_validation_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td>&nbsp;</td>
            <td>
                <dx:ASPxButton ID="BTCancelar" runat="server" Text="Cancelar">
                    <ClientSideEvents Click="function(s, e) {
	PDialogo.Hide();
}" />
                    <Image Width="80px" IconID="iconbuilder_actions_delete_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style6">&nbsp;</td>
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
