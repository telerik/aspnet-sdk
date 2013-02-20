<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <script type="text/javascript">
        function pageLoad() {
            var $ = $telerik.$;
            $(" <li><a onclick='refreshScheduler()'><span>Refresh</span></a></li>").appendTo($('.rsHeader ul'));
        }
        function refreshScheduler() {
            var button = $find("<%= PrevPage.ClientID %>");
            button.click();
        }
    </script>
    <telerik:RadScheduler runat="server" ID="RadScheduler1" GroupBy="User" OnDataBound="RadScheduler1_DataBound"
        OnAppointmentCommand="RadScheduler1_AppointmentCommand" OnFormCreating="RadScheduler1_FormCreating">
    </telerik:RadScheduler>
    <asp:Label runat="server" ID="PagingStatus" />
    <telerik:RadButton runat="server" ID="LinkButton2" Text="All" OnClick="NextPage_Click" ButtonType="LinkButton" ></telerik:RadButton>
    <telerik:RadButton runat="server" ID="PrevPage" Text="A" OnClick="NextPage_Click"
        ButtonType="LinkButton">
    </telerik:RadButton>
    <telerik:RadButton  runat="server" ID="NextPage" Text="B" OnClick="NextPage_Click"  ButtonType="LinkButton"></telerik:RadButton>
    <telerik:RadButton  runat="server" ID="LinkButton1" Text="C" OnClick="NextPage_Click" ButtonType="LinkButton"></telerik:RadButton>
         <telerik:RadButton  runat="server" ID="RadButton1" Text="D" OnClick="NextPage_Click" ButtonType="LinkButton"></telerik:RadButton>
         <telerik:RadButton  runat="server" ID="RadButton2" Text="E" OnClick="NextPage_Click" ButtonType="LinkButton"></telerik:RadButton>
         <telerik:RadButton  runat="server" ID="RadButton3" Text="F" OnClick="NextPage_Click" ButtonType="LinkButton"></telerik:RadButton>
         <telerik:RadButton  runat="server" ID="RadButton4" Text="G" OnClick="NextPage_Click" ButtonType="LinkButton"></telerik:RadButton>
    <asp:HiddenField runat="server" ID="Hiddenfield1" />
    </form>
</body>
</html>
