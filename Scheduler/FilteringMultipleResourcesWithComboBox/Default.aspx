<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="TelerikWebForm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <telerik:RadScheduler runat="server" ID="RadScheduler1" GroupBy="User" OnDataBound="RadScheduler1_DataBound"
        StartInsertingInAdvancedForm="true" StartEditingInAdvancedForm="true" OnAppointmentCommand="RadScheduler1_AppointmentCommand"
        OnFormCreating="RadScheduler1_FormCreating">
    </telerik:RadScheduler>
    <asp:Label runat="server" ID="PagingStatus" />
    <telerik:RadComboBox runat="server" ID="RadCombobox1" CheckBoxes="true">
    </telerik:RadComboBox>
    <telerik:RadButton runat="server" ID="RadButton1" onclick="RadButton1_Click" Text="Filter"></telerik:RadButton>
    <asp:HiddenField runat="server" ID="Hiddenfield1" />
    </form>
</body>
</html>
