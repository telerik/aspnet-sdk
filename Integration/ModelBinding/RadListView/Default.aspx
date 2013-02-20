<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server"></asp:ScriptManager>
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
            <telerik:RadListView ItemType="Product" ID="RadListView1" runat="server" SelectMethod="GetProducts" UpdateMethod="UpdateProduct" DeleteMethod="DeleteProduct"
                InsertMethod="InsertProduct" ItemPlaceholderID="ProductItemContainer" DataKeyNames="ProductID" AllowPaging="True">
                <LayoutTemplate>
                    <fieldset style="width: 870px;">
                        <legend>RadListView bound with ModelBinding</legend>
                        <table cellpadding="0" cellspacing="0" style="width: 870px;">
                            <tr>
                                <td>
                                    <asp:Button ID="Button1" runat="server" CommandName="InitInsert" Visible="true"
                                        Text="Add new product"></asp:Button>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Panel ID="ProductItemContainer" runat="server">
                                    </asp:Panel>

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <telerik:RadDataPager ID="RadDataPager1" runat="server" PagedControlID="RadListView1"
                                        PageSize="3">
                                        <Fields>
                                            <telerik:RadDataPagerButtonField FieldType="FirstPrev"></telerik:RadDataPagerButtonField>
                                            <telerik:RadDataPagerButtonField FieldType="Numeric"></telerik:RadDataPagerButtonField>
                                            <telerik:RadDataPagerButtonField FieldType="NextLast"></telerik:RadDataPagerButtonField>
                                        </Fields>
                                    </telerik:RadDataPager>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </LayoutTemplate>
                <ItemTemplate>
                    <fieldset style="float: left; width: 260px; height: 203px;">
                        <table cellpadding="2" cellspacing="0" style="height: 100%;">
                            <tr>
                                <td style="width: 20%;">Name:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <%# Item.ProductName %>
                                </td>
                            </tr>
                            <tr>
                                <td>Quantity:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <%# Item.QuantityPerUnit %>
                                </td>
                            </tr>
                            <tr>
                                <td>Price:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <%# Item.UnitPrice.HasValue ? Item.UnitPrice.Value.ToString("C") : "" %>
                                </td>
                            </tr>
                            <tr>
                                <td>Units:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <%# Item.UnitsInStock %>
                                </td>
                            </tr>
                            <tr>
                                <td>Discontinued:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Item.Discontinued %>'
                                        Enabled="false"></asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:ImageButton ID="Button1" runat="server" CommandName="Edit"
                                        ImageUrl="~/Images/Edit.gif"></asp:ImageButton>&nbsp;
                                    <asp:ImageButton ID="Button2" runat="server" CommandName="Delete"
                                        ImageUrl="~/Images/Delete.gif"></asp:ImageButton>
                                </td>
                            </tr>
                        </table>
                    </fieldset>

                </ItemTemplate>
                <EditItemTemplate>
                    <fieldset style="float: left; width: 260px; height: 203px;">
                        <table cellpadding="0" cellspacing="2" style="height: 100%">
                            <tr>
                                <td style="width: 20%;">Name:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# BindItem.ProductName %>' Width="120px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Quantity:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# BindItem.QuantityPerUnit %>' Width="120px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Price:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# BindItem.UnitPrice %>' Width="65px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Units:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# BindItem.UnitsInStock %>' Width="65px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Discontinued:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# BindItem.Discontinued %>'></asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:ImageButton ID="Button1" runat="server" CommandName="Update"
                                        ImageUrl="~/Images/Update.gif"></asp:ImageButton>
                                    <asp:ImageButton ID="Button2" runat="server" CommandName="Cancel"
                                        ImageUrl="~/Images/Cancel.gif"></asp:ImageButton>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <fieldset style="float: left; width: 260px; height: 203px;">
                        <table cellpadding="0" cellspacing="2" style="height: 100%">
                            <tr>
                                <td style="width: 20%;">Name:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# BindItem.ProductName %>' Width="120px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Quantity:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# BindItem.QuantityPerUnit %>' Width="120px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Price:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# BindItem.UnitPrice %>' Width="65px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Units:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# BindItem.UnitsInStock %>' Width="65px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>Discontinued:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# BindItem.Discontinued %>'></asp:CheckBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:ImageButton ID="Button1" runat="server" CommandName="PerformInsert"
                                        ImageUrl="~/Images/Update.gif"></asp:ImageButton>
                                    <asp:ImageButton ID="Button2" runat="server" CommandName="Cancel"
                                        ImageUrl="~/Images/Cancel.gif"></asp:ImageButton>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </InsertItemTemplate>
            </telerik:RadListView>
        </telerik:RadAjaxPanel>
    </form>
</body>
</html>
