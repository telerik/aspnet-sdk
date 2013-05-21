<%@ Page Language="vb" CodeFile="DefaultVB.aspx.vb" Inherits="Telerik.GridExamplesVBNET.AJAX.ClientEditBatchUpdates.DefaultVB" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<html>
<head>
    <title>Test</title>
    <script type="text/javascript">
    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                //<![CDATA[
                //Custom js code section used to edit records, store changes and switch the visibility of column editors

                //global variables for edited cell and edited rows ids
                var editedCell;
                var arrayIndex = 0;
                var editedItemsIds = [];

                function RowCreated(sender, eventArgs) {
                    var dataItem = eventArgs.get_gridDataItem();

                    //traverse the cells in the created client row object and attach dblclick handler for each of them
                    for (var i = 1; i < dataItem.get_element().cells.length; i++) {
                        var cell = dataItem.get_element().cells[i];
                        if (cell) {
                            $addHandler(cell, "dblclick", Function.createDelegate(cell, ShowColumnEditor));
                        }
                    }
                }

                //detach the ondblclick handlers from the cells on row disposing
                function RowDestroying(sender, eventArgs) {
                    if (eventArgs.get_id() === "") return;
                    var row = eventArgs.get_gridDataItem().get_element();
                    var cells = row.cells;
                    for (var j = 0, len = cells.length; j < len; j++) {
                        var cell = cells[j];
                        if (cell) {
                            $clearHandlers(cell);
                        }
                    }
                }

                function RowClick(sender, eventArgs) {
                    if (editedCell) {
                        //if the click target is table cell or span and there is an edited cell, update the value in it
                        //skip update if clicking a span that happens to be a form decorator element (having a class that starts with "rfd")
                        if ((eventArgs.get_domEvent().target.tagName == "TD") ||
                            (eventArgs.get_domEvent().target.tagName == "SPAN" && !eventArgs.get_domEvent().target.className.startsWith("rfd"))) {
                            UpdateValues(sender);
                            editedCell = false;
                        }
                    }
                }
                function ShowColumnEditor() {
                    editedCell = this;

                    //hide text and show column editor in the edited cell
                    var cellText = this.getElementsByTagName("span")[0];
                    cellText.style.display = "none";

                    //display the span which wrapps the hidden checkbox editor
                    if (this.getElementsByTagName("span")[1]) {
                        this.getElementsByTagName("span")[1].style.display = "";
                    }
                    var colEditor = this.getElementsByTagName("input")[0] || this.getElementsByTagName("select")[0];
                    //if the column editor is a form decorated select dropdown, show it instead of the original
                    if (colEditor.className == "rfdRealInput" && colEditor.tagName.toLowerCase() == "select") colEditor = Telerik.Web.UI.RadFormDecorator.getDecoratedElement(colEditor);
                    colEditor.style.display = "";
                    colEditor.focus();
                }
                function StoreEditedItemId(editCell) {
                    //get edited row key value and add it to the array which holds them
                    var gridRow = $find(editCell.parentNode.id);
                    var rowKeyValue = gridRow.getDataKeyValue("ProductID");
                    Array.add(editedItemsIds, rowKeyValue);
                }
                function HideEditor(editCell, editorType) {
                    //get reference to the label in the edited cell
                    var lbl = editCell.getElementsByTagName("span")[0];

                    switch (editorType) {
                        case "textbox":
                            var txtBox = editCell.getElementsByTagName("input")[0];
                            if (lbl.innerHTML != txtBox.value) {
                                lbl.innerHTML = txtBox.value;
                                editCell.style.border = "1px dashed";

                                StoreEditedItemId(editCell);
                            }
                            txtBox.style.display = "none";
                            break;
                        case "checkbox":
                            var chkBox = editCell.getElementsByTagName("input")[0];
                            if (lbl.innerHTML.toLowerCase() != chkBox.checked.toString()) {
                                lbl.innerHTML = chkBox.checked;
                                editedCell.style.border = "1px dashed";

                                StoreEditedItemId(editCell);
                            }
                            chkBox.style.display = "none";
                            editCell.getElementsByTagName("span")[1].style.display = "none";
                            break;
                        case "dropdown":
                            var ddl = editCell.getElementsByTagName("select")[0];
                            var selectedValue = ddl.options[ddl.selectedIndex].value;
                            if (lbl.innerHTML != selectedValue) {
                                lbl.innerHTML = selectedValue;
                                editCell.style.border = "1px dashed";

                                StoreEditedItemId(editCell);
                            }
                            //if the form decorator was enabled, hide the decorated dropdown instead of the original.
                            if (ddl.className == "rfdRealInput") ddl = Telerik.Web.UI.RadFormDecorator.getDecoratedElement(ddl);
                            ddl.style.display = "none";
                        default:
                            break;
                    }
                    lbl.style.display = "inline";
                }
                function UpdateValues(grid) {
                    //determine the name of the column to which the edited cell belongs
                    var tHeadElement = grid.get_element().getElementsByTagName("thead")[0];
                    var headerRow = tHeadElement.getElementsByTagName("tr")[0];
                    var colName = grid.get_masterTableView().getColumnUniqueNameByCellIndex(headerRow, editedCell.cellIndex);

                    //based on the column name, extract the value from the editor, update the text of the label and switch its visibility with that of the column
                    //column. The update happens only when the column editor value is different than the non-editable value. We also set dashed border to indicate
                    //that the value in the cell is changed. The logic is isolated in the HideEditor js method
                    switch (colName) {
                        case "ProductName":
                            HideEditor(editedCell, "textbox");
                            break;
                        case "QuantityPerUnit":
                            HideEditor(editedCell, "textbox");
                            break;
                        case "UnitPrice":
                            HideEditor(editedCell, "textbox");
                            break;
                        case "UnitsInStock":
                            HideEditor(editedCell, "dropdown");
                            break;
                        case "UnitsOnOrder":
                            HideEditor(editedCell, "textbox");
                            break;
                        case "Discontinued":
                            HideEditor(editedCell, "checkbox");
                            break;
                        default:
                            break;
                    }
                }
                function CancelChanges() {
                    if (editedItemsIds.length > 0) {
                        $find("<%=RadAjaxManager1.ClientID %>").ajaxRequest("");
            }
            else {
                alert("No pending changes to be discarded");
            }
            editedItemsIds = [];
        }
        function ProcessChanges() {
            //extract edited rows ids and pass them as argument in the ajaxRequest method of the manager
            if (editedItemsIds.length > 0) {
                var Ids = "";
                for (var i = 0; i < editedItemsIds.length; i++) {
                    Ids = Ids + editedItemsIds[i] + ":";
                }
                $find("<%=RadAjaxManager1.ClientID %>").ajaxRequest(Ids);
                }
                else {
                    alert("No pending changes to be processed");
                }
                editedItemsIds = [];
            }
            function RadGrid1_Command(sender, eventArgs) {
                //Note that this code has to be executed if you postback from external control instead from the grid (intercepting its onclientclick handler for this purpose),
                //otherwise the edited values will be lost or not propagated in the source
                if (editedItemsIds.length > 0) {
                    if (eventArgs.get_commandName() == "Sort" || eventArgs.get_commandName() == "Page" || eventArgs.get_commandName() == "Filter") {
                        if (confirm("Any unsaved edited values will be lost. Choose 'OK' to discard the changes before proceeding or 'Cancel' to abort the action and process them.")) {
                            editedItemsIds = [];
                        }
                        else {
                            //cancel the chosen action
                            eventArgs.set_cancel(true);

                            //process the changes
                            ProcessChanges();
                            editedItemsIds = [];
                        }
                    }
                }
            }
            window.onunload = function () {
                //this code should also be executed on postback from external control (which rebinds the grid) to process any unsaved data
                if (editedItemsIds.length > 0) {
                    if (confirm("Any unsaved edited values will be lost. Choose 'OK' to discard the changes before proceeding or 'Cancel' to abort the action and process them.")) {
                        editedItemsIds = [];
                    }
                    else {
                        //process the changes
                        ProcessChanges();
                        editedItemsIds = [];
                    }
                }
            };
            //]]>	
            </script>
        </telerik:RadCodeBlock>
        <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" DecoratedControls="Default,Select,Textbox"
            EnableRoundedCorners="false"></telerik:RadFormDecorator>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadGrid1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="RadInputManager1"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="Label1"></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="RadInputManager1"></telerik:AjaxUpdatedControl>
                        <telerik:AjaxUpdatedControl ControlID="Label1"></telerik:AjaxUpdatedControl>
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
        </telerik:RadAjaxLoadingPanel>
        <telerik:RadInputManager ID="RadInputManager1" EnableEmbeddedBaseStylesheet="false"
            Skin="" runat="server">
            <telerik:TextBoxSetting BehaviorID="StringBehavior" InitializeOnClient="true" EmptyMessage="type here">
            </telerik:TextBoxSetting>
            <telerik:NumericTextBoxSetting BehaviorID="CurrencyBehavior" InitializeOnClient="true"
                EmptyMessage="type.." Type="Currency" Validation-IsRequired="true" MinValue="1"
                MaxValue="100000">
            </telerik:NumericTextBoxSetting>
            <telerik:NumericTextBoxSetting BehaviorID="NumberBehavior" InitializeOnClient="true"
                EmptyMessage="type.." Type="Number" DecimalDigits="0" MinValue="0" MaxValue="100">
            </telerik:NumericTextBoxSetting>
        </telerik:RadInputManager>
        <telerik:RadGrid ID="RadGrid1" DataSourceID="SqlDataSource1" Width="97%" ShowStatusBar="True"
            AllowSorting="True" PageSize="15" GridLines="None" AllowPaging="True" runat="server"
            AutoGenerateColumns="False">
            <MasterTableView TableLayout="Fixed" DataKeyNames="ProductID" EditMode="InPlace"
                ClientDataKeyNames="ProductID" CommandItemDisplay="Bottom">
                <CommandItemTemplate>
                    <div style="height: 30px; text-align: right;">
                        <asp:Image ID="imgCancelChanges" runat="server" ImageUrl="~/Img/cancel.gif"
                            AlternateText="Cancel changes" ToolTip="Cancel changes" Height="24px" Style="cursor: pointer; margin: 2px 5px 0px 0px;"
                            onclick="CancelChanges();"></asp:Image>
                        <asp:Image ID="imgProcessChanges" runat="server" ImageUrl="~/Img/ok.gif"
                            AlternateText="Process changes" ToolTip="Process changes" Height="24px" Style="cursor: pointer; margin: 2px 5px 0px 0px;"
                            onclick="ProcessChanges();"></asp:Image>
                    </div>
                </CommandItemTemplate>
                <Columns>
                    <telerik:GridBoundColumn UniqueName="ProductID" DataField="ProductID" HeaderText="ProductID"
                        ReadOnly="True" HeaderStyle-Width="5%">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn UniqueName="ProductName" SortExpression="ProductName"
                        HeaderText="ProductName" HeaderStyle-Width="15%">
                        <ItemTemplate>
                            <asp:Label ID="lblProductName" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                            <asp:TextBox ID="txtBoxName" runat="server" Text='<%# Bind("ProductName") %>' Width="95%"
                                Style="display: none"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="QuantityPerUnit" HeaderText="QuantityPerUnit"
                        SortExpression="QuantityPerUnit" HeaderStyle-Width="10%">
                        <ItemTemplate>
                            <asp:Label ID="lblQuantityPerUnit" runat="server" Text='<%# Eval("QuantityPerUnit") %>'></asp:Label>
                            <asp:TextBox ID="txtQuantityPerUnit" runat="server" Text='<%# Bind("QuantityPerUnit") %>'
                                Width="95%" Style="display: none"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="UnitPrice" HeaderText="UnitPrice" SortExpression="UnitPrice"
                        HeaderStyle-Width="7%">
                        <ItemTemplate>
                            <asp:Label ID="lblUnitPrice" runat="server" Text='<%# Eval("UnitPrice", "{0:C}") %>'></asp:Label>
                            <asp:TextBox ID="txtUnitPrice" runat="server" Width="95%" Text='<%# Bind("UnitPrice") %>'
                                Style="display: none"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="UnitsInStock" HeaderText="UnitsInStock" SortExpression="UnitsInStock"
                        HeaderStyle-Width="8%">
                        <ItemTemplate>
                            <asp:Label ID="lblUnitsInStock" runat="server" Text='<%# Eval("UnitsInStock") %>'></asp:Label>
                            <asp:DropDownList ID="ddlUnitsInStock" runat="server" DataTextField="UnitsInStock"
                                DataValueField="UnitsInStock" DataSourceID="SqlDataSource2" SelectedValue='<%# Bind("UnitsInStock") %>'
                                Style="display: none">
                            </asp:DropDownList>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="UnitsOnOrder" HeaderText="UnitsOnOrder" SortExpression="UnitsOnOrder"
                        HeaderStyle-Width="7%">
                        <ItemTemplate>
                            <asp:Label ID="lblUnitsOnOrder" runat="server" Text='<%# Eval("UnitsOnOrder") %>'></asp:Label>
                            <asp:TextBox ID="txtUnitsOnOrder" runat="server" Text='<%# Bind("UnitsOnOrder") %>'
                                Width="95%" Style="display: none"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn UniqueName="Discontinued" HeaderText="Discontinued" SortExpression="Discontinued"
                        HeaderStyle-Width="6%">
                        <ItemTemplate>
                            <asp:Label ID="lblDiscontinued" runat="server" Text='<%# Eval("Discontinued") %>'></asp:Label>
                            <asp:CheckBox ID="chkBoxDiscontinued" runat="server" Checked='<%# Bind("Discontinued") %>'
                                Style="display: none"></asp:CheckBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
            <ClientSettings>
                <ClientEvents OnRowCreated="RowCreated" OnRowClick="RowClick" OnCommand="RadGrid1_Command"
                    OnRowDestroying="RowDestroying"></ClientEvents>
            </ClientSettings>
        </telerik:RadGrid>
        <br />
        <asp:Label ID="Label1" runat="server" EnableViewState="false"></asp:Label>
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString35 %>"
            ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM [Products]"
            runat="server" UpdateCommand="UPDATE [Products] SET [ProductName] = @ProductName, [QuantityPerUnit] = @QuantityPerUnit, [UnitPrice] = @UnitPrice, [UnitsInStock] = @UnitsInStock, [UnitsOnOrder] = @UnitsOnOrder, [Discontinued] = @Discontinued WHERE [ProductID] = @ProductID">
            <UpdateParameters>
                <asp:Parameter Name="ProductID" Type="Int16"></asp:Parameter>
                <asp:Parameter Name="ProductName" Type="String"></asp:Parameter>
                <asp:Parameter Name="QuantityPerUnit" Type="String"></asp:Parameter>
                <asp:Parameter Name="UnitPrice" Type="Decimal"></asp:Parameter>
                <asp:Parameter Name="UnitsInStock" Type="Int16"></asp:Parameter>
                <asp:Parameter Name="UnitsOnOrder" Type="Int16"></asp:Parameter>
                <asp:Parameter Name="Discontinued" Type="Boolean"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString35 %>"
            ProviderName="System.Data.SqlClient" SelectCommand="SELECT DISTINCT UnitsInStock FROM [Products]"></asp:SqlDataSource>
    </form>
</body>
</html>
