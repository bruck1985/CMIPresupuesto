<%@ Page Title="" Language="C#" MasterPageFile="~/Web/Menu.Master" AutoEventWireup="true" CodeBehind="TestAD1.aspx.cs" Inherits="UI.Web.TestAD1" %>
<%@ Import namespace="System.Security.Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<%
  WindowsIdentity current =  WindowsIdentity.GetCurrent();
  Response.Write(current.Name + ", " + WillFlowAcrossNetwork(current) + "<br />");
%>
</asp:Content>
<script runat="server">

public bool WillFlowAcrossNetwork(WindowsIdentity w)
{
  foreach (SecurityIdentifier s in w.Groups)
  {
    if (s.IsWellKnown(WellKnownSidType.InteractiveSid)) { return true; }
    if (s.IsWellKnown(WellKnownSidType.BatchSid))       { return true; }
    if (s.IsWellKnown(WellKnownSidType.ServiceSid))     { return true; }
  }

  return false;
}

</script>
