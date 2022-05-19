<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Compras.aspx.cs" Inherits="UI.Web.Compras" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
         function OnClick(s, e, catCiaCtaID) {
             Popup.Show();
        }
    </script>
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Ordenes de Compras"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="138px" Theme="SoftOrange" Width="60%">
        <Items>
            <dx:LayoutGroup ColCount="5" ColSpan="1" ColumnCount="5" Caption="Defina Parametros" RowSpan="2">
                <Items>
                    <dx:LayoutItem Caption="Fecha Inicial          " ColSpan="1" Name="FechaInicial" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaInicial" runat="server" Date="2020-03-17" Theme="SoftOrange" Width="90px" DisplayFormatString="dd/MM/yyyy">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Fecha Final" ColSpan="1" Name="FechaFinal" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaFinal" runat="server" Date="2020-03-17" Theme="SoftOrange" DisplayFormatString="dd/MM/yyyy" Width="90px">
                                    <DateRangeSettings MaxLength="10" />
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="CB_Tipo_Reporte">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="tiporep" runat="server" SelectedIndex="0" Theme="SoftOrange" Width="133px" Height="19px">
                                    <Items>
                                        <dx:ListEditItem Selected="True" Text="Planeada" Value="A" />
                                        <dx:ListEditItem Text="Recibida" Value="R" />
                                        <dx:ListEditItem Text="Transito" Value="E" />
                                        <dx:ListEditItem Text="Cerrada" Value="U" />
                                        <dx:ListEditItem Text="Cancelada" Value="O" />
                                        <dx:ListEditItem Text="Por Aprobar" Value="P" />
                                        <dx:ListEditItem Text="Backorder" Value="I" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="35px" Native="True" OnClick="ASPxFormLayout1_E3_Click" Theme="SoftOrange" Width="37px">
                                    <Image IconID="spreadsheet_refreshallpivottable_svg_32x32">
                                    </Image>
                                    <HoverStyle>
                                        <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" />
                                    </HoverStyle>
                                    <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="40px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="35px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="43px">
                                    <HoverStyle>
                                        <BackgroundImage ImageUrl="~/Imagenes/Excel.jpg" />
                                    </HoverStyle>
                                    <BackgroundImage ImageUrl="~/Imagenes/Excel.jpg" Repeat="NoRepeat" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="Cia" ColSpan="1" Name="CiaOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E3" runat="server" DataSourceID="SQLCompania" TextField="nombre" ValueField="conjunto">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLCompras" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_COMPRAS]" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="%" Name="PCia1" SessionField="ci_scia1" />
            <asp:SessionParameter DefaultValue="20200201" Name="Pfechaini" SessionField="ci_sfec1" />
            <asp:SessionParameter DefaultValue="20200330" Name="Pfechafin" SessionField="ci_sfec2" />
            <asp:SessionParameter DefaultValue="A"  Name="Pestado_orden"  SessionField="ci_stipo"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="select '%' conjunto, ' Todas' nombre
union all
Select conjunto, nombre from erpadmin.conjunto Where conjunto not in ('Install','ERPADMIN','XPRUEBAS')"></asp:SqlDataSource>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQLCompras">
        <Settings ShowFilterRow="True" ShowGroupPanel="True" />
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="CIA" VisibleIndex="1">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ORDEN_COMPRA" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO" VisibleIndex="3">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PROVEEDOR" VisibleIndex="4">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOMBRE" VisibleIndex="5">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="BODEGA" VisibleIndex="6">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CONDICION_PAGO" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONEDA" VisibleIndex="8">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PAIS" VisibleIndex="9">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RESPON_SEGUIMIENTO" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MODULO_ORIGEN" VisibleIndex="11">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA" VisibleIndex="12">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_COTIZACION" VisibleIndex="13">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_OFRECIDA" VisibleIndex="14">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_EMISION" VisibleIndex="15">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_REQ_EMBARQUE" VisibleIndex="16">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_REQUERIDA" VisibleIndex="17">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="DIRECCION_EMBARQUE" VisibleIndex="18">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DIRECCION_COBRO" VisibleIndex="19">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_DESCUENTO" VisibleIndex="20">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PORC_DESCUENTO" VisibleIndex="21">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_DESCUENTO" VisibleIndex="22">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOTAL_MERCADERIA" VisibleIndex="23">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOTAL_IMPUESTO1" VisibleIndex="24">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOTAL_IMPUESTO2" VisibleIndex="25">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_FLETE" VisibleIndex="26">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_SEGURO" VisibleIndex="27">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_DOCUMENTACIO" VisibleIndex="28">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_ANTICIPO" VisibleIndex="29">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOTAL_A_COMPRAR" VisibleIndex="30">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RUBRO1" VisibleIndex="31">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RUBRO2" VisibleIndex="32">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RUBRO3" VisibleIndex="33">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RUBRO4" VisibleIndex="34">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RUBRO5" VisibleIndex="35">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PRIORIDAD" VisibleIndex="36">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ESTADO" VisibleIndex="37">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="IMPRESA" VisibleIndex="38">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NUM_FORMULARIO" VisibleIndex="39">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="INSTRUCCIONES" VisibleIndex="40">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COMENTARIO_CXP" VisibleIndex="41">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_HORA" VisibleIndex="42">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="OBSERVACIONES" VisibleIndex="43">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="REQUIERE_CONFIRMA" VisibleIndex="44">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="CONFIRMADA" VisibleIndex="45">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_CONFIRMA" VisibleIndex="46">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_HORA_CONFIR" VisibleIndex="47">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_CIERRE" VisibleIndex="48">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_HORA_CIERRE" VisibleIndex="49">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="ASIENTO_CIERRE" VisibleIndex="50">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ORDEN_PROGRAMADA" VisibleIndex="51">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="RECIBIDO_DE_MAS" VisibleIndex="52">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_HORA_CANCELA" VisibleIndex="53">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_CANCELA" VisibleIndex="54">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TIPO_PRORRATEO_OC" VisibleIndex="55">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="PRESUPUESTO_CR" VisibleIndex="56">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COD_DIREC_EMB" VisibleIndex="57">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="NOTAS_NOAPROBAR" VisibleIndex="58">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="FACTURA" VisibleIndex="59">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_FACTURA" VisibleIndex="60">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="SUBTIPO" VisibleIndex="61">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_RIGE" VisibleIndex="62">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="APLICACION" VisibleIndex="63">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="MONTO_FACTURA" VisibleIndex="64">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DEPARTAMENTO" VisibleIndex="65">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_ULT_NOTIF" VisibleIndex="66">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="BASE_IMPUESTO1" VisibleIndex="67">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="BASE_IMPUESTO2" VisibleIndex="68">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOT_IMP1_ASUM_DESC" VisibleIndex="69">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOT_IMP1_ASUM_NODESC" VisibleIndex="70">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOT_IMP1_RETE_DESC" VisibleIndex="71">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="TOT_IMP1_RETE_NODESC" VisibleIndex="72">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="FECHA_NO_APRUEBA" VisibleIndex="73">
            </dx:GridViewDataDateColumn>
            <dx:GridViewDataTextColumn FieldName="USUARIO_NO_APRUEBA" VisibleIndex="74">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="U_OCEAM" VisibleIndex="75">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="U_CARTA_ACEPTACION" VisibleIndex="76">
            </dx:GridViewDataTextColumn>
        </Columns>
    </dx:ASPxGridView>



             </asp:Content>
