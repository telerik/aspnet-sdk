<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs"
    Inherits="_Default" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<html>
<head>
    <title>Test</title>
    <script type="text/javascript">
        var tree = {
            isRoot: true
        },
            treePositionsCache = {};

        // The idea is to build a tree in which every node has a relation to it's parent group item
        function GridCreated(sender, args) {
            var rows = sender.get_masterTableView().get_element().rows,
                currentRow,
                currentNode = tree,
                shouldGoUpOneLevel = false,
                groupLevel = 1;
            //Builds the tree
            for (var i = 0; i < rows.length; i++) {
                currentRow = rows[i];
                if (currentRow.parentNode.tagName.toLowerCase() === "tbody") {
                    //The row is a group header row
                    if (currentRow.className.indexOf("rgGroupHeader") !== -1) {
                        //Finds the parent node of the current node
                        if (shouldGoUpOneLevel) {
                            for (var j = 0; j < groupLevel - $telerik.getElementsByClassName(currentRow, "rgGroupCol").length + 1; j++) {
                                currentNode = currentNode.parent;
                            }
                        }
                        //Determines the group level
                        groupLevel = $telerik.getElementsByClassName(currentRow, "rgGroupCol").length;
                        currentNode.numberOfItems++;
                        currentNode = currentNode[i] = {
                            //Sets the parent reference
                            parent: currentNode,
                            //Sets the checkbox reference
                            checkbox: $telerik.findElement(currentRow, "ClientSelectColumnSelectCheckBox") ||
                                $telerik.findElement(currentRow, "GroupHeaderCheckBox"),
                            numberOfItems: 0,
                            numberOfCheckedItems: 0
                        };
                    } else {
                        // The row is a GridDataItem 
                        shouldGoUpOneLevel = true;
                        // Increase the number of item that the parent has.
                        currentNode.numberOfItems++;
                        //If the item is selected mark it as one.
                        if (currentRow.className.indexOf("rgSelectedRow") !== -1) {
                            currentNode.numberOfCheckedItems++;
                        }
                    }
                    //Add the node to the tree
                    treePositionsCache[i] = currentNode;
                }
            }
        }

        
        function RowSelected(sender, args) {
            PerformSelect(treePositionsCache[$get(args.get_id()).rowIndex]);
        }

        function RowDeselected(sender, args) {
            PerformDeselect(treePositionsCache[$get(args.get_id()).rowIndex], true);
        }

        //Recursively traverse the tree and deselect the check boxes
        function PerformDeselect(node, firstCall) {
            if (--node.numberOfCheckedItems !== node.numberOfItems && !node.isRoot && node.checkbox.checked) {
                node.checkbox.checked = false;
                PerformDeselect(node.parent, false);
            }
        }

        //Recursively traverse the tree and select the check boxes
        function PerformSelect(node) {
            if (++node.numberOfCheckedItems === node.numberOfItems) {
                node.checkbox.checked = true;
                PerformSelect(node.parent);
            }
        }

        //Called when a group header check box is checked or unchecked
        function GroupToggleSelection(sender) {
            //Finds the row
            var row = Telerik.Web.UI.Grid.GetFirstParentByTagName(sender, "tr"),
                //Obtains the row index
                rowIndex = row.rowIndex,
                //Determines the group level
                level = $telerik.getElementsByClassName(row, "rgGroupCol").length,
                masterTable = $find('<%=RadGrid1.ClientID%>').get_masterTableView(),
                rows = masterTable.get_element().rows,
                isChecked = sender.checked;
            sender.checked = !sender.checkbox;

            //Traverses the rows from the current header down and selects or deselects the GridDataItems
            for (var i = rowIndex + 1; i < rows.length; i++) {
                //If we encounter a grop header with the same group level we stop the selection/deselection
                 if (rows[i].className.indexOf("rgGroupHeader") !== -1) {
                     if ($telerik.getElementsByClassName(rows[i], "rgGroupCol").length === level) {
                         break;
                     }
                 } else if (isChecked) {
                     masterTable.selectItem(rows[i]);
                 } else {
                     masterTable.deselectItem(rows[i]);
                 }
             }
         }
    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <asp:ScriptManager runat="server" ID="ScriptManager1">
        </asp:ScriptManager>
        <telerik:RadGrid ID="RadGrid1" Width="97%" AllowPaging="True" PageSize="15" runat="server"
            AllowSorting="true" AllowMultiRowSelection="true" ShowGroupPanel="true" OnNeedDataSource="RadGrid1_NeedDataSource"
            GridLines="None">
            <MasterTableView Width="100%" AllowPaging="true" GroupLoadMode="Client" AutoGenerateColumns="true">
                <GroupByExpressions>
                    <telerik:GridGroupByExpression>
                        <SelectFields>
                            <telerik:GridGroupByField FieldName="EmployeeID" HeaderText="EmployeeID" />
                        </SelectFields>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="EmployeeID" />
                        </GroupByFields>
                    </telerik:GridGroupByExpression>
                </GroupByExpressions>
                <GroupByExpressions>
                    <telerik:GridGroupByExpression>
                        <SelectFields>
                            <telerik:GridGroupByField FieldName="ShipVia" HeaderText="ShipVia" />
                        </SelectFields>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="ShipVia" />
                        </GroupByFields>
                    </telerik:GridGroupByExpression>
                </GroupByExpressions>
                <GroupByExpressions>
                    <telerik:GridGroupByExpression>
                        <SelectFields>
                            <telerik:GridGroupByField FieldName="ShipCountry" HeaderText="ShipCountry" />
                        </SelectFields>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="ShipCountry" />
                        </GroupByFields>
                    </telerik:GridGroupByExpression>
                </GroupByExpressions>
                <GroupHeaderTemplate>
                    <asp:CheckBox ToggleType="CheckBox" ID="GroupHeaderCheckBox" OnClick="GroupToggleSelection(this);" runat="server"></asp:CheckBox>
                </GroupHeaderTemplate>
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn">
                    </telerik:GridClientSelectColumn>
                </Columns>
            </MasterTableView>
            <PagerStyle Mode="NextPrevAndNumeric"></PagerStyle>
            <FilterMenu EnableTheming="True">
                <CollapseAnimation Duration="200" Type="OutQuint"></CollapseAnimation>
            </FilterMenu>
            <ClientSettings AllowDragToGroup="True" Selecting-AllowRowSelect="true">
                <ClientEvents OnRowDeselected="RowDeselected" OnRowSelected="RowSelected" OnGridCreated="GridCreated" />
            </ClientSettings>
        </telerik:RadGrid>
    </form>
</body>
</html>
