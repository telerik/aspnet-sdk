<%@ Page Language="VB" AutoEventWireup="false" CodeFile="HelloRadEditor_skinned.aspx.vb" Inherits="HelloRadEditor_skinned" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server"></telerik:RadScriptManager>

        <telerik:RadEditor runat="server" ID="RadEditor1" RenderMode="Lightweight" Skin="Glow">
            <Content>             
                Congratulations! You have the Telerik UI for ASP.NET controls running in your project!         
            </Content>
        </telerik:RadEditor>
    </form>
</body>
</html>
