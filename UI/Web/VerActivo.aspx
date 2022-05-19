<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="VerActivo.aspx.cs" Inherits="UI.Web.VerActivo" %>

<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script type="text/javascript">
        var passwordMinLength = 6;
        function GetPasswordRating(password) {
            var result = 0;
            if (password) {
                result++;
                if (password.length >= passwordMinLength) {
                    if (/[a-z]/.test(password))
                        result++;
                    if (/[A-Z]/.test(password))
                        result++;
                    if (/\d/.test(password))
                        result++;
                    if (!(/^[a-z0-9]+$/i.test(password)))
                        result++;
                }
            }
            return result;
        }
        function OnPasswordTextBoxInit(s, e) {
            ApplyCurrentPasswordRating();
        }
        function OnPassChanged(s, e) {
            ApplyCurrentPasswordRating();
        }
        function ApplyCurrentPasswordRating() {
            var password = passwordTextBox.GetText();
            var passwordRating = GetPasswordRating(password);
            ApplyPasswordRating(passwordRating);
        }
        function ApplyPasswordRating(value) {
            ratingControl.SetValue(value);
            switch (value) {
                case 0:
                    ratingLabel.SetValue("Password safety");
                    break;
                case 1:
                    ratingLabel.SetValue("Too simple");
                    break;
                case 2:
                    ratingLabel.SetValue("Not safe");
                    break;
                case 3:
                    ratingLabel.SetValue("Normal");
                    break;
                case 4:
                    ratingLabel.SetValue("Safe");
                    break;
                case 5:
                    ratingLabel.SetValue("Very safe");
                    break;
                default:
                    ratingLabel.SetValue("Password safety");
            }
        }
        function GetErrorText(editor) {
            if (editor === passwordTextBox) {
                if (ratingControl.GetValue() === 1)
                    return "The password is too simple";
            } else if (editor === confirmPasswordTextBox) {
                if (passwordTextBox.GetText() !== confirmPasswordTextBox.GetText())
                    return "The password you entered do not match";
            }
            return "";
        }
        function OnPassValidation(s, e) {
            var errorText = GetErrorText(s);
            if (errorText) {
                e.isValid = false;
                e.errorText = errorText;
            }
        }
        function onControlsInitialized(s, e) {
            FormLayout.AdjustControl();
            var controls = ASPxClientControl.GetControlCollection().GetControlsByPredicate(function (c) {
                return c.GetParentControl() === FormLayout;
            });
            for (var i = 0; i < controls.length; i++) {
                var valEvt = controls[i].Validation;
                if (valEvt)
                    valEvt.AddHandler(onValidation);
            }
        }
        function onValidation(s, e) {
            setTimeout(function () { FormLayout.AdjustControl(); }, 0);
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <dx:ASPxFormLayout ID="FormLayout" ClientInstanceName="FormLayout" runat="server" RequiredMarkDisplayMode="Auto" UseDefaultPaddings="false" AlignItemCaptionsInAllGroups="true" Width="100%" ColumnCount="2">
        <Paddings PaddingBottom="30" PaddingTop="10" />

        <Items>
            <dx:LayoutGroup Caption="Ver Activo" GroupBoxDecoration="Box" ColumnCount="1">

                <Items>

                    <dx:LayoutItem Caption="Empresa" Name="LiEmpresa">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox runat="server" ID="cbEmpresas" DropDownStyle="DropDownList" IncrementalFilteringMode="StartsWith" CssClass="maxWidth" SelectedIndex="0" >
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Codigo Activo" Name="LiCodigoActivo">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtCodigoActivo" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="250">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    
                    <dx:LayoutItem Caption="Nombre Activo" Name="LiNombreActivo">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtNombreActivo" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="250">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Codigo Mejora" Name="LiCodigoMejora">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtCodigoMejora" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Nombre Mejora" Name="LiNombreMejora">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtNombreMejora" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Tipo Activo" Name="LiTipoActivo">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtTipoActivo" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Fecha Adquisicion" Name="LiFechaAdquisicion">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtFechaAdquisicion" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                    <MaskSettings Mask="dd/MM/yyyy" />
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Fecha Activacion" Name="LiFechaActivacion">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtFechaActivacion" runat="server"  CssClass="maxWidth" MaxLength="200">
                                    <MaskSettings Mask="dd/MM/yyyy" />
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Costo Local" Name="LiCostoLocalFiscal">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtCostoLocalFiscal" DisplayFormatString="{0:N2}" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Costo Dolar" Name="LiCostoDolarFiscal">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtCostoDolarFiscal" runat="server" DisplayFormatString="{0:N2}"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Valor Libros Local" Name="LiValorLibrosLocal">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtValorLibrosLocal" runat="server" DisplayFormatString="{0:N2}" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Valor Libros Dolar" Name="LiValorLibrosDolar">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtValorLibrosDolar" runat="server" DisplayFormatString="{0:N2}" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Vida Util (Mes)" Name="LiPlazoVidaUtilFiscal">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtPlazoVidaUtilFiscal" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Serie" Name="LiNumeroSerie">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtNumeroSerie" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Estado" Name="LiEstado">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtEstado" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Codigo Responsable" Name="LiResponsable">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtResponsable" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Responsable" Name="LiNombreResponsable">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtNombreResponsable" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Ubicacion" Name="LiUbicacion">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtUbicacion" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Nombre Ubicacion" Name="LiNombreUbicacion">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtNombreUbicacion" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Fecha Ultimo Inventario" Name="LiFechaUltimoInventario">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtFechaUltimoInventario" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                    <MaskSettings Mask="dd/MM/yyyy" />
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>



                    <dx:LayoutItem Caption="Fecha Ultimo Mantenimiento" Name="LiFechaUltimoMantenimiento" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtFechaUltimoMantenimiento" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Fecha Proximo Mantenimiento" Name="LiFechaProximoMantenimiento" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtFechaProximoMantenimiento" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Codigo Barras" Name="LiCodigoBarras" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtCodigoBarras" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Proveedor" Name="LiProveedor" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtProveedor" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Clasificacion" Name="LiClasificacion" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtClasificacion" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Tipo Depreciacion Fiscal" Name="LiTipoDepreciacionFiscal" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtTipoDepreciacionFiscal" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Valor Rescate Local Fiscal" Name="LiValorRescateLocalFiscal" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtValorRescateLocalFiscal" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Valor Rescate Dolar Fiscal" Name="LiValorRescateDolarFiscal" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtValorRescateDolarFiscal" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Asiento Ingreso Fiscal" Name="LiAsientoIngresoFiscal" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtAsientoIngresoFiscal" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Ultima Depreciacion Fiscal" Name="LiUltimaDepreciacionFiscal" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtUltimaDepreciacionFiscal" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Ultima Revaluacion Fiscal" Name="LiUltimaRevaluacionFiscal" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtUltimaRevaluacionFiscal" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Tipo Indice Precio Fiscal" Name="LiTipoIndicePrecioFiscal" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtTipoIndicePrecioFiscal" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Fecha Retiro Fiscal" Name="LiFechaRetiroFiscal" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtFechaRetiroFiscal" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Usuario Retiro Fiscal" Name="LiUsuarioRetiroFiscal" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtUsuarioRetiroFiscal" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Asiento Retiro Fiscal" Name="LiAsientoRetiroFiscal" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtAsientoRetiroFiscal" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Tipo Depreciacion Financiera" Name="LiTipoDepreciacionFinanciera" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtTipoDepreciacionFinanciera" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Vida Util Financiera" Name="LiVidaUtilFinanciera" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtVidaUtilFinanciera" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Costo Local Financiera" Name="LiCostoLocalFinanciera" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtCostoLocalFinanciera" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Costo Dolar Financiera" Name="LiCostoDolarFinanciera" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtCostoDolarFinanciera" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Valor Rescate Local Financiera" Name="LiValorRescateLocalFinanciera" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtValorRescateLocalFinanciera" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Valor Rescate Dolar Financiera" Name="LiValorRescateDolarFinanciera" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtValorRescateDolarFinanciera" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Asiento Ingreso Financiera" Name="LiAsientoIngresoFinanciera" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtAsientoIngresoFinanciera" runat="server" Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Ultima Depreciacion Financiera" Name="LiUltimaDepreciacionFinanciera" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtUltimaDepreciacionFinanciera" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Ultima Revaluacion Financiera" Name="LiUltimaRevaluacionFinanciera" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtUltimaRevaluacionFinanciera" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Usuario Retiro Financiera" Name="LiUsuarioRetiroFinanciera" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtUsuarioRetiroFinanciera" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Asiento Retiro Financiera" Name="LiAsientoRetiroFinanciera" Visible="false">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtAsientoRetiroFinanciera" runat="server"  Width="100%" CssClass="maxWidth" MaxLength="200">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>


                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnCancelar" runat="server" Height="32px" Width="32px" AutoPostBack="False"  EnableClientSideAPI="True">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/Menu/Cerrar_Sesion_Hover.png" Repeat="NoRepeat" VerticalPosition="center" />
                                    <ClientSideEvents Click="function(s,e){ document.location.href='GestionActivos.aspx'; }" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/SaveAll_32x32.png">
                        </TabImage>

                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>
       
        </Items>
    </dx:ASPxFormLayout>


</asp:Content>
