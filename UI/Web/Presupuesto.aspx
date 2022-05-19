<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Presupuesto.aspx.cs" Inherits="UI.Web.Presupuesto" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">


.dxpcLite .dxpc-header,
.dxdpLite .dxpc-header 
{
	color: #404040;
	background-color: #DCDCDC;
	border-bottom: 1px solid #C9C9C9;
	padding: 2px 2px 2px 12px;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">

        var FocusedCellColumnIndex = 0;
        var FocusedCellRowIndex = 0;
        var lastRecordIndex;
        var colCount;
        var firstRecordIndex;

        var lastRecordIndexC;
        var colCountC;
        var firstRecordIndexC;

        var bots;
        var bote;


        var curentEditingIndex;
        var lastCia = null;
        var isCustomCascadingCallback = { "CuentaCombo": false, "CentroCombo": false };

        function CIACombo_SelectedIndexChanged(s, e) {
            lastCia = s.GetValue();
            isCustomCascadingCallback.CuentaCombo = true;
            isCustomCascadingCallback.CentroCombo = true;
            RefreshData(lastCia);
        }

           function OnBatchEditStartEditing(s, e) {
            curentEditingIndex = e.visibleIndex;
            var currentCIA = grid.batchEditApi.GetCellValue(curentEditingIndex, "CIA");
            if (currentCIA != lastCia && e.focusedColumn.fieldName == "CUENTA_CONTABLE" && currentCIA != null) {
                lastCia = currentCIA;
                RefreshData(currentCIA);
               }
            

           if (currentCIA != lastCia && e.focusedColumn.fieldName == "CENTRO_COSTO" && currentCIA != null) {
                lastCia = currentCIA;
                RefreshData(currentCIA);
               }
            }


             function copydata(s, e) {
            curentEditingIndex = e.visibleIndex;
                var PENERO =   s.batchEditApi.GetCellValue(e.visibleIndex, "ENERO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "ENERO") : 0;  
                var PFEBRERO = s.batchEditApi.GetCellValue(e.visibleIndex, "FEBRERO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FEBRERO") : 0;  
                var PMARZO = s.batchEditApi.GetCellValue(e.visibleIndex, "MARZO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "MARZO") : 0;  
                var PABRIL = s.batchEditApi.GetCellValue(e.visibleIndex, "ABRIL") ? s.batchEditApi.GetCellValue(e.visibleIndex, "ABRIL") : 0;  
                var PMAYO = s.batchEditApi.GetCellValue(e.visibleIndex, "MAYO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "MAYO") : 0;  
                var PJUNIO = s.batchEditApi.GetCellValue(e.visibleIndex, "JUNIO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "JUNIO") : 0;  
                var PJULIO = s.batchEditApi.GetCellValue(e.visibleIndex, "JULIO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "JULIO") : 0;  
                var PAGOSTO = s.batchEditApi.GetCellValue(e.visibleIndex, "AGOSTO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "AGOSTO") : 0;  
                var PSEPTIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "SEPTIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "SEPTIEMBRE") : 0;  
                var POCTUBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "OCTUBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "OCTUBRE") : 0;  
                var PNOVIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "NOVIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "NOVIEMBRE") : 0;  
                var PDICIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "DICIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "DICIEMBRE") : 0;   

               s.batchEditApi.SetCellValue(e.visibleIndex, "FEBRERO", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "MARZO", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "ABRIL", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "MAYO", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "JUNIO", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "JULIO", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "AGOSTO", (parseFloat(PENERO) ), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "SEPTIEMBRE", (parseFloat(PENERO)), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "OCTUBRE", (parseFloat(PENERO)), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "NOVIEMBRE", (parseFloat(PENERO)), null, true);  
               s.batchEditApi.SetCellValue(e.visibleIndex, "DICIEMBRE", (parseFloat(PENERO)), null, true);  

        }


        function CuentaCombo_EndCallback(s, e) {
            if (isCustomCascadingCallback.CuentaCombo) {
                if (s.GetItemCount() > 0)
                    grid.batchEditApi.SetCellValue(curentEditingIndex, "CUENTA_CONTABLE", s.GetItem(0).value);
                isCustomCascadingCallback.CuentaCombo = false;
            }
        }
        function CentroCombo_EndCallback(s, e) {
            if (isCustomCascadingCallback.CentroCombo) {
                if (s.GetItemCount() > 0)
                    grid.batchEditApi.SetCellValue(curentEditingIndex, "CENTRO_COSTO", s.GetItem(0).value);
                isCustomCascadingCallback.CentroCombo = false;
            }
        }

        function RefreshData(CIAValue) {
            hf.Set("CurrentCIA", CIAValue);
            CuentaEditor.PerformCallback();
            CentroEditor.PerformCallback();
        }

        function OnBatchEditEndEditing(s, e) {  
            window.setTimeout(function () {  
                var PENERO =   s.batchEditApi.GetCellValue(e.visibleIndex, "ENERO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "ENERO") : 0;  
                var PFEBRERO = s.batchEditApi.GetCellValue(e.visibleIndex, "FEBRERO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FEBRERO") : 0;  
                var PMARZO = s.batchEditApi.GetCellValue(e.visibleIndex, "MARZO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "MARZO") : 0;  
                var PABRIL = s.batchEditApi.GetCellValue(e.visibleIndex, "ABRIL") ? s.batchEditApi.GetCellValue(e.visibleIndex, "ABRIL") : 0;  
                var PMAYO = s.batchEditApi.GetCellValue(e.visibleIndex, "MAYO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "MAYO") : 0;  
                var PJUNIO = s.batchEditApi.GetCellValue(e.visibleIndex, "JUNIO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "JUNIO") : 0;  
                var PJULIO = s.batchEditApi.GetCellValue(e.visibleIndex, "JULIO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "JULIO") : 0;  
                var PAGOSTO = s.batchEditApi.GetCellValue(e.visibleIndex, "AGOSTO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "AGOSTO") : 0;  
                var PSEPTIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "SEPTIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "SEPTIEMBRE") : 0;  
                var POCTUBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "OCTUBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "OCTUBRE") : 0;  
                var PNOVIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "NOVIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "NOVIEMBRE") : 0;  
                var PDICIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "DICIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "DICIEMBRE") : 0;  

                s.batchEditApi.SetCellValue(e.visibleIndex, "Sum", (parseFloat(PENERO) + parseFloat(PFEBRERO) + parseFloat(PMARZO) + parseFloat(PABRIL) + parseFloat(PMAYO) + parseFloat(PJUNIO) + parseFloat(PJULIO) + parseFloat(PAGOSTO) + parseFloat(PSEPTIEMBRE) + parseFloat(POCTUBRE) + parseFloat(PNOVIEMBRE) + parseFloat(PDICIEMBRE)), null, true);  

                var FENERO =   s.batchEditApi.GetCellValue(e.visibleIndex, "FENERO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FENERO") : 0;  
                var FFEBRERO = s.batchEditApi.GetCellValue(e.visibleIndex, "FFEBRERO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FFEBRERO") : 0;  
                var FMARZO = s.batchEditApi.GetCellValue(e.visibleIndex, "FMARZO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FMARZO") : 0;  
                var FABRIL = s.batchEditApi.GetCellValue(e.visibleIndex, "FABRIL") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FABRIL") : 0;  
                var FMAYO = s.batchEditApi.GetCellValue(e.visibleIndex, "FMAYO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FMAYO") : 0;  
                var FJUNIO = s.batchEditApi.GetCellValue(e.visibleIndex, "FJUNIO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FJUNIO") : 0;  
                var FJULIO = s.batchEditApi.GetCellValue(e.visibleIndex, "FJULIO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FJULIO") : 0;  
                var FAGOSTO = s.batchEditApi.GetCellValue(e.visibleIndex, "FAGOSTO") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FAGOSTO") : 0;  
                var FSEPTIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "FSEPTIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FSEPTIEMBRE") : 0;  
                var FOCTUBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "FOCTUBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FOCTUBRE") : 0;  
                var FNOVIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "FNOVIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FNOVIEMBRE") : 0;  
                var FDICIEMBRE = s.batchEditApi.GetCellValue(e.visibleIndex, "FDICIEMBRE") ? s.batchEditApi.GetCellValue(e.visibleIndex, "FDICIEMBRE") : 0;  

                s.batchEditApi.SetCellValue(e.visibleIndex, "SumForecast", (parseFloat(FENERO) + parseFloat(FFEBRERO) + parseFloat(FMARZO) + parseFloat(FABRIL) + parseFloat(FMAYO) + parseFloat(FJUNIO) + parseFloat(FJULIO) + parseFloat(FAGOSTO) + parseFloat(FSEPTIEMBRE) + parseFloat(FOCTUBRE) + parseFloat(FNOVIEMBRE) + parseFloat(FDICIEMBRE)), null, true);  


                
            }, 0);  
          }


    </script>
    <input runat="server" id="ColumnIndex" type="hidden" enableviewstate="true" />
    <input runat="server" id="RowIndex" type="hidden" enableviewstate="true" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" Text="              Reporte Web Presupuesto"></asp:Label>
    <br />
    <br />
    <dx:ASPxFormLayout ID="Lform" runat="server" Height="91px" Theme="SoftOrange" Width="1050px" style="margin-top: 0px">
        <Items>
            <dx:LayoutGroup ColCount="7" ColSpan="1" ColumnCount="7" Caption="Defina Parametros" RowSpan="2">
                <Items>
          <dx:LayoutItem Caption="Seleccione Area"  ColSpan="1" Name="cbarea" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxComboBox ID="Lform_E3" runat="server" Theme="SoftOrange" Width="299px" DataSourceID="SQLArea" TextField="DESCRIPCION" ValueField="AREA">
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                <CaptionSettings Location="Top" />
                    </dx:LayoutItem>



                    <dx:LayoutItem Caption="Seleccione Año" ColSpan="1" Name="cbano">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                  <dx:ASPxComboBox ID="ASPxComboBox2" runat="server" Theme="SoftOrange" DataSourceID="SQLPeriodos" TextField="ano" ValueField="ano">
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
                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E2" runat="server" AutoPostBack="False" Height="32px" Width="32px" ToolTip="Lista de Campos">
                                    <ClientSideEvents Click="function(s, e) {
	PivotCompra.ChangeCustomizationFieldsVisibility(); return false; 
}" />
                                   <BackgroundImage ImageUrl="~/Imagenes/Lista.png" Repeat="NoRepeat" VerticalPosition="center" HorizontalPosition ="center"  />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/Lista.png">
                        </TabImage>
                    </dx:LayoutItem>
                </Items>
            </dx:LayoutGroup>
        </Items>
    </dx:ASPxFormLayout>
    <asp:SqlDataSource ID="SQLPresupuesto" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$;connect timeout=0;" ProviderName="System.Data.SqlClient" SelectCommand="SELECT ID, AREA,COD_PAIS, CIA,  CENTRO_COSTO, DESCRIPCION, CATEGORIA, CUENTA_CONTABLE, 
ANO, ENERO, FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE, FENERO, FFEBRERO, FMARZO, FABRIL, FMAYO, FJUNIO, FJULIO, FAGOSTO, FSEPTIEMBRE, FOCTUBRE, FNOVIEMBRE, FDICIEMBRE, YAGENERO, YAGFEBRERO, YAGMARZO, YAGABRIL, YAGMAYO, YAGJUNIO, YAGJULIO, YAGAGOSTO, YAGSEPTIEMBRE, YAGOCTUBRE, YAGNOVIEMBRE, YAGDICIEMBRE
    FROM [PORTAL].[Presupuesto].[DATA] D
where AREA = @AREA AND ANO=@ANO  and (D.CENTRO_COSTO  in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') and d.cuenta_contable  in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))" InsertCommand="INSERT INTO PORTAL.[Presupuesto].[DATA] (AREA,COD_PAIS, CIA,  CENTRO_COSTO, DESCRIPCION, CATEGORIA, CUENTA_CONTABLE, 
ANO, ENERO, FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE, FENERO, FFEBRERO, FMARZO, FABRIL, FMAYO, FJUNIO, FJULIO, FAGOSTO, FSEPTIEMBRE, FOCTUBRE, FNOVIEMBRE, FDICIEMBRE, YAGENERO, YAGFEBRERO, YAGMARZO, YAGABRIL, YAGMAYO, YAGJUNIO, YAGJULIO, YAGAGOSTO, YAGSEPTIEMBRE, YAGOCTUBRE, YAGNOVIEMBRE, YAGDICIEMBRE)
VALUES (@AREA, @COD_PAIS, @CIA,  @CENTRO_COSTO, @DESCRIPCION, @CATEGORIA, @CUENTA_CONTABLE, 
@ANO, @ENERO, @FEBRERO, @MARZO, @ABRIL, @MAYO, @JUNIO, @JULIO, @AGOSTO, @SEPTIEMBRE, @OCTUBRE, @NOVIEMBRE, @DICIEMBRE, @FENERO, @FFEBRERO, @FMARZO, @FABRIL, @FMAYO, @FJUNIO, @FJULIO, @FAGOSTO, @FSEPTIEMBRE, @FOCTUBRE, @FNOVIEMBRE, @FDICIEMBRE, @YAGENERO, @YAGFEBRERO, @YAGMARZO, @YAGABRIL, @YAGMAYO, @YAGJUNIO, @YAGJULIO, @YAGAGOSTO, @YAGSEPTIEMBRE, @YAGOCTUBRE, @YAGNOVIEMBRE, @YAGDICIEMBRE)" UpdateCommand="UPDATE PORTAL.[Presupuesto].[DATA] 
SET AREA = @AREA, 
COD_PAIS = @COD_PAIS, 
CIA= @CIA,  CENTRO_COSTO = @CENTRO_COSTO, DESCRIPCION = @DESCRIPCION, 
CATEGORIA = @CATEGORIA, CUENTA_CONTABLE = @CUENTA_CONTABLE, 
ANO = @ANO, ENERO = @ENERO, FEBRERO = @FEBRERO, MARZO= @MARZO, ABRIL = @ABRIL, MAYO = @MAYO, 
JUNIO = @JUNIO, JULIO = @JULIO, AGOSTO = @AGOSTO, SEPTIEMBRE = @SEPTIEMBRE, OCTUBRE = @OCTUBRE, NOVIEMBRE = @NOVIEMBRE, DICIEMBRE = @DICIEMBRE, 
FENERO = @FENERO, FFEBRERO = @FFEBRERO, FMARZO = @FMARZO, FABRIL = @FABRIL, FMAYO=@FMAYO, 
FJUNIO=@FJUNIO, FJULIO=@FJULIO, FAGOSTO=@FAGOSTO, FSEPTIEMBRE=@FSEPTIEMBRE, FOCTUBRE=@FOCTUBRE, 
FNOVIEMBRE=@FNOVIEMBRE, FDICIEMBRE=@FDICIEMBRE, 
YAGENERO=@YAGENERO, YAGFEBRERO=@YAGFEBRERO, YAGMARZO=@YAGMARZO, YAGABRIL=@YAGABRIL, YAGMAYO=@YAGMAYO, 
YAGJUNIO=@YAGJUNIO, YAGJULIO=@YAGJULIO, YAGAGOSTO=@YAGAGOSTO, YAGSEPTIEMBRE=@YAGSEPTIEMBRE, YAGOCTUBRE=@YAGOCTUBRE, 
YAGNOVIEMBRE=@YAGNOVIEMBRE, YAGDICIEMBRE=@YAGDICIEMBRE
where ID = @ID" DeleteCommand="delete PORTAL.[Presupuesto].[DATA] 
where ID = @ID" >
        <DeleteParameters>
            <asp:Parameter Name="ID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter DefaultValue="1" Name="AREA" SessionField="PAREA" />
            <asp:Parameter Name="COD_PAIS" />
            <asp:Parameter Name="CIA" />
            <asp:Parameter Name="CENTRO_COSTO" />
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="CATEGORIA" />
            <asp:Parameter Name="CUENTA_CONTABLE" />
            <asp:SessionParameter DefaultValue="2021" Name="ANO" SessionField="PANO" />
            <asp:Parameter Name="ENERO" />
            <asp:Parameter Name="FEBRERO" />
            <asp:Parameter Name="MARZO" />
            <asp:Parameter Name="ABRIL" />
            <asp:Parameter Name="MAYO" />
            <asp:Parameter Name="JUNIO" />
            <asp:Parameter Name="JULIO" />
            <asp:Parameter Name="AGOSTO" />
            <asp:Parameter Name="SEPTIEMBRE" />
            <asp:Parameter Name="OCTUBRE" />
            <asp:Parameter Name="NOVIEMBRE" />
            <asp:Parameter Name="DICIEMBRE" />
            <asp:Parameter Name="FENERO" />
            <asp:Parameter Name="FFEBRERO" />
            <asp:Parameter Name="FMARZO" />
            <asp:Parameter Name="FABRIL" />
            <asp:Parameter Name="FMAYO" />
            <asp:Parameter Name="FJUNIO" />
            <asp:Parameter Name="FJULIO" />
            <asp:Parameter Name="FAGOSTO" />
            <asp:Parameter Name="FSEPTIEMBRE" />
            <asp:Parameter Name="FOCTUBRE" />
            <asp:Parameter Name="FNOVIEMBRE" />
            <asp:Parameter Name="FDICIEMBRE" />
            <asp:Parameter Name="YAGENERO" />
            <asp:Parameter Name="YAGFEBRERO" />
            <asp:Parameter Name="YAGMARZO" />
            <asp:Parameter Name="YAGABRIL" />
            <asp:Parameter Name="YAGMAYO" />
            <asp:Parameter Name="YAGJUNIO" />
            <asp:Parameter Name="YAGJULIO" />
            <asp:Parameter Name="YAGAGOSTO" />
            <asp:Parameter Name="YAGSEPTIEMBRE" />
            <asp:Parameter Name="YAGOCTUBRE" />
            <asp:Parameter Name="YAGNOVIEMBRE" />
            <asp:Parameter Name="YAGDICIEMBRE" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="AREA" SessionField="PAREA" />
            <asp:SessionParameter Name="ANO" SessionField="PANO" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter DefaultValue="1" Name="AREA" SessionField="PAREA" />
            <asp:Parameter Name="COD_PAIS" />
            <asp:Parameter Name="CIA" />
            <asp:Parameter Name="CENTRO_COSTO" />
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="CATEGORIA" />
            <asp:Parameter Name="CUENTA_CONTABLE" />
            <asp:SessionParameter DefaultValue="2021" Name="ANO" SessionField="PANO" />
            <asp:Parameter Name="ENERO" />
            <asp:Parameter Name="FEBRERO" />
            <asp:Parameter Name="MARZO" />
            <asp:Parameter Name="ABRIL" />
            <asp:Parameter Name="MAYO" />
            <asp:Parameter Name="JUNIO" />
            <asp:Parameter Name="JULIO" />
            <asp:Parameter Name="AGOSTO" />
            <asp:Parameter Name="SEPTIEMBRE" />
            <asp:Parameter Name="OCTUBRE" />
            <asp:Parameter Name="NOVIEMBRE" />
            <asp:Parameter Name="DICIEMBRE" />
            <asp:Parameter Name="FENERO" />
            <asp:Parameter Name="FFEBRERO" />
            <asp:Parameter Name="FMARZO" />
            <asp:Parameter Name="FABRIL" />
            <asp:Parameter Name="FMAYO" />
            <asp:Parameter Name="FJUNIO" />
            <asp:Parameter Name="FJULIO" />
            <asp:Parameter Name="FAGOSTO" />
            <asp:Parameter Name="FSEPTIEMBRE" />
            <asp:Parameter Name="FOCTUBRE" />
            <asp:Parameter Name="FNOVIEMBRE" />
            <asp:Parameter Name="FDICIEMBRE" />
            <asp:Parameter Name="YAGENERO" />
            <asp:Parameter Name="YAGFEBRERO" />
            <asp:Parameter Name="YAGMARZO" />
            <asp:Parameter Name="YAGABRIL" />
            <asp:Parameter Name="YAGMAYO" />
            <asp:Parameter Name="YAGJUNIO" />
            <asp:Parameter Name="YAGJULIO" />
            <asp:Parameter Name="YAGAGOSTO" />
            <asp:Parameter Name="YAGSEPTIEMBRE" />
            <asp:Parameter Name="YAGOCTUBRE" />
            <asp:Parameter Name="YAGNOVIEMBRE" />
            <asp:Parameter Name="YAGDICIEMBRE" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <dx:ASPxHiddenField runat="server" ID="hf" ClientInstanceName="hf"></dx:ASPxHiddenField>
    <br />
    <dx:ASPxGridViewExporter ID="grid_data_exp" runat="server" FileName="Presupuesto" GridViewID="ASPxGridView1">
    </dx:ASPxGridViewExporter>
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SQLPresupuesto" KeyFieldName="ID" EnableTheming="True" Theme="SoftOrange" ClientInstanceName="grid" OnCellEditorInitialize="ASPxGridView1_CellEditorInitialize" OnCustomUnboundColumnData="ASPxGridView1_CustomUnboundColumnData">
        <ClientSideEvents BatchEditStartEditing="OnBatchEditStartEditing" BatchEditEndEditing="OnBatchEditEndEditing" CustomButtonClick="function(s, e) { if (e.buttonID == 'btDelete') {bots=s; bote= e; 	PDialogoD.Show() } else { bots=s; bote= e; 	PDialogo.Show()};
   }" />
        <SettingsPager NumericButtonCount="20" PageSize="20">
        </SettingsPager>
        <SettingsEditing Mode="Batch" BatchEditSettings-EditMode="Cell">
             <BatchEditSettings ShowConfirmOnLosingChanges="true" />
        </SettingsEditing>
        <Settings ShowFilterRow="True" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Toolbars>
            <dx:GridViewToolbar>
                <Items>
                    <dx:GridViewToolbarItem Command="New" />
                    <dx:GridViewToolbarItem Command="Edit" />
                    <dx:GridViewToolbarItem Command="Update" DisplayMode="ImageWithText" Text ="Guardar">
                        <Image Url="~/Imagenes/SaveAll.png">
                        </Image>
                        <ItemStyle>
                        <BackgroundImage ImageUrl="SaveAll.png" />
                        </ItemStyle>
                    </dx:GridViewToolbarItem>
                </Items>
            </dx:GridViewToolbar>
        </Toolbars>
        <Columns>
            <dx:GridViewCommandColumn ShowNewButtonInHeader="True" VisibleIndex="0">
                   <CustomButtons>
                        <dx:GridViewCommandColumnCustomButton ID="btDelete" Text="Eliminar" Visibility="AllDataRows">
                        </dx:GridViewCommandColumnCustomButton>
                    </CustomButtons>
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="1" ShowInCustomizationForm="True" Visible="False">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COD_PAIS" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3" ShowInCustomizationForm="True" Visible="False">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7" ShowInCustomizationForm="True">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ANO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9" ShowInCustomizationForm="True" Visible="False">
            </dx:GridViewDataTextColumn>
                <dx:GridViewBandColumn Caption="Presupuesto" VisibleIndex="11">
                    <HeaderStyle HorizontalAlign="Center" BackColor="#336600" />
                    <Columns>
                      <dx:GridViewDataTextColumn FieldName="ENERO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8" ShowInCustomizationForm="True">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FEBRERO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9" ShowInCustomizationForm="True">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="MARZO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10" ShowInCustomizationForm="True">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="ABRIL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11" ShowInCustomizationForm="True">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="MAYO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12" ShowInCustomizationForm="True">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="JUNIO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13" ShowInCustomizationForm="True">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="JULIO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14" ShowInCustomizationForm="True">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="AGOSTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15" ShowInCustomizationForm="True">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="SEPTIEMBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16" ShowInCustomizationForm="True">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="OCTUBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17" ShowInCustomizationForm="True">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="NOVIEMBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="18" ShowInCustomizationForm="True">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="DICIEMBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="19" ShowInCustomizationForm="True">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="TOTAL PRES" FieldName="Sum" LoadReadOnlyValueFromDataModel="True" ReadOnly="True"  UnboundType="Decimal" VisibleIndex="20">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                             <Settings ShowEditorInBatchEditMode="false" />
                            <CellStyle BackColor="#FFFF66">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                     </Columns>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="Forecast" VisibleIndex="12">
                    <HeaderStyle HorizontalAlign="Center" />
                    <Columns>
                      <dx:GridViewDataTextColumn FieldName="FENERO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20" ShowInCustomizationForm="True" Caption ="ENERO">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FFEBRERO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="21" ShowInCustomizationForm="True"  Caption ="FEBRERO">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FMARZO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="22" ShowInCustomizationForm="True"  Caption ="MARZO">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FABRIL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23" ShowInCustomizationForm="True"  Caption ="ABRIL">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FMAYO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="24"  Caption ="MAYO">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FJUNIO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="25"  Caption ="JUNIO">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FJULIO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="26" Caption ="JULIO">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FAGOSTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="27" Caption ="AGOSTO">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FSEPTIEMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="28" Caption ="SEPTIEMBRE">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FOCTUBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="29" Caption ="OCTUBRE">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FNOVIEMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="30" Caption ="NOVIEMBRE">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FDICIEMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="31" Caption ="DICIEMBRE">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="TOTAL FORECAST" FieldName="SumForecast" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" UnboundType="Decimal" VisibleIndex="32">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                           <Settings ShowEditorInBatchEditMode="false" />
                            <CellStyle BackColor="#FFFF66">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                     </Columns>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="Año Anterior" VisibleIndex="13">
                    <HeaderStyle HorizontalAlign="Center" />
                    <Columns>
                      <dx:GridViewDataTextColumn FieldName="YAGENERO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="32" Caption ="ENERO" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGFEBRERO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="33" Caption ="FEBRERO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGMARZO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="34" Caption ="MARZO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGABRIL" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="35" Caption ="ABRIL"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGMAYO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="36" Caption ="MAYO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGJUNIO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="37" Caption ="JUNIO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGJULIO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="38" Caption ="JULIO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGAGOSTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="39" Caption ="AGOSTO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGSEPTIEMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="40" Caption ="SEPTIEMBRE"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGOCTUBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="41" Caption ="OCTUBRE"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGNOVIEMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="42" Caption ="NOVIEMBRE"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGDICIEMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="43" Caption ="DICIEMBRE"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="TOTAL AÑO ANT" FieldName="SumAnt" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" UnboundType="Decimal" VisibleIndex="44">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                           <Settings ShowEditorInBatchEditMode="false" />
                            <CellStyle BackColor="#FFFF66">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                     </Columns>
                </dx:GridViewBandColumn>
            <dx:GridViewDataComboBoxColumn FieldName="AREA" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="2" Visible="False">
                <PropertiesComboBox DataSourceID="SQLArea" TextField="DESCRIPCION" ValueField="AREA">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
           <dx:GridViewDataComboBoxColumn FieldName="CIA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                <PropertiesComboBox EnableCallbackMode="true" DataSourceID="SQLCia" TextField="NOMBRE" ValueField="CONJUNTO" Width="200px">
                    <ValidationSettings RequiredField-IsRequired="true"><RequiredField IsRequired="True"></RequiredField>
                    </ValidationSettings>
                    <ClientSideEvents SelectedIndexChanged="CIACombo_SelectedIndexChanged" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CUENTA_CONTABLE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
                <PropertiesComboBox EnableCallbackMode="true" CallbackPageSize="20" IncrementalFilteringMode="Contains"  TextField="DESCRIPCION" ValueField="CUENTA_CONTABLE"  OnItemRequestedByValue="OnItemRequestedByValue" OnItemsRequestedByFilterCondition="OnItemsRequestedByFilterCondition"  Width="200px">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CENTRO_COSTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
                <PropertiesComboBox EnableCallbackMode="true" CallbackPageSize="20" IncrementalFilteringMode="Contains"  TextField="DESCRIPCION" ValueField="CENTRO_COSTO"   OnItemRequestedByValue="Centro_ItemRequestedByValue" OnItemsRequestedByFilterCondition="Centro_OnItemsRequestedByFilterCondition"  Width="200px">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
          
            <dx:GridViewCommandColumn VisibleIndex="10">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton>
                        <Image IconID="businessobjects_bo_transition_svg_16x16">
                        </Image>
                    </dx:GridViewCommandColumnCustomButton>
                </CustomButtons>
            </dx:GridViewCommandColumn>
          
        </Columns>
    </dx:ASPxGridView>
    <asp:SqlDataSource ID="SQLArea" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [AREA]
      ,[DESCRIPCION]
  FROM [PORTAL].[Presupuesto].[AREA]  A
  where A.AREA IN (SELECT U.AREA FROM  [PORTAL].[Presupuesto].AREA_USUARIO U WHERE A.AREA = U.AREA and  U.USUARIO = @PNOMUSUARIO AND  isnull(SOLO_LECTURA,'N') = 'N')
  order by 2">
        <SelectParameters>
            <asp:SessionParameter Name="PNOMUSUARIO" SessionField="nombreUsuario" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLCuentaContable" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [CUENTA_CONTABLE], [CUENTA_CONTABLE] + ' ' + [DESCRIPCION] DESCRIPCION
  FROM [PORTAL].[Presupuesto].[CUENTA_CONTABLE]
  order by 1">
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SQLPeriodos" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="select ano from portal.[Presupuesto].[PERIODOS] order by 1">
    </asp:SqlDataSource>

        
    <asp:SqlDataSource ID="SQLCia" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [CONJUNTO], [NOMBRE] NOMBRE
  FROM [PORTAL].[Presupuesto].[CIA]
ORDER BY 1">
    </asp:SqlDataSource>

        
    <asp:SqlDataSource ID="SQLPresupuestoNoModificable" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$;connect timeout=0;" ProviderName="System.Data.SqlClient" SelectCommand="SELECT ID, AREA,COD_PAIS, CIA,  CENTRO_COSTO, DESCRIPCION, CATEGORIA, CUENTA_CONTABLE, 
ANO, ENERO, FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE, FENERO, FFEBRERO, FMARZO, FABRIL, FMAYO, FJUNIO, FJULIO, FAGOSTO, FSEPTIEMBRE, FOCTUBRE, FNOVIEMBRE, FDICIEMBRE, YAGENERO, YAGFEBRERO, YAGMARZO, YAGABRIL, YAGMAYO, YAGJUNIO, YAGJULIO, YAGAGOSTO, YAGSEPTIEMBRE, YAGOCTUBRE, YAGNOVIEMBRE, YAGDICIEMBRE
    FROM [PORTAL].[Presupuesto].[DATA] D
where AREA = @AREA AND ANO=@ANO and (D.CENTRO_COSTO not in (select C.centro_costo from [PORTAL].[Presupuesto].[AREA_CENTRO] C, [PORTAL].[Presupuesto].CENTRO_COSTO CC Where D.area = C.area and D.centro_costo = C.centro_costo 
and c.CENTRO_COSTO = cc.CENTRO_COSTO and cc.CIA= d.CIA and cc.ESTADO = 'A') or d.cuenta_contable not in (select C.Cuenta from [PORTAL].[Presupuesto].[AREA_CUENTA] C, [PORTAL].[Presupuesto].CUENTA_CONTABLE CC, [PORTAL].[Presupuesto].CIA CIA Where D.area = C.area and D.cuenta_contable = C.CUENTA AND 
c.CUENTA = cc.CUENTA_CONTABLE AND CC.ERP = CIA.ERP AND D.CIA = CIA.CONJUNTO))" InsertCommand="INSERT INTO PORTAL.[Presupuesto].[DATA] (AREA,COD_PAIS, CIA,  CENTRO_COSTO, DESCRIPCION, CATEGORIA, CUENTA_CONTABLE, 
ANO, ENERO, FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE, FENERO, FFEBRERO, FMARZO, FABRIL, FMAYO, FJUNIO, FJULIO, FAGOSTO, FSEPTIEMBRE, FOCTUBRE, FNOVIEMBRE, FDICIEMBRE, YAGENERO, YAGFEBRERO, YAGMARZO, YAGABRIL, YAGMAYO, YAGJUNIO, YAGJULIO, YAGAGOSTO, YAGSEPTIEMBRE, YAGOCTUBRE, YAGNOVIEMBRE, YAGDICIEMBRE)
VALUES (@AREA, @COD_PAIS, @CIA,  @CENTRO_COSTO, @DESCRIPCION, @CATEGORIA, @CUENTA_CONTABLE, 
@ANO, @ENERO, @FEBRERO, @MARZO, @ABRIL, @MAYO, @JUNIO, @JULIO, @AGOSTO, @SEPTIEMBRE, @OCTUBRE, @NOVIEMBRE, @DICIEMBRE, @FENERO, @FFEBRERO, @FMARZO, @FABRIL, @FMAYO, @FJUNIO, @FJULIO, @FAGOSTO, @FSEPTIEMBRE, @FOCTUBRE, @FNOVIEMBRE, @FDICIEMBRE, @YAGENERO, @YAGFEBRERO, @YAGMARZO, @YAGABRIL, @YAGMAYO, @YAGJUNIO, @YAGJULIO, @YAGAGOSTO, @YAGSEPTIEMBRE, @YAGOCTUBRE, @YAGNOVIEMBRE, @YAGDICIEMBRE)" UpdateCommand="UPDATE PORTAL.[Presupuesto].[DATA] 
SET AREA = @AREA, 
COD_PAIS = @COD_PAIS, 
CIA= @CIA,  CENTRO_COSTO = @CENTRO_COSTO, DESCRIPCION = @DESCRIPCION, 
CATEGORIA = @CATEGORIA, CUENTA_CONTABLE = @CUENTA_CONTABLE, 
ANO = @ANO, ENERO = @ENERO, FEBRERO = @FEBRERO, MARZO= @MARZO, ABRIL = @ABRIL, MAYO = @MAYO, 
JUNIO = @JUNIO, JULIO = @JULIO, AGOSTO = @AGOSTO, SEPTIEMBRE = @SEPTIEMBRE, OCTUBRE = @OCTUBRE, NOVIEMBRE = @NOVIEMBRE, DICIEMBRE = @DICIEMBRE, 
FENERO = @FENERO, FFEBRERO = @FFEBRERO, FMARZO = @FMARZO, FABRIL = @FABRIL, FMAYO=@FMAYO, 
FJUNIO=@FJUNIO, FJULIO=@FJULIO, FAGOSTO=@FAGOSTO, FSEPTIEMBRE=@FSEPTIEMBRE, FOCTUBRE=@FOCTUBRE, 
FNOVIEMBRE=@FNOVIEMBRE, FDICIEMBRE=@FDICIEMBRE, 
YAGENERO=@YAGENERO, YAGFEBRERO=@YAGFEBRERO, YAGMARZO=@YAGMARZO, YAGABRIL=@YAGABRIL, YAGMAYO=@YAGMAYO, 
YAGJUNIO=@YAGJUNIO, YAGJULIO=@YAGJULIO, YAGAGOSTO=@YAGAGOSTO, YAGSEPTIEMBRE=@YAGSEPTIEMBRE, YAGOCTUBRE=@YAGOCTUBRE, 
YAGNOVIEMBRE=@YAGNOVIEMBRE, YAGDICIEMBRE=@YAGDICIEMBRE
where ID = @ID" >
        <InsertParameters>
            <asp:SessionParameter DefaultValue="1" Name="AREA" SessionField="PAREA" />
            <asp:Parameter Name="COD_PAIS" />
            <asp:Parameter Name="CIA" />
            <asp:Parameter Name="CENTRO_COSTO" />
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="CATEGORIA" />
            <asp:Parameter Name="CUENTA_CONTABLE" />
            <asp:SessionParameter DefaultValue="2021" Name="ANO" SessionField="PANO" />
            <asp:Parameter Name="ENERO" />
            <asp:Parameter Name="FEBRERO" />
            <asp:Parameter Name="MARZO" />
            <asp:Parameter Name="ABRIL" />
            <asp:Parameter Name="MAYO" />
            <asp:Parameter Name="JUNIO" />
            <asp:Parameter Name="JULIO" />
            <asp:Parameter Name="AGOSTO" />
            <asp:Parameter Name="SEPTIEMBRE" />
            <asp:Parameter Name="OCTUBRE" />
            <asp:Parameter Name="NOVIEMBRE" />
            <asp:Parameter Name="DICIEMBRE" />
            <asp:Parameter Name="FENERO" />
            <asp:Parameter Name="FFEBRERO" />
            <asp:Parameter Name="FMARZO" />
            <asp:Parameter Name="FABRIL" />
            <asp:Parameter Name="FMAYO" />
            <asp:Parameter Name="FJUNIO" />
            <asp:Parameter Name="FJULIO" />
            <asp:Parameter Name="FAGOSTO" />
            <asp:Parameter Name="FSEPTIEMBRE" />
            <asp:Parameter Name="FOCTUBRE" />
            <asp:Parameter Name="FNOVIEMBRE" />
            <asp:Parameter Name="FDICIEMBRE" />
            <asp:Parameter Name="YAGENERO" />
            <asp:Parameter Name="YAGFEBRERO" />
            <asp:Parameter Name="YAGMARZO" />
            <asp:Parameter Name="YAGABRIL" />
            <asp:Parameter Name="YAGMAYO" />
            <asp:Parameter Name="YAGJUNIO" />
            <asp:Parameter Name="YAGJULIO" />
            <asp:Parameter Name="YAGAGOSTO" />
            <asp:Parameter Name="YAGSEPTIEMBRE" />
            <asp:Parameter Name="YAGOCTUBRE" />
            <asp:Parameter Name="YAGNOVIEMBRE" />
            <asp:Parameter Name="YAGDICIEMBRE" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="AREA" SessionField="PAREA" />
            <asp:SessionParameter Name="ANO" SessionField="PANO" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter DefaultValue="1" Name="AREA" SessionField="PAREA" />
            <asp:Parameter Name="COD_PAIS" />
            <asp:Parameter Name="CIA" />
            <asp:Parameter Name="CENTRO_COSTO" />
            <asp:Parameter Name="DESCRIPCION" />
            <asp:Parameter Name="CATEGORIA" />
            <asp:Parameter Name="CUENTA_CONTABLE" />
            <asp:SessionParameter DefaultValue="2021" Name="ANO" SessionField="PANO" />
            <asp:Parameter Name="ENERO" />
            <asp:Parameter Name="FEBRERO" />
            <asp:Parameter Name="MARZO" />
            <asp:Parameter Name="ABRIL" />
            <asp:Parameter Name="MAYO" />
            <asp:Parameter Name="JUNIO" />
            <asp:Parameter Name="JULIO" />
            <asp:Parameter Name="AGOSTO" />
            <asp:Parameter Name="SEPTIEMBRE" />
            <asp:Parameter Name="OCTUBRE" />
            <asp:Parameter Name="NOVIEMBRE" />
            <asp:Parameter Name="DICIEMBRE" />
            <asp:Parameter Name="FENERO" />
            <asp:Parameter Name="FFEBRERO" />
            <asp:Parameter Name="FMARZO" />
            <asp:Parameter Name="FABRIL" />
            <asp:Parameter Name="FMAYO" />
            <asp:Parameter Name="FJUNIO" />
            <asp:Parameter Name="FJULIO" />
            <asp:Parameter Name="FAGOSTO" />
            <asp:Parameter Name="FSEPTIEMBRE" />
            <asp:Parameter Name="FOCTUBRE" />
            <asp:Parameter Name="FNOVIEMBRE" />
            <asp:Parameter Name="FDICIEMBRE" />
            <asp:Parameter Name="YAGENERO" />
            <asp:Parameter Name="YAGFEBRERO" />
            <asp:Parameter Name="YAGMARZO" />
            <asp:Parameter Name="YAGABRIL" />
            <asp:Parameter Name="YAGMAYO" />
            <asp:Parameter Name="YAGJUNIO" />
            <asp:Parameter Name="YAGJULIO" />
            <asp:Parameter Name="YAGAGOSTO" />
            <asp:Parameter Name="YAGSEPTIEMBRE" />
            <asp:Parameter Name="YAGOCTUBRE" />
            <asp:Parameter Name="YAGNOVIEMBRE" />
            <asp:Parameter Name="YAGDICIEMBRE" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <dx:ASPxGridViewExporter ID="grid_data_expDetaII" runat="server" FileName="Presupuesto_restringido" GridViewID="ASPxGridView2">
    </dx:ASPxGridViewExporter>
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Registros no modificables con asignación de centros de costos o cuentas contables no permitidas en este periodo:<br />
    <br />
    <dx:ASPxGridView ID="ASPxGridView2" runat="server" AutoGenerateColumns="False" DataSourceID="SQLPresupuestoNoModificable" KeyFieldName="ID" EnableTheming="True" Theme="SoftOrange" ClientInstanceName="grid2" OnCellEditorInitialize="ASPxGridView1_CellEditorInitialize" OnCustomUnboundColumnData="ASPxGridView1_CustomUnboundColumnData">
        <ClientSideEvents BatchEditStartEditing="OnBatchEditStartEditing" BatchEditEndEditing="OnBatchEditEndEditing" CustomButtonClick="function(s, e) {  }" />
        <SettingsPager NumericButtonCount="20" PageSize="20">
        </SettingsPager>
        <SettingsEditing Mode="Batch" BatchEditSettings-EditMode="Cell">
             <BatchEditSettings ShowConfirmOnLosingChanges="true" />
        </SettingsEditing>
        <Settings ShowFilterRow="True" />
        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="ID" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="1" ShowInCustomizationForm="True" Visible="False">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="COD_PAIS" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3" ShowInCustomizationForm="True" Visible="False">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="7" ShowInCustomizationForm="True">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="ANO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9" ShowInCustomizationForm="True" Visible="False">
            </dx:GridViewDataTextColumn>
                            <dx:GridViewBandColumn Caption="Presupuesto" VisibleIndex="11">
                    <HeaderStyle HorizontalAlign="Center" BackColor="#336600" />
                    <Columns>
                      <dx:GridViewDataTextColumn FieldName="ENERO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="8" ShowInCustomizationForm="True" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FEBRERO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="9" ShowInCustomizationForm="True" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="MARZO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="10" ShowInCustomizationForm="True" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="ABRIL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="11" ShowInCustomizationForm="True" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="MAYO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="12" ShowInCustomizationForm="True" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="JUNIO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="13" ShowInCustomizationForm="True" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="JULIO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="14" ShowInCustomizationForm="True" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="AGOSTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="15" ShowInCustomizationForm="True" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="SEPTIEMBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="16" ShowInCustomizationForm="True" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="OCTUBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="17" ShowInCustomizationForm="True" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="NOVIEMBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="18" ShowInCustomizationForm="True" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="DICIEMBRE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="19" ShowInCustomizationForm="True" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="TOTAL PRES" FieldName="Sum" LoadReadOnlyValueFromDataModel="True" ReadOnly="True"  UnboundType="Decimal" VisibleIndex="20">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                             <Settings ShowEditorInBatchEditMode="false" />
                            <CellStyle BackColor="#FFFF66">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                     </Columns>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="Forecast" VisibleIndex="12">
                    <HeaderStyle HorizontalAlign="Center" />
                    <Columns>
                      <dx:GridViewDataTextColumn FieldName="FENERO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="20" ShowInCustomizationForm="True" Caption ="ENERO" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FFEBRERO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="21" ShowInCustomizationForm="True"  Caption ="FEBRERO" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FMARZO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="22" ShowInCustomizationForm="True"  Caption ="MARZO" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FABRIL" LoadReadOnlyValueFromDataModel="True" VisibleIndex="23" ShowInCustomizationForm="True"  Caption ="ABRIL" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FMAYO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="24"  Caption ="MAYO" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FJUNIO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="25"  Caption ="JUNIO" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FJULIO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="26" Caption ="JULIO" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FAGOSTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="27" Caption ="AGOSTO" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FSEPTIEMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="28" Caption ="SEPTIEMBRE" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FOCTUBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="29" Caption ="OCTUBRE" ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FNOVIEMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="30" Caption ="NOVIEMBRE"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="FDICIEMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="31" Caption ="DICIEMBRE"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="TOTAL FORECAST" FieldName="SumForecast" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" UnboundType="Decimal" VisibleIndex="32">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                           <Settings ShowEditorInBatchEditMode="false" />
                            <CellStyle BackColor="#FFFF66">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                     </Columns>
                </dx:GridViewBandColumn>
                <dx:GridViewBandColumn Caption="Año Anterior" VisibleIndex="13">
                    <HeaderStyle HorizontalAlign="Center" />
                    <Columns>
                      <dx:GridViewDataTextColumn FieldName="YAGENERO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="32" Caption ="ENERO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGFEBRERO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="33" Caption ="FEBRERO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGMARZO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="34" Caption ="MARZO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGABRIL" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="35" Caption ="ABRIL"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGMAYO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="36" Caption ="MAYO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGJUNIO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="37" Caption ="JUNIO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGJULIO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="38" Caption ="JULIO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGAGOSTO" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="39" Caption ="AGOSTO"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGSEPTIEMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="40" Caption ="SEPTIEMBRE"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGOCTUBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="41" Caption ="OCTUBRE"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGNOVIEMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="42" Caption ="NOVIEMBRE"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                      <dx:GridViewDataTextColumn FieldName="YAGDICIEMBRE" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="43" Caption ="DICIEMBRE"  ReadOnly="true">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="TOTAL AÑO ANT" FieldName="SumAnt" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" UnboundType="Decimal" VisibleIndex="44">
                          <PropertiesTextEdit DisplayFormatString="#,###">
                          </PropertiesTextEdit>
                           <Settings ShowEditorInBatchEditMode="false" />
                            <CellStyle BackColor="#FFFF66">
                            </CellStyle>
                        </dx:GridViewDataTextColumn>
                     </Columns>
                </dx:GridViewBandColumn>
            <dx:GridViewDataComboBoxColumn FieldName="AREA" LoadReadOnlyValueFromDataModel="True" ShowInCustomizationForm="True" VisibleIndex="2" Visible="False">
                <PropertiesComboBox DataSourceID="SQLArea" TextField="DESCRIPCION" ValueField="AREA">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
           <dx:GridViewDataComboBoxColumn FieldName="CIA" LoadReadOnlyValueFromDataModel="True" VisibleIndex="4">
                <PropertiesComboBox EnableCallbackMode="true" DataSourceID="SQLCia" TextField="NOMBRE" ValueField="CONJUNTO" Width="200px">
                    <ValidationSettings RequiredField-IsRequired="true"><RequiredField IsRequired="True"></RequiredField>
                    </ValidationSettings>
                    <ClientSideEvents SelectedIndexChanged="CIACombo_SelectedIndexChanged" />
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CUENTA_CONTABLE" LoadReadOnlyValueFromDataModel="True" VisibleIndex="5">
                <PropertiesComboBox EnableCallbackMode="true" CallbackPageSize="20" IncrementalFilteringMode="Contains"  TextField="DESCRIPCION" ValueField="CUENTA_CONTABLE"  OnItemRequestedByValue="OnItemRequestedByValue" OnItemsRequestedByFilterCondition="OnItemsRequestedByFilterCondition"  Width="200px">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CENTRO_COSTO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="6">
                <PropertiesComboBox EnableCallbackMode="true" CallbackPageSize="20" IncrementalFilteringMode="Contains"  TextField="DESCRIPCION" ValueField="CENTRO_COSTO"   OnItemRequestedByValue="Centro_ItemRequestedByValue" OnItemsRequestedByFilterCondition="Centro_OnItemsRequestedByFilterCondition"  Width="200px">
                </PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
          
            <dx:GridViewCommandColumn VisibleIndex="10">
                <CustomButtons>
                    <dx:GridViewCommandColumnCustomButton ID="btcopiar" Text="" >
                        <Image IconID="businessobjects_bo_transition_svg_16x16">
                        </Image>
                    </dx:GridViewCommandColumnCustomButton>
                </CustomButtons>
            </dx:GridViewCommandColumn>
          
        </Columns>
    </dx:ASPxGridView>
    <br />

        
    <asp:SqlDataSource ID="SQLCentroCosto" runat="server" ConnectionString="Data Source=10.144.10.10;Initial Catalog=me;Persist Security Info=True;User ID=PortalRep
;Password=P0rta1R3p.2766$" ProviderName="System.Data.SqlClient" SelectCommand="SELECT  CENTRO_COSTO, CENTRO_COSTO + ' ' + DESCRIPCION DESCRIPCION
  FROM [PORTAL].[Presupuesto].[CENTRO_COSTO]
  order by 1">
    </asp:SqlDataSource>

            
             <br />

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
                <dx:ASPxLabel ID="LabelMensaje" runat="server" Font-Bold="True" Text="Esta seguro que desea reemplazar los valores de los siguientes meses?" style="margin-left: 7px" Width="300px">
                    <DisabledStyle Font-Bold="True">
                    </DisabledStyle>
                </dx:ASPxLabel>
            </td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style3">&nbsp;
                <br />
                &nbsp;</td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
        </tr>
        <tr>
            <td class="auto-style9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="BTAceptar" runat="server" Text="Aceptar" Width="80px" AutoPostBack="False">
                    <ClientSideEvents Click="function(s, e) {
         copydata(bots, bote); 
	PDialogo.Hide();
}" />
                    <Image IconID="businessobjects_bo_validation_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="BTCancelar" runat="server" Text="Cancelar" AutoPostBack="False">
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



       <dx:ASPxPopupControl ID="ASPxPopupControl2" runat="server" Height="130px" Width="363px" HeaderText="Confirmación"  ClientInstanceName="PDialogoD" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" >
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
                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Font-Bold="True" Text="Esta seguro que desea eliminar el registro?" style="margin-left: 7px" Width="300px">
                    <DisabledStyle Font-Bold="True">
                    </DisabledStyle>
                </dx:ASPxLabel>
            </td>
            <td class="auto-style3">&nbsp;</td>
        </tr>
        <tr>
            <td class="auto-style8">&nbsp;</td>
            <td class="auto-style3">&nbsp;
                <br />
                &nbsp;</td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
            <td class="auto-style3"></td>
        </tr>
        <tr>
            <td class="auto-style9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Si" Width="80px" AutoPostBack="False">
                    <ClientSideEvents Click="function(s, e) {
                        var visibleIndex;
                        visibleIndex = bote.visibleIndex;
         grid.DeleteRow(visibleIndex); 
	     PDialogoD.Hide();
}" />
                    <Image IconID="businessobjects_bo_validation_svg_16x16">
                    </Image>
                </dx:ASPxButton>
            </td>
            <td class="progress-xxlarge"></td>
            <td class="progress-xxlarge">
                <dx:ASPxButton ID="ASPxButton2" runat="server" Text="No" AutoPostBack="False">
                    <ClientSideEvents Click="function(s, e) {
	PDialogoD.Hide();
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


             </asp:Content>
