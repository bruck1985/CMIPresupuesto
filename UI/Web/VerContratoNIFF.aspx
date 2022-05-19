<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="VerContratoNIFF.aspx.cs" Inherits="UI.Web.VerContratoNIFF" %>
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
            <dx:LayoutGroup Caption="Ver Contrato NIFF" GroupBoxDecoration="Box" ColumnCount="1">

                <Items>

                    <dx:LayoutItem Caption="Empresa" Name="LiEmpresa">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox runat="server" ID="cbEmpresas" DropDownStyle="DropDownList" IncrementalFilteringMode="StartsWith" CssClass="maxWidth" SelectedIndex="0" >
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Nombre Contrato" Name="LiContrato">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtNombreContrato" runat="server" NullText="Nombre Contrato" Width="100%" CssClass="maxWidth" MaxLength="250">
                                    <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true">
<ErrorFrameStyle Wrap="True"></ErrorFrameStyle>

<RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>
                    
                    <dx:LayoutItem Caption="País" Name="LiPais">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtPais" runat="server" NullText="País" Width="100%" CssClass="maxWidth" MaxLength="100">
                                    <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true">
<ErrorFrameStyle Wrap="True"></ErrorFrameStyle>

<RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Entidad" Name="LiEntidad">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtEntidad" runat="server" NullText="Entidad" Width="100%" CssClass="maxWidth" MaxLength="200">
                                    <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true">
<ErrorFrameStyle Wrap="True"></ErrorFrameStyle>

<RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Moneda Local" Name="LiMonedaLocal">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox runat="server" ID="cbMonedaLocal" DropDownStyle="DropDownList" IncrementalFilteringMode="StartsWith" CssClass="maxWidth" SelectedIndex="0" >
                                    <Items>
                                        <dx:ListEditItem Text="Dólares" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Euros" Value="1" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Descripción del Activo" Name="LiDescripcionActivo">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtDescripcionActivo" runat="server" NullText="Descripción del Activo" Width="100%" CssClass="maxWidth" MaxLength="300">
                                    <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true">
<ErrorFrameStyle Wrap="True"></ErrorFrameStyle>

<RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Arrendador" Name="LiArrendador">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtArrendador" runat="server" NullText="Arrendador" Width="100%" CssClass="maxWidth" MaxLength="300">
                                    <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true">
<ErrorFrameStyle Wrap="True"></ErrorFrameStyle>

<RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Arrendador es Afiliado" Name="LiAfiliado">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtArrendador" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Contrato incluye subarriendo" Name="LiArriendo">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnSubarriendo" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Cuota Mensual del Arrendamiento" Name="LiCuotaArriendo">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxSpinEdit ID="txtCuotaMensual" runat="server" Number="00.00" DecimalPlaces="2" DisplayFormatString="{0:C}" Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                     <dx:LayoutItem Caption="Cantidad de Arrendamientos en el Contrato" Name="LiCantidadArrendamientos">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxSpinEdit ID="txtCantidadArrendamientos" runat="server" Number="0" DecimalPlaces="0"  Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Moneda del Arrendamiento" Name="LiMonedaArrendamiento">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox runat="server" ID="cbMonedaArrendamiento" DropDownStyle="DropDownList" IncrementalFilteringMode="StartsWith" CssClass="maxWidth" SelectedIndex="0" >
                                    <Items>
                                        <dx:ListEditItem Text="Dólares" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Euros" Value="1" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Fecha Inicio Arrendamiento"  Name="LifechaInicioArrendamiento" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaInicial" runat="server"  Theme="SoftOrange" DisplayFormatString="dd/MM/yyyy" Width="90px">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Fecha Vencimiento Arrendamiento"  Name="LifechaVencimientoArrendamiento" Width="60px">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxDateEdit ID="FechaFinal" runat="server"  Theme="SoftOrange" DisplayFormatString="dd/MM/yyyy" Width="90px">
                                </dx:ASPxDateEdit>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Cantidad de meses transcurridos según Contrato" Name="LiMesesTranscurridos">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxSpinEdit ID="txtMesesTranscurridos" runat="server" Number="0" DecimalPlaces="0"  Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Cantidad de meses pendientes según Contrato" Name="LiMesesPendientes">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxSpinEdit ID="txtMesesPendientes" runat="server" Number="0" DecimalPlaces="0"  Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="El plazo del contrato es mayor a un año" Name="LiPlazoContrato">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnMayorAnio" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Cantidad de Meses Efectivos" Name="LiMesesEfectivos">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxSpinEdit ID="txtMesesEfectivos" runat="server" Number="0" DecimalPlaces="0"  Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Frecuencia de los Pagos" Name="LiFrecuenciaPagos">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtFrecuenciaPagos" runat="server" NullText="Frecuencia de los Pagos" Width="100%" CssClass="maxWidth">
                                    <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true">
<ErrorFrameStyle Wrap="True"></ErrorFrameStyle>

<RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Existen garantías pagadas" Name="LiExisteGarantiaPagadas">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtGarantias" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Monto Garantía Pagada" Name="LiMontoGarantiaPagadas">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxSpinEdit ID="txtGarantiaPagada" runat="server" Number="00.00" DecimalPlaces="2" DisplayFormatString="{0:C}" Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Existen costos iniciales" Name="LiExisteCostoIniciales">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnCostos" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Descripción Costos Iniciales y Montos" Name="LiDescripcionCostoIniciales">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtDescripcionCostosIniciales" runat="server" NullText="Descripción Costos Iniciales y Montos" Width="100%" CssClass="maxWidth">
                                    <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true">
<ErrorFrameStyle Wrap="True"></ErrorFrameStyle>

<RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Existe opción de Compra" Name="LiExisteOpcionCompra">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnOpcionCompra" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Monto Opción de Compra" Name="LiMontoOpcionCompra">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxSpinEdit ID="txtMontoOpcionCompra" runat="server" Number="00.00" DecimalPlaces="2" DisplayFormatString="{0:C}" Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Existe costo de desmantelamiento" Name="LiExisteCostoDesmantelamiento">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnCostoDesmantelamiento" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Monto Costo Desmantelamiento" Name="LiMontoCostoDesmantelamiento">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxSpinEdit ID="txtCostoDesmantelamiento" runat="server" Number="00.00" DecimalPlaces="2" DisplayFormatString="{0:C}" Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Existe Claúsula de Extensión" Name="LiExisteExtension">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnClausulaExtension" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Plazo Claúsula Extensión" Name="LiPlazoExtension">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtPlazoClausulaExtension" runat="server" NullText="Plazo Claúsula Extensión" Width="100%" CssClass="maxWidth">
                                    <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true">
<ErrorFrameStyle Wrap="True"></ErrorFrameStyle>

<RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Probabilidad de tomar la Extensión" Name="LiProbabilidadExtension">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox runat="server" ID="cboProbabilidadExtension" DropDownStyle="DropDownList" IncrementalFilteringMode="StartsWith" CssClass="maxWidth" >
                                    <Items>
                                        <dx:ListEditItem Text="Alta" Value="0" />
                                        <dx:ListEditItem Text="Media" Value="1" />
                                        <dx:ListEditItem Text="Baja" Value="2" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Existe Claúsula de Terminación Anticipada" Name="LiTerminacion">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnTerminacionAnticipada" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Probabilidad de tomar la Terminación Anticipada" Name="LiProbabilidadTerminacion">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxComboBox runat="server" ID="cboProbabilidadTerminacion" DropDownStyle="DropDownList" IncrementalFilteringMode="StartsWith" CssClass="maxWidth" >
                                    <Items>
                                        <dx:ListEditItem Text="Alta" Value="0" />
                                        <dx:ListEditItem Text="Media" Value="1" />
                                        <dx:ListEditItem Text="Baja" Value="2" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Existe Aumento al Pago Mínimo" Name="LiExistePagoMinimo">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnAumentoPagoMinimo" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Porcentaje Aumento al Pago Mínimo" Name="LiPorcentajePagoMinimo">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxSpinEdit ID="txtPorcentajePagoMinimo" runat="server" Number="0.00" MaxValue="1" MinValue="0" DecimalPlaces="2" DisplayFormatString="P" Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Periocidad del Aumento al Pago Mínimo" Name="LiPerioricidadPagoMinimo">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtPeriocidadAumentoPagoMinimo" runat="server" NullText="Perioricidad del Aumento al Pago Mínimo" Width="100%" CssClass="maxWidth">
                                    <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" ErrorFrameStyle-Wrap="true">
<ErrorFrameStyle Wrap="True"></ErrorFrameStyle>

<RequiredField IsRequired="True"></RequiredField>
                                    </ValidationSettings>
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Tasa de Descuento" Name="LiTasaDescuento">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxSpinEdit ID="txtTasaDescuento" runat="server" Number="0.0000" MaxValue="1" MinValue="0" DecimalPlaces="4" DisplayFormatString="P" Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Existe Costos Indirectos" Name="LiExisteCostoIndirectos">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnCostosIndirectos" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Monto Costo Indirecto" Name="LiMontoCostoIndirecto">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxSpinEdit ID="txtCostoIndirecto" runat="server" Number="00.00" DecimalPlaces="2" DisplayFormatString="{0:C}" Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Existe Valor Residual" Name="LiExisteValorResidual">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnValorResidual" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Monto Valor Residual" Name="LiMontoValorResidual">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxSpinEdit ID="txtValorResidual" runat="server" Number="00.00" DecimalPlaces="2" DisplayFormatString="{0:C}" Width="100%" CssClass="maxWidth" />
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Representa un Arrendamiento de Corto Plazo" Name="LiRepresentaCortoPlazo">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnArrendamientoCorto" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Representa un Arrendamiento de Bajo Valor" Name="LiRepresentaBajoValor">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtnArredamientoBajo" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
<Paddings Padding="0px"></Paddings>
                                    <Items>
                                        <dx:ListEditItem Text="No" Value="0" Selected="True" />
                                        <dx:ListEditItem Text="Si" Value="1" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="btnCancelar" runat="server" Height="32px" Width="32px" AutoPostBack="False"  EnableClientSideAPI="True">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/Menu/Cerrar_Sesion_Hover.png" Repeat="NoRepeat" VerticalPosition="center" />
                                    <ClientSideEvents Click="function(s,e){ document.location.href='ContratoNIFF.aspx'; }" />
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
