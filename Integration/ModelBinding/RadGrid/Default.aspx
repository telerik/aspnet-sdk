<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <telerik:RadSkinManager runat="server" Skin="Metro"></telerik:RadSkinManager>
        <telerik:RadFormDecorator ID="QsfFromDecorator" runat="server" DecoratedControls="All" EnableRoundedCorners="false" />
          <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
        </telerik:RadAjaxLoadingPanel>
        <telerik:RadAjaxPanel runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
            <asp:Label runat="server" ID="MessageLabel" ForeColor="Green"></asp:Label>
            
            <b>Filter By Category</b>
            <telerik:RadComboBox ID="RadComboBoxCategories" OnSelectedIndexChanged="RadComboBoxCategories_SelectedIndexChanged" 
                runat="server" SelectMethod="GetCategories"
                DataValueField="CategoryID" DataTextField="CategoryName" AppendDataBoundItems="true" AutoPostBack="true">
                <Items>
                    <telerik:RadComboBoxItem Text="Show All" Value="" />
                </Items>
            </telerik:RadComboBox>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            <telerik:RadGrid ID="RadGrid1" GridLines="None" runat="server" AllowSorting="true" PageSize="10" AllowPaging="True"
                AutoGenerateColumns="False">
                <PagerStyle Mode="NextPrevAndNumeric"></PagerStyle>
                <MasterTableView Width="100%" CommandItemDisplay="TopAndBottom" DataKeyNames="ProductID" SelectMethod="GetProducts"
                    HorizontalAlign="NotSet" InsertMethod="InsertProduct" DeleteMethod="DeleteProduct" AutoGenerateColumns="False" UpdateMethod="UpdateProduct" ItemType="Product">
                    <Columns>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                            <ItemStyle CssClass="MyImageButton"></ItemStyle>
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName"
                            UniqueName="ProductName" ColumnEditorID="GridTextBoxColumnEditor1">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn HeaderText="Category" UniqueName="CategoryID"
                            DataField="CategoryID" SortExpression="CategoryID">
                            <ItemTemplate>
                                <%# Item.Category == null ? "" : Item.Category.CategoryName %>
                            </ItemTemplate>
                            <InsertItemTemplate>
                                <telerik:RadComboBox ID="ComboBox1" runat="server" SelectMethod="GetCategories"
                                    DataValueField="CategoryID" DataTextField="CategoryName" SelectedValue="<%# BindItem.CategoryID %>">
                                </telerik:RadComboBox>
                            </InsertItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="ComboBox1" runat="server" SelectMethod="GetCategories"
                                    DataValueField="CategoryID" DataTextField="CategoryName" SelectedValue="<%# BindItem.CategoryID %>">
                                </telerik:RadComboBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridNumericColumn DataField="UnitsInStock" HeaderText="Units In Stock" SortExpression="UnitsInStock" 
                            UniqueName="UnitsInStock" ColumnEditorID="GridNumericColumnEditor1">
                        </telerik:GridNumericColumn>
                        <telerik:GridBoundColumn DataField="QuantityPerUnit" HeaderText="Quantity Per Unit"
                            SortExpression="QuantityPerUnit" UniqueName="QuantityPerUnit" Visible="false"
                            EditFormColumnIndex="1" ColumnEditorID="GridTextBoxColumnEditor2">
                        </telerik:GridBoundColumn>
                        <telerik:GridCheckBoxColumn DataField="Discontinued" HeaderText="Discontinued" SortExpression="Discontinued"
                            UniqueName="Discontinued" EditFormColumnIndex="1">
                        </telerik:GridCheckBoxColumn>
                        <telerik:GridTemplateColumn HeaderText="UnitPrice" SortExpression="UnitPrice" UniqueName="TemplateColumn"
                            EditFormColumnIndex="1">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblUnitPrice" Text='<%# Item.UnitPrice.HasValue ? Item.UnitPrice.Value.ToString("C") : "" %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <span>
                                    <telerik:RadNumericTextBox runat="server" ID="tbUnitPrice" Width="40px" DataType="System.Decimal"
                                        DbValue='<%# BindItem.UnitPrice %>'>
                                    </telerik:RadNumericTextBox>
                            </EditItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridButtonColumn ConfirmText="Delete this product?" ConfirmDialogType="RadWindow"
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                            UniqueName="DeleteColumn">
                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton"></ItemStyle>
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings ColumnNumber="2" CaptionDataField="ProductName" CaptionFormatString="Edit properties of Product {0}"
                        InsertCaption="New Product">
                        <FormTableItemStyle Wrap="False"></FormTableItemStyle>
                        <FormCaptionStyle CssClass="EditFormHeader"></FormCaptionStyle>
                        <FormMainTableStyle GridLines="None" CellSpacing="0" CellPadding="3"
                            Width="100%"></FormMainTableStyle>
                        <FormTableStyle CellSpacing="0" CellPadding="2" Height="110px"></FormTableStyle>
                        <FormTableAlternatingItemStyle Wrap="False"></FormTableAlternatingItemStyle>
                        <EditColumn ButtonType="ImageButton" InsertText="Insert Order" UpdateText="Update record"
                            UniqueName="EditCommandColumn1" CancelText="Cancel edit">
                        </EditColumn>
                        <FormTableButtonRowStyle HorizontalAlign="Right" CssClass="EditFormButtonRow"></FormTableButtonRowStyle>
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>
        </telerik:RadAjaxPanel>
    </form>
</body>
</html>
