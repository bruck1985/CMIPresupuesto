<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="Prueba2.aspx.cs" Inherits="UI.Web.Prueba2" %>
<%@ Register assembly="DevExpress.Web.v18.2, Version=18.2.14.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <dx:ASPxFormLayout ID="ASPxFormLayout1" runat="server" ColCount="5" ColumnCount="5" Height="48px" Width="1413px">
        <Items>
            <dx:LayoutItem ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxComboBox ID="ASPxFormLayout1_E1" runat="server">
                        </dx:ASPxComboBox>
                    
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutItem ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxDateEdit ID="ASPxFormLayout1_E2" runat="server">
                        </dx:ASPxDateEdit>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
            <dx:LayoutItem ColSpan="1">
                <LayoutItemNestedControlCollection>
                    <dx:LayoutItemNestedControlContainer runat="server">
                        <dx:ASPxButton ID="ASPxFormLayout1_E3" runat="server">
                        </dx:ASPxButton>
                    </dx:LayoutItemNestedControlContainer>
                </LayoutItemNestedControlCollection>
            </dx:LayoutItem>
        </Items>
    </dx:ASPxFormLayout>


        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLConexion %>" DeleteCommand="DELETE portal.[Presupuesto].[AREA]
where AREA = @AREA
" InsertCommand="INSERT INTO PORTAL.PRESUPUESTO.AREA (DESCRIPCION,ESTADO)
VALUES (@DESCRIPCION,@ESTADO)" ProviderName="<%$ ConnectionStrings:SQLConexion.ProviderName %>" SelectCommand="SELECT AREA, DESCRIPCION, ESTADO FROM PORTAL.Presupuesto.AREA" UpdateCommand="update portal.[Presupuesto].[AREA]
set DESCRIPCION = @DESCRIPCION, ESTADO= @ESTADO
where AREA = @AREA
">
            <DeleteParameters>
                <asp:Parameter Name="AREA" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="DESCRIPCION" />
                <asp:Parameter Name="ESTADO" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="DESCRIPCION" />
                <asp:Parameter Name="ESTADO" />
                <asp:Parameter Name="AREA" />
            </UpdateParameters>
    </asp:SqlDataSource>



    <br />
    <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EnableTheming="True" KeyFieldName="AREA" Theme="Office2010Silver" Width="446px">
        <SettingsEditing Mode="Batch">
        </SettingsEditing>
        <Settings ShowFilterRow="True" />
        <SettingsBehavior ConfirmDelete="True" />
<SettingsPopup>
<HeaderFilter MinHeight="140px"></HeaderFilter>
</SettingsPopup>
        <SettingsSearchPanel Visible="True" />
        <Columns>
            <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowDeleteButton="True" ShowEditButton="True" ShowNewButtonInHeader="True" VisibleIndex="0">
            </dx:GridViewCommandColumn>
            <dx:GridViewDataTextColumn FieldName="AREA" LoadReadOnlyValueFromDataModel="True" ReadOnly="True" VisibleIndex="1">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataTextColumn FieldName="DESCRIPCION" LoadReadOnlyValueFromDataModel="True" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="ESTADO" LoadReadOnlyValueFromDataModel="True" VisibleIndex="3">
                <PropertiesCheckEdit ValueChecked="A" ValueType="System.String" ValueUnchecked="X">
                </PropertiesCheckEdit>
            </dx:GridViewDataCheckColumn>
        </Columns>
    </dx:ASPxGridView>
    <br />



</asp:Content>
