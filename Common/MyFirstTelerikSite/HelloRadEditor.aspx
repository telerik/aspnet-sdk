<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HelloRadEditor.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

        <telerik:RadEditor runat="server" ID="RadEditor1" RenderMode="Lightweight">
            <Content>             
                Congratulations! You have the Telerik UI for ASP.NET controls running in your project!         
            </Content>
        </telerik:RadEditor>
    </form>
</body>
</html>
