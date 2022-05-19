<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Menu.Master" CodeBehind="Seg_usuarios_menu.aspx.vb" Inherits="RentaMaker.Seg_usuarios_menu" 
    title="Untitled Page" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dxm" %>

<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dxe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 496px; height: 192px">
        <tr>
            <td>
                <dxm:aspxmenu id="Menu" runat="server" autoseparators="RootOnly" cssfilepath="~/App_Themes/Red Wine/{0}/styles.css"
                    csspostfix="RedWine" gutterimagespacing="7px" gutterwidth="16px" imagefolder="~/App_Themes/Red Wine/{0}/"
                    itemspacing="1px">
<RootItemSubMenuOffset FirstItemY="2" LastItemY="2" Y="2"></RootItemSubMenuOffset>
                    <Items>
                        <dxm:MenuItem Text="" ToolTip="Grabar Permisos de Usuarios" Name="BTGUARDAR" BeginGroup="True">
                            <Image Url="~/imagenes/guardar.png" />
                        </dxm:MenuItem>
                        <dxm:MenuItem BeginGroup="True" Text="" ToolTip="Exportar a Excel" Name="BTEXCEL">
                            <Image Url="~/imagenes/Excel2.png" />
                        </dxm:MenuItem>
                    </Items>
<VerticalPopOutImage Height="11px" Width="11px"></VerticalPopOutImage>

<ItemStyle DropDownButtonSpacing="10px"></ItemStyle>

<ItemSubMenuOffset FirstItemX="2" FirstItemY="-2" LastItemX="2" LastItemY="-2" X="2" Y="-2"></ItemSubMenuOffset>

<SubMenuStyle GutterWidth="0px"></SubMenuStyle>

<SubMenuItemStyle Width="197px" ImageSpacing="4px"></SubMenuItemStyle>

<HorizontalPopOutImage Height="11px" Width="11px"></HorizontalPopOutImage>
</dxm:aspxmenu>
            </td>
            <td>
                &nbsp;</td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                Seleccione Usuario: &nbsp;<dxe:ASPxComboBox ID="CBUsuarios" runat="server" CssFilePath="~/App_Themes/Red Wine/{0}/styles.css"
                    CssPostfix="RedWine" ImageFolder="~/App_Themes/Red Wine/{0}/" LoadingPanelText=""
                    ShowShadow="False" ValueType="System.String" Width="376px" 
                    ClientInstanceName="cbusuarios" DataSourceID="DS_Usuarios" TextField="NOMBRE" 
                    ValueField="USUARIO" EnableIncrementalFiltering="True">
                    <ButtonEditEllipsisImage Height="3px" Url="~/App_Themes/Red Wine/Editors/edtEllipsis.png"
                        UrlDisabled="~/App_Themes/Red Wine/Editors/edtEllipsisDisabled.png" UrlHottracked="~/App_Themes/Red Wine/Editors/edtEllipsisHottracked.png"
                        Width="12px" />
                    <DropDownButton>
                        <Image Height="5px" Url="~/App_Themes/Red Wine/Editors/edtDropDown.png" UrlDisabled="~/App_Themes/Red Wine/Editors/edtDropDownDisabled.png"
                            UrlHottracked="~/App_Themes/Red Wine/Editors/edtDropDownHottracked.png" Width="7px" />
                    </DropDownButton>
                    <ValidationSettings>
                        <ErrorImage Height="14px" Url="~/App_Themes/Red Wine/Editors/edtError.png" Width="14px" />
                        <ErrorFrameStyle ImageSpacing="4px">
                            <ErrorTextPaddings PaddingLeft="4px" />
                        </ErrorFrameStyle>
                    </ValidationSettings>
                    <ClientSideEvents SelectedIndexChanged="function(s, e) {
	grid.PerformCallback();
}" />
                </dxe:ASPxComboBox>
                &nbsp;&nbsp;
                <asp:SqlDataSource ID="DS_Usuarios" runat="server" ConnectionString="<%$ ConnectionStrings:AvonConnection %>"
                    ProviderName="<%$ ConnectionStrings:AvonConnection.ProviderName %>" SelectCommand='SELECT "USUARIO", "NOMBRE" FROM "COM_USUARIOS"
Union 
select username "USUARIO",username from DBA_USERS E where default_tablespace = &#039;USERS&#039;  and username not in 
(select usuario from com_usuarios D where e.username = d.usuario) ORDER BY 1'>
                </asp:SqlDataSource>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <dxwgv:ASPxGridView ID="GPermisos" runat="server" AutoGenerateColumns="False" CssFilePath="~/App_Themes/RedWine/{0}/styles.css"
                    CssPostfix="RedWine" DataSourceID="DS_Menu" KeyFieldName="ID_MENU" 
                    Width="376px" ClientInstanceName="grid" EnableRowsCache="False">
                    <ImagesFilterControl>
                        <LoadingPanel Url="~/App_Themes/RedWine/Editors/Loading.gif">
                        </LoadingPanel>
                    </ImagesFilterControl>
                    <Styles CssFilePath="~/App_Themes/RedWine/{0}/styles.css" CssPostfix="RedWine">
                        <LoadingPanel ImageSpacing="8px">
                        </LoadingPanel>
                    </Styles>
                    <SettingsLoadingPanel ImagePosition="Top" />
                    <Images SpriteCssFilePath="~/App_Themes/RedWine/{0}/sprite.css">
                        <LoadingPanelOnStatusBar Url="~/App_Themes/RedWine/GridView/gvLoadingOnStatusBar.gif">
                        </LoadingPanelOnStatusBar>
                        <LoadingPanel Url="~/App_Themes/RedWine/GridView/Loading.gif">
                        </LoadingPanel>
                    </Images>
                    <Columns>
                        <dxwgv:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="2">
                            <HeaderStyle HorizontalAlign="Center">
                                <Paddings PaddingBottom="1px" PaddingTop="1px" />
                            </HeaderStyle>
                            <HeaderTemplate>
                 				<input type="checkbox" onclick="grid.SelectAllRowsOnPage(this.checked);" style="vertical-align:middle;" title="Seleccione/Deseleccione todas las filas de la pagina"></input>
                            </HeaderTemplate>
                        </dxwgv:GridViewCommandColumn>
                        <dxwgv:GridViewDataTextColumn FieldName="ID_MENU" FixedStyle="Left" ReadOnly="True"
                            VisibleIndex="0">
                        </dxwgv:GridViewDataTextColumn>
                        <dxwgv:GridViewDataTextColumn FieldName="DESCRIPCION" FixedStyle="Left" VisibleIndex="1"
                            Width="100%">
                        </dxwgv:GridViewDataTextColumn>
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
                </dxwgv:ASPxGridView>
                <asp:SqlDataSource ID="DS_Menu" runat="server" ConnectionString="<%$ ConnectionStrings:AvonConnection %>"
                    ProviderName="<%$ ConnectionStrings:AvonConnection.ProviderName %>" SelectCommand="Select id_menu, descripcion&#13;&#10;from comercial.COM_MENU&#13;&#10;order by id_menu&#13;&#10;">
                </asp:SqlDataSource>
                <dxwgv:ASPxGridViewExporter ID="Exportador" runat="server">
                </dxwgv:ASPxGridViewExporter>
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
