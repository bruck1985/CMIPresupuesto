<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Iva_Resumen.aspx.cs" Inherits="UI.Web.Iva_Resumen" %>
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
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Resumen IVA"></asp:Label>
    <br />
    <br />
    <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="Select conjunto, nombre from erpadmin.conjunto Where conjunto not in ('Install','ERPADMIN','XPRUEBAS')"></asp:SqlDataSource>
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="73px" Theme="SoftOrange" Width="880px" ColCount="2" ColumnCount="2">
        <Items>
            <dx:LayoutGroup ColCount="6" ColSpan="1" ColumnCount="6" Caption="Defina Parametros" RowSpan="2" Height="40px">
                <Items>
                    <dx:LayoutItem Caption="Cia Origen" ColSpan="1" Name="CiaOrigen" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="CiaOri" runat="server" Theme="SoftOrange" Width="203px" DataSourceID="SQLCompania" TextField="nombre" ValueField="conjunto">
                                </dx:ASPxComboBox>
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
                    <dx:LayoutItem Caption="" ColSpan="1" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_Click" Theme="SoftOrange" Width="32px">
                                 <BackgroundImage ImageUrl="~/Imagenes/BotonActualizar.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />                               

                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="Excel" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E1" runat="server" Height="32px" Native="True" OnClick="ASPxFormLayout1_E3_ClickExc" Theme="SoftOrange" Width="32px">
                                      <BackgroundImage ImageUrl="~/Imagenes/Excel.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                    <dx:EmptyLayoutItem ColSpan="1">
                    </dx:EmptyLayoutItem>

                </Items>
            </dx:LayoutGroup>
            <dx:LayoutGroup Caption="Detalle" ColCount="3" ColSpan="1" ColumnCount="3" Height="40px">
                <Items>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="DetalleVentas" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxButtonVentas" runat="server" Height="32px" Native="True" Theme="SoftOrange" ToolTip="Ventas" Width="32px">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/BO_Sale_32x32.png" Repeat="NoRepeat" VerticalPosition="center" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="DetalleCompras2" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxButtonCompras2" runat="server" Height="32px" Native="True" Theme="SoftOrange" ToolTip="Compras" Width="32px" OnClick="ASPxButtonCompras2_Click">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/ColumnsThree_32x32.png" Repeat="NoRepeat" VerticalPosition="center" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Excel.jpg">
                        </TabImage>
                    </dx:LayoutItem>
                    <dx:LayoutItem Caption="" ColSpan="1" Name="DetalleServicios" Width="32px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="ASPxButtonServ" runat="server" Height="32px" Native="True" Theme="SoftOrange" ToolTip="Inversiones" Width="32px">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/Navigation_Item_Dashboard_32x32.png" Repeat="NoRepeat" VerticalPosition="center" />
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
    <asp:SqlDataSource ID="SDS_RESUMEN_IVA" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT ID, CIA, PERIODO, VENTAS_SUJETAS, VENTA_BIENES_1, VENTA_BIENES_2, VENTA_BIENES_4, VENTA_BIENES_8, VENTA_BIENES_13, DETALLE_BIENES, DETALLE_BIENES_CAPITAL, DETALLE_SERVICIOS, DETALLE_CONSUMO_PERSONAL, DETALLE_TRANSFERENCIAS, OTROS_RUBROS_TOTAL, OTROS_RUBROS_13, OTROS_RUBROS_8, OTROS_RUBROS_4, OTROS_RUBROS_2, OTROS_RUBROS_1, OTROS_RUBROS_RECAUD_13, OTROS_RUBROS_RECAUD_8, OTROS_RUBROS_RECAUD_4, OTROS_RUBROS_RECAUD_2, OTROS_RUBROS_RECAUD_1, OTROS_RUBROS_DEV_PROV_13, OTROS_RUBROS_DEV_PROV_8, OTROS_RUBROS_DEV_PROV_4, OTROS_RUBROS_DEV_PROV_2, OTROS_RUBROS_DEV_PROV_1, OTROS_RUBROS_SER_EXTERIOR_13, OTROS_RUBROS_SER_EXTERIOR_8, OTROS_RUBROS_SER_EXTERIOR_4, OTROS_RUBROS_SER_EXTERIOR_2, OTROS_RUBROS_SER_EXTERIOR_1, VENTAS_EXENTAS_TOTAL, VENTAS_EXENTAS_BIENES, VENTAS_EXENTAS_SERVICIOS, VENTAS_EXENTAS_LOCALES, VENTAS_EXENTAS_SER_LOC, VENTAS_NO_SUJETAS_TOTAL, VENTAS_NO_SUJETAS_CCSS, VENTAS_NO_SUJETAS_MUNIC, VENTAS_NO_SUJETAS_OTRAS, TOTAL_COMPRAS_, COMPRAS_CON_DERECHO_FISCAL, COMPRAS_LOC_SUJETAS_NO_EXENTAS, COMP_DET_BIENES_13, COMP_DET_BIENES_8, COMP_DET_BIENES_4, COMP_DET_BIENES_2, COMP_DET_BIENES_1, COMP_DET_CAPITAL_13, COMP_DET_CAPITAL_8, COMP_DET_CAPITAL_4, COMP_DET_CAPITAL_2, COMP_DET_CAPITAL_1, COMP_DET_SERVICIO_13, COMP_DET_SERVICIO_8, COMP_DET_SERVICIO_4, COMP_DET_SERVICIO_2, COMP_DET_SERVICIO_1, COMP_IMP_SUJETAS_NO_EXENTAS, COMP_IMP_BIENES_13, COMP_IMP_BIENES_8, COMP_IMP_BIENES_4, COMP_IMP_BIENES_2, COMP_IMP_BIENES_1, COMP_IMP_CAPITAL_13, COMP_IMP_CAPITAL_8, COMP_IMP_CAPITAL_4, COMP_IMP_CAPITAL_2, COMP_IMP_CAPITAL_1, COMP_IMP_SERVICIO_13, COMP_IMP_SERVICIO_8, COMP_IMP_SERVICIO_4, COMP_IMP_SERVICIO_2, COMP_IMP_SERVICIO_1, COMP_SIN_DERECHO_CF, COMP_SDF_BIE_SER_EXENTOS, COMP_SDF_BIE_SER_EXENTOS_LOC, COMP_SDF_BIE_SER_EXENTOS_IMP, COMP_SDF_BIE_SER_NO_SUJ, COMP_SDF_BIE_SER_NO_SUJ_LOC, COMP_SDF_BIE_SER_NO_SUJ_IMP, COMP_SDF_BIE_SER_NO_REL, COMP_SDF_BIE_SER_NO_REL_LOC, COMP_SDF_BIE_SER_NO_REL_IMP, COMP_SDF_BIE_SER_NO_REL_AUTO, COMP_SDF_BIE_SER_NO_REL_AUTO_DGH, COMP_SDF_BIE_SER_NO_REL_AUTO_DGT, COMP_SDF_BIE_SER_NO_REL_AUTO_ESP, IMPUESTO_VEN_TRAN_SUJETAS, IMPUESTO_VEN_TRAN_SUJETAS_13, IMPUESTO_VEN_TRAN_SUJETAS_8, IMPUESTO_VEN_TRAN_SUJETAS_4, IMPUESTO_VEN_TRAN_SUJETAS_2, IMPUESTO_VEN_TRAN_SUJETAS_1, COMP_CRED_FISC, COMP_CRED_APLIC, COMP_CRED_BIENES_13, COMP_CRED_BIENES_8, COMP_CRED_BIENES_4, COMP_CRED_BIENES_2, COMP_CRED_BIENES_1, COMP_CRED_BIENES_CAP_13, COMP_CRED_BIENES_CAP_8, COMP_CRED_BIENES_CAP_4, COMP_CRED_BIENES_CAP_2, COMP_CRED_BIENES_CAP_1, COMP_CRED_BIENES_NAC_13, COMP_CRED_BIENES_NAC_8, COMP_CRED_BIENES_NAC_4, COMP_CRED_BIENES_NAC_2, COMP_CRED_BIENES_NAC_1, COMP_CRED_BIENES_IMP_13, COMP_CRED_BIENES_IMP_8, COMP_CRED_BIENES_IMP_4, COMP_CRED_BIENES_IMP_2, COMP_CRED_BIENES_IMP_1, COMP_CRED_BIENES_SER_13, COMP_CRED_BIENES_SER_8, COMP_CRED_BIENES_SER_4, COMP_CRED_BIENES_SER_2, COMP_CRED_BIENES_SER_1, COMP_CRED_BIENES_DEV_13, COMP_CRED_BIENES_DEV_8, COMP_CRED_BIENES_DEV_4, COMP_CRED_BIENES_DEV_2, COMP_CRED_BIENES_DEV_1, DET_IMP_GEN_OPE_GRA, DET_TOTAL_CRED_PER, DET_DEV_IVA_SERV_SALUD, DET_SALDO_A_FAVOR, DET_IMP_NETO_PER, DET_SALDO_A_FAVOR_FINAL, DET_IMP_FINAL
FROM PORTAL.[dbo].[IVA_DOC_ELECT]
--WHERE cIA = @PCIA AND PERIODO = @PPERIODO" >
        <SelectParameters>
            <asp:SessionParameter DefaultValue="CROMSA" Name="PCIA" SessionField="ri_scia1" />
            <asp:SessionParameter DefaultValue="202004" Name="PPERIODO" SessionField="ri_per" />
        </SelectParameters>
    </asp:SqlDataSource>


        <dx:ASPxFormLayout ID="LY_IVA" runat="server" Width="600px" DataSourceID="SDS_RESUMEN_IVA" ColCount="10" ColumnCount="10" AlignItemCaptionsInAllGroups="True" UseDefaultPaddings="False" style="margin-right: 165px">
            <Items>
                <dx:LayoutItem ColSpan="1" FieldName="ID" Visible="False">
                    <LayoutItemNestedControlCollection>
                        <dx:LayoutItemNestedControlContainer runat="server">
                            <dx:ASPxSpinEdit ID="LY_IVA_E1" runat="server" Number="0">
                            </dx:ASPxSpinEdit>
                        </dx:LayoutItemNestedControlContainer>
                    </LayoutItemNestedControlCollection>
                </dx:LayoutItem>
                <dx:LayoutItem ColSpan="1" FieldName="CIA" Visible="False">
                    <LayoutItemNestedControlCollection>
                        <dx:LayoutItemNestedControlContainer runat="server">
                            <dx:ASPxTextBox ID="LY_IVA_E2" runat="server" Width="170px">
                            </dx:ASPxTextBox>
                        </dx:LayoutItemNestedControlContainer>
                    </LayoutItemNestedControlCollection>
                </dx:LayoutItem>
                <dx:LayoutItem ColSpan="1" FieldName="PERIODO" Visible="False">
                    <LayoutItemNestedControlCollection>
                        <dx:LayoutItemNestedControlContainer runat="server">
                            <dx:ASPxSpinEdit ID="LY_IVA_E3" runat="server" Number="0">
                            </dx:ASPxSpinEdit>
                        </dx:LayoutItemNestedControlContainer>
                    </LayoutItemNestedControlCollection>
                </dx:LayoutItem>
                <dx:LayoutGroup Caption="Ventas" ColCount="10" ColSpan="10" ColumnCount="10" ColumnSpan="10"  GroupBoxDecoration="HeadingLine" UseDefaultPaddings="false" Width="900px">
                    <Items>
                                <dx:LayoutItem ColSpan="3" ShowCaption ="False" ColumnSpan="3" HorizontalAlign="Left">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="ASPxLabelventas" runat="server" Text="Ventas Sujetas (Base Imponible)">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="7" ColumnSpan="7" FieldName="VENTAS_SUJETAS" ShowCaption ="False" HorizontalAlign="Left">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E4" runat="server" Number="0" Width="120px" HorizontalAlign="Right" DecimalPlaces="2" DisplayFormatString="#,###.00">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" ShowCaption ="False" ColumnSpan="3" HorizontalAlign="Left">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="Venta de Bienes y Servicios Afectos al 1%">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="7" ColumnSpan="7" FieldName="VENTA_BIENES_1"  ShowCaption ="False" Caption="Venta de Bienes y Servicios Afectos al 1%" HorizontalAlign="Left">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E5" runat="server" Number="0" Width="120px" HorizontalAlign="Right" DisplayFormatString="#,###.00">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" ShowCaption ="False" ColumnSpan="3" HorizontalAlign="Left">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="ASPxLabel14" runat="server" Text="Venta de Bienes y Servicios Afectos al 2%">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="7" ColumnSpan="7" FieldName="VENTA_BIENES_2" ShowCaption="False" HorizontalAlign="Left" >
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E6" runat="server" Number="0" Width="120px" HorizontalAlign="Right" DisplayFormatString="#,###.00">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" ShowCaption ="False" ColumnSpan="3" HorizontalAlign="Left">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="ASPxLabel15" runat="server" Text="Venta de Bienes y Servicios Afectos al 4%">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="7" ColumnSpan="7" FieldName="VENTA_BIENES_4"  Showcaption ="False" HorizontalAlign="Left"> 
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E7" runat="server" Number="0" Width="120px" HorizontalAlign="Right" DisplayFormatString="#,###.00">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" ShowCaption ="False" ColumnSpan="3" HorizontalAlign="Left">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="ASPxLabel16" runat="server" Text="Venta de Bienes y Servicios Afectos al 8%">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="7" ColumnSpan="7" FieldName="VENTA_BIENES_8"  showcaption ="False" HorizontalAlign="Left">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E8" runat="server" Number="0" Width="120px" HorizontalAlign="Right" DisplayFormatString="#,###.00">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="3" ShowCaption ="False" ColumnSpan="3" HorizontalAlign="Left">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="ASPxLabel17" runat="server" Text="Venta de Bienes y Servicios Afectos al 13%">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="7" ColumnSpan="7" FieldName="VENTA_BIENES_13"  ShowCaption ="False" HorizontalAlign="Left">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E9" runat="server" Number="0" Width="120px" HorizontalAlign="Right" DisplayFormatString="#,###.00">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:EmptyLayoutItem ColSpan="5" ColumnSpan="5">
                        </dx:EmptyLayoutItem>
                        <dx:EmptyLayoutItem ColSpan="5" ColumnSpan="5">
                        </dx:EmptyLayoutItem>
                        <dx:LayoutGroup Caption="Detalle" ColSpan="10" ColumnSpan="10" HorizontalAlign="Left" Width="800px">
                            <Items>
                                <dx:LayoutItem ColSpan="1" FieldName="DETALLE_BIENES"  Caption="Bienes" HorizontalAlign="Right">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E10" runat="server" Number="0" DisplayFormatString="#,###.00">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionSettings HorizontalAlign="Left" Location="Left" />
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="DETALLE_BIENES_CAPITAL" Caption="Bienes de Capital" HorizontalAlign="Right">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E11" runat="server" Number="0" DisplayFormatString="#,###.00">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionSettings HorizontalAlign="Left" Location="Left" />
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="DETALLE_SERVICIOS" Caption="Servicios" HorizontalAlign="Right">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E12" runat="server" Number="0" DisplayFormatString="#,###.00">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionSettings HorizontalAlign="Left" />
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="DETALLE_CONSUMO_PERSONAL"  Caption="Uso o Consumo Personal de Mercancias y Servicios" HorizontalAlign="Right">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E13" runat="server" Number="0" DisplayFormatString="#,###.00">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionSettings HorizontalAlign="Left" />
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="DETALLE_TRANSFERENCIAS" Caption ="Transferencias sin Contraprestacion de Terceros" HorizontalAlign="Right">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E14" runat="server" Number="0" DisplayFormatString="#,###.00">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                    <CaptionSettings HorizontalAlign="Left" />
                                </dx:LayoutItem>
                            </Items>
                            <SettingsItemCaptions AllowWrapCaption="False" HorizontalAlign="Left" />
                            <SettingsItems HorizontalAlign="Right" />
                        </dx:LayoutGroup>
                        <dx:LayoutGroup Caption="Otros Rubos a Incluir en la Base Imponible" ColCount="7" ColSpan="10" ColumnCount="7" ColumnSpan="10" HorizontalAlign="Left">
                            <Items>
                                <dx:EmptyLayoutItem ColSpan="6" ColumnSpan="6">
                                </dx:EmptyLayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_TOTAL" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E15" runat="server" Number="0" HorizontalAlign="Right" DisplayFormatString="#,###.00">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:EmptyLayoutItem ColSpan="2" ColumnSpan="2">
                                </dx:EmptyLayoutItem>
                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="LY_IVA_E138" runat="server" Text="13%">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="LY_IVA_E139" runat="server" Text="8%">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="LY_IVA_E140" runat="server" Text="4%">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="LY_IVA_E141" runat="server" Text="2%">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="LY_IVA_E142" runat="server" Text="1%">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:EmptyLayoutItem ColSpan="2" ColumnSpan="2">
                                </dx:EmptyLayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_13" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E16" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_8" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E17" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_4" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E18" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_2" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E19" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_1" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E20" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Showcaption ="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="LY_IVA_E143" runat="server" Showcaption ="False" Text ="Incrementos en la Base Imponible por recaudacion a nivel mayorista, importador y fabricante" Width="288px">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_RECAUD_13" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E21" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem> 
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_RECAUD_8" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E22" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_RECAUD_4" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E23" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_RECAUD_2" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E24" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_RECAUD_1" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E25" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption ="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="LY_IVA_E144" runat="server" Text="Devoluciones a Proveedores">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_DEV_PROV_13" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E26" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_DEV_PROV_8" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E27" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_DEV_PROV_4" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E28" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_DEV_PROV_2" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E29" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_DEV_PROV_1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E30" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption ="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="LY_IVA_E145" runat="server" Text="Servicios Adquiridos desde el Exterior">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_SER_EXTERIOR_13" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E31" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_SER_EXTERIOR_8" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E32" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_SER_EXTERIOR_4" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E33" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_SER_EXTERIOR_2" ShowCaption="False" >
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E34" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="OTROS_RUBROS_SER_EXTERIOR_1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E35" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                        <dx:LayoutGroup Caption="Ventas Exentas (art 8)" ColCount="3" ColSpan="10" ColumnCount="3" ColumnSpan="10" HorizontalAlign="Left">
                            <Items>
                                <dx:EmptyLayoutItem ColSpan="2" ColumnSpan="2">
                                </dx:EmptyLayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="VENTAS_EXENTAS_TOTAL" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E36" runat="server" Number="0">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption ="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="LY_IVA_E146" runat="server" Text="Exportacion de Bienes">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="VENTAS_EXENTAS_BIENES" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E37" runat="server" Number="0">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                 <dx:LayoutItem ShowCaption ="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="ASPxLabel37" runat="server" Text="Exportacion de Servicios">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem ColSpan="1" FieldName="VENTAS_EXENTAS_SERVICIOS" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E38" runat="server" Number="0">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption ="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="ASPxLabelE38" runat="server" Text="Venta Local de Bienes">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem ColSpan="1" FieldName="VENTAS_EXENTAS_LOCALES" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E39" runat="server" Number="0">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ShowCaption ="False" ColSpan="2" ColumnSpan="2">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxLabel ID="ASPxLabelE39" runat="server" Text="Servicios Prestados a Nivel Local">
                                            </dx:ASPxLabel>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>

                                <dx:LayoutItem ColSpan="1" FieldName="VENTAS_EXENTAS_SER_LOC" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E40" runat="server" Number="0">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                        <dx:LayoutGroup ColSpan="1" HorizontalAlign="Left">
                            <Items>
                                <dx:LayoutItem ColSpan="1" FieldName="VENTAS_NO_SUJETAS_TOTAL">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <div class="text-right">
                                                <dx:ASPxSpinEdit ID="LY_IVA_E41" runat="server" Number="0">
                                                </dx:ASPxSpinEdit>
                                            </div>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="VENTAS_NO_SUJETAS_CCSS">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <div class="text-right">
                                                <dx:ASPxSpinEdit ID="LY_IVA_E42" runat="server" Number="0">
                                                </dx:ASPxSpinEdit>
                                            </div>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="VENTAS_NO_SUJETAS_MUNIC">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <div class="text-right">
                                                <dx:ASPxSpinEdit ID="LY_IVA_E43" runat="server" Number="0">
                                                </dx:ASPxSpinEdit>
                                            </div>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="VENTAS_NO_SUJETAS_OTRAS">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <div class="text-right">
                                                <dx:ASPxSpinEdit ID="LY_IVA_E44" runat="server" Number="0">
                                                </dx:ASPxSpinEdit>
                                            </div>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                    </Items>
                </dx:LayoutGroup>
                <dx:LayoutGroup Caption="Compras del Periodo" ColSpan="1" Width="900px">
                    <Items>
                        <dx:LayoutItem ColSpan="1" FieldName="TOTAL_COMPRAS_">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E45" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMPRAS_CON_DERECHO_FISCAL">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E46" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMPRAS_LOC_SUJETAS_NO_EXENTAS">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E47" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutGroup ColCount="6" ColSpan="1" ColumnCount="6">
                            <Items>
                                <dx:LayoutItem Caption="Bienes" ColSpan="2" ColumnSpan="2" FieldName="COMP_DET_BIENES_13">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E48" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_DET_BIENES_8" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E49" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_DET_BIENES_4" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E50" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_DET_BIENES_2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E51" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_DET_BIENES_1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E52" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Bienes de Capital" ColSpan="2" ColumnSpan="2" FieldName="COMP_DET_CAPITAL_13">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E53" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_DET_CAPITAL_8" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E54" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_DET_CAPITAL_4" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E55" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_DET_CAPITAL_2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E56" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_DET_CAPITAL_1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E57" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Servicios" ColSpan="2" ColumnSpan="2" FieldName="COMP_DET_SERVICIO_13">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E58" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_DET_SERVICIO_8" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E59" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_DET_SERVICIO_4" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E60" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_DET_SERVICIO_2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E61" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_DET_SERVICIO_1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E62" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_SUJETAS_NO_EXENTAS" Caption="Imp de Bienes y Adq. de Serv exterior en Ope Sujetas y No Exentas">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E63" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutGroup ColCount="6" ColSpan="1" ColumnCount="6">
                            <Items>
                                <dx:LayoutItem Caption="Bienes" ColSpan="2" ColumnSpan="2" FieldName="COMP_IMP_BIENES_13">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E64" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_BIENES_8" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E65" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_BIENES_4" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E66" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_BIENES_2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E67" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_BIENES_1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E68" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Bienes de Capital" ColSpan="2" ColumnSpan="2" FieldName="COMP_IMP_CAPITAL_13">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E69" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_CAPITAL_8" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E70" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_CAPITAL_4" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E71" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_CAPITAL_2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E72" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_CAPITAL_1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E73" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem Caption="Servicios" ColSpan="2" ColumnSpan="2" FieldName="COMP_IMP_SERVICIO_13">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E74" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_SERVICIO_8" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E75" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_SERVICIO_4" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E76" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_SERVICIO_2" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E77" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                                <dx:LayoutItem ColSpan="1" FieldName="COMP_IMP_SERVICIO_1" ShowCaption="False">
                                    <LayoutItemNestedControlCollection>
                                        <dx:LayoutItemNestedControlContainer runat="server">
                                            <dx:ASPxSpinEdit ID="LY_IVA_E78" runat="server" Number="0" Width="70px">
                                            </dx:ASPxSpinEdit>
                                        </dx:LayoutItemNestedControlContainer>
                                    </LayoutItemNestedControlCollection>
                                </dx:LayoutItem>
                            </Items>
                        </dx:LayoutGroup>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SIN_DERECHO_CF">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E79" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_EXENTOS">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E80" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_EXENTOS_LOC">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E81" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_EXENTOS_IMP">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E82" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_NO_SUJ">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E83" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_NO_SUJ_LOC">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E84" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_NO_SUJ_IMP">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E85" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_NO_REL">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E86" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_NO_REL_LOC">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E87" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_NO_REL_IMP">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E88" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_NO_REL_AUTO">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E89" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_NO_REL_AUTO_DGH">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E90" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_NO_REL_AUTO_DGT">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E91" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_SDF_BIE_SER_NO_REL_AUTO_ESP">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E92" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="IMPUESTO_VEN_TRAN_SUJETAS">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E93" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="IMPUESTO_VEN_TRAN_SUJETAS_13">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E94" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="IMPUESTO_VEN_TRAN_SUJETAS_8">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E95" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="IMPUESTO_VEN_TRAN_SUJETAS_4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E96" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="IMPUESTO_VEN_TRAN_SUJETAS_2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E97" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="IMPUESTO_VEN_TRAN_SUJETAS_1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E98" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_FISC">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E99" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_APLIC">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E100" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_13">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E101" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_8">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E102" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E103" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E104" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E105" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_CAP_13">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E106" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_CAP_8">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E107" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_CAP_4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E108" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_CAP_2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E109" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_CAP_1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E110" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_NAC_13">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E111" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_NAC_8">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E112" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_NAC_4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E113" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_NAC_2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E114" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_NAC_1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E115" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_IMP_13">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E116" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_IMP_8">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E117" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_IMP_4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E118" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_IMP_2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E119" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_IMP_1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E120" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_SER_13">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E121" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_SER_8">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E122" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_SER_4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E123" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_SER_2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E124" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_SER_1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E125" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_DEV_13">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E126" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_DEV_8">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E127" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_DEV_4">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E128" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_DEV_2">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E129" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="COMP_CRED_BIENES_DEV_1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E130" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="DET_IMP_GEN_OPE_GRA">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E131" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="DET_TOTAL_CRED_PER">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E132" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="DET_DEV_IVA_SERV_SALUD">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E133" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="DET_SALDO_A_FAVOR">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E134" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="DET_IMP_NETO_PER">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E135" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="DET_SALDO_A_FAVOR_FINAL">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E136" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1" FieldName="DET_IMP_FINAL">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                    <dx:ASPxSpinEdit ID="LY_IVA_E137" runat="server" Number="0">
                                    </dx:ASPxSpinEdit>
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                        <dx:LayoutItem ColSpan="1">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer runat="server">
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                        </dx:LayoutItem>
                    </Items>
                </dx:LayoutGroup>
            </Items>
            <SettingsItemCaptions Location="Left" />
            <SettingsItems HorizontalAlign="Right" />
            <Border BorderStyle="None" />
        </dx:ASPxFormLayout>
        <br />
        <br />
</asp:Content>
