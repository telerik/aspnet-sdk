<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </telerik:RadScriptManager>

        <script type="text/javascript">

            (function ($) {

                window.itemsTransferring = function (sender, args) {
                    args.set_cancel(true);
                    args.get_sourceListBox().clearSelection();

                    var items = args.get_items(),
                        count = items.length
                        itemsPerStep = 100,
                        steps = Math.ceil(count / itemsPerStep),
                        iteration = 0,
                        startIndex = 0,
                        endIndex = count == itemsPerStep ? count - 1 /* this is the last index */ : itemsPerStep;
                        
                        var interval = setInterval(function () {
                            transfer(items.slice(startIndex, endIndex), args.get_destinationListBox());
                            startIndex += itemsPerStep;
                            endIndex += itemsPerStep;
                            
                            iteration++;

                            if (iteration >= steps) {
                                clearInterval(interval);
                            }

                        }, 50);
                }

                function transfer(items, destination) {
                    destination.insertItems(items);
                }


            })($telerik.$);

        </script>
        <div>

            <telerik:RadListBox 
                ID="RadListBox1" 
                runat="server" 
                Height="400"
                OnClientTransferring="itemsTransferring"
                AllowTransfer="true" 
                TransferToID="RadListBox2">
            </telerik:RadListBox>

            <telerik:RadListBox 
                ID="RadListBox2" 
                runat="server" 
                Height="400">
            </telerik:RadListBox>

        </div>
    </form>
</body>
</html>
