<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="EditarCluster.aspx.cs" Inherits="UI.Web.EditarCluster" %>

<%@ Register assembly="DevExpress.Web.ASPxPivotGrid.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxPivotGrid" tagprefix="dx" %>
  
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
  
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
            <dx:LayoutGroup Caption="Editar Cluster" GroupBoxDecoration="Box" ColumnCount="1">

                <Items>

                    <dx:LayoutItem Caption="" ColSpan="1">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer runat="server">
                                <dx:ASPxButton ID="Lform_E3" runat="server" Height="32px" Width="32px" OnClick="Lform_E3_Click">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/SaveAll_32x32.png" Repeat="NoRepeat" VerticalPosition="center" />
                                </dx:ASPxButton>
                                <dx:ASPxButton ID="btnCancelar" runat="server" Height="32px" Width="32px" AutoPostBack="False" OnClick="btnCancelar_Click" EnableClientSideAPI="True">
                                    <BackgroundImage HorizontalPosition="center" ImageUrl="~/Imagenes/Menu/Cerrar_Sesion_Hover.png" Repeat="NoRepeat" VerticalPosition="center" />
                                    <ClientSideEvents Click="function(s,e){ document.location.href='ClusterAF.aspx'; }" />
                                </dx:ASPxButton>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                        <TabImage Url="~/Imagenes/SaveAll_32x32.png">
                        </TabImage>
                    </dx:LayoutItem>
                   
                    <dx:LayoutItem Caption="Nombre Cluster" Name="LiCluster">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxTextBox ID="txtNombreCluster" runat="server" NullText="Nombre Cluster" Width="100%" CssClass="maxWidth" MaxLength="250">
                                </dx:ASPxTextBox>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="Estado" Name="LiEstado">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxRadioButtonList ID="rbtEstado" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0" SelectedIndex="0">
                                    <Items>
                                        <dx:ListEditItem Text="Activo" Value="1" Selected="True" />
                                        <dx:ListEditItem Text="Inactivo" Value="0" />
                                    </Items>
                                    <Border BorderColor="Transparent" />
                                </dx:ASPxRadioButtonList>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                    <dx:LayoutItem Caption="" Name="LiIdCluster">
                        <LayoutItemNestedControlCollection>
                            <dx:LayoutItemNestedControlContainer>
                                <dx:ASPxHiddenField ID="hdCluster" runat="server">
                                </dx:ASPxHiddenField>
                            </dx:LayoutItemNestedControlContainer>
                        </LayoutItemNestedControlCollection>
                    </dx:LayoutItem>

                </Items>
            </dx:LayoutGroup>
       
        </Items>
    </dx:ASPxFormLayout>

    <dx:ASPxGridView ID="GPermisos" runat="server" AutoGenerateColumns="False" CssFilePath="~/App_Themes/RedWine/{0}/styles.css"
            CssPostfix="RedWine" DataSourceID="SQLCompania" KeyFieldName="CONJUNTO" 
            Width="700px" ClientInstanceName="grid" EnableRowsCache="False" Theme="SoftOrange">
            <ImagesFilterControl>
                <LoadingPanel Url="~/App_Themes/RedWine/Editors/Loading.gif">
                </LoadingPanel>
            </ImagesFilterControl>
            <Styles CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine">
                <LoadingPanel ImageSpacing="8px">
                </LoadingPanel>
            </Styles>
            <SettingsLoadingPanel ImagePosition="Top" />
            <Settings ShowFilterBar="Visible" ShowFilterRow="True" />
            <SettingsSearchPanel Visible="True" />
            <Images SpriteCssFilePath="~/App_Themes/RedWine/{0}/sprite.css">
                <LoadingPanelOnStatusBar Url="~/App_Themes/RedWine/GridView/gvLoadingOnStatusBar.gif">
                </LoadingPanelOnStatusBar>
                <LoadingPanel Url="~/App_Themes/RedWine/GridView/Loading.gif">
                </LoadingPanel>
            </Images>
            <Columns>
                <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="10">
                    <HeaderStyle HorizontalAlign="Center">
                        <Paddings PaddingBottom="1px" PaddingTop="1px" />
                    </HeaderStyle>
                    <HeaderTemplate>
                 		<input type="checkbox" onclick="grid.SelectAllRowsOnPage(this.checked);" style="vertical-align:middle;" title="Seleccione/Deseleccione todas las filas de la pagina"></input>
                    </HeaderTemplate>
                </dx:GridViewCommandColumn>
                <dx:GridViewDataTextColumn FieldName="CONJUNTO" FixedStyle="Left" ReadOnly="True" Caption="Compañia"
                    VisibleIndex="0">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="NOMBRE" FixedStyle="Left" VisibleIndex="1" Caption="Nombre Compañia"
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
 
        <asp:SqlDataSource ID="SQLCompania" runat="server" ConnectionString="Data Source=10.144.10.100;Initial Catalog=Pruebas;Persist Security Info=True;User ID=sa
                    ;Password=SAsoftladbqa$" ProviderName="System.Data.SqlClient" SelectCommand="PORTAL.[dbo].[PORTAL_AF_CIA_CLUSTER]" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="%" Name="PCluster" SessionField="ci_cluster" />
            </SelectParameters>
        </asp:SqlDataSource>


</asp:Content>
