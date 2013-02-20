<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
    </title>
    <style type="text/css">
        #PackageDescription {
            font-family:'Segoe UI';
            font-size:11pt;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1">
        </telerik:RadScriptManager>
        <div>
            <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel1" EnableAJAX="true">
                <telerik:RadAsyncUpload runat="server" ID="RadAsyncUpload1" OnFileUploaded="RadAsyncUpload1_FileUploaded"
                    MultipleFileSelection="Automatic">
                </telerik:RadAsyncUpload>
                <asp:Label runat="server" ID="PackageDescription" Text="Enter a name for the package; If left blank it will default to the current date">
                </asp:Label>
                <telerik:RadTextBox runat="server" ID="PackageNameInput">
                </telerik:RadTextBox>
                <div>
                    <telerik:RadButton runat="server" ID="BtnSubmit" Text="Upload and compress files!" />
                </div>
                <asp:Label ID="Status" runat="server"></asp:Label>
            </telerik:RadAjaxPanel>
        </div>
    </form>
</body>
</html>
