<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs"
    Inherits="RadSchedulerAdvancedForm" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/tr/xhtml11/dtd/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
    <style type="text/css">
        
    </style>
</head>
<body class="BODY">
    <form id="Form1" method="post" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <%--Needed for JavaScript IntelliSense in VS2010--%>
            <%--For VS2008 replace RadScriptManager with ScriptManager--%>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
        </Scripts>
    </telerik:RadScriptManager>
    <telerik:RadScheduler runat="server" ID="RadScheduler1" CustomAttributeNames="AppointmentColor"
        EnableViewState="false" GroupBy="Student" EnableDescriptionField="True" OnTimeSlotCreated="RadScheduler1_TimeSlotCreated">
        <TimelineView UserSelectable="false" />
        <TimeSlotContextMenuSettings EnableDefault="true" />
        <AppointmentContextMenuSettings EnableDefault="true" />
    </telerik:RadScheduler>
 
    <p>
        Note: Multi-valued resources are supported only using a provider.
    </p>
    </form>
</body>
</html>
