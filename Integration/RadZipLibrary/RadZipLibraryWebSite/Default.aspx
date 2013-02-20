<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="StyleSheet.css" rel="stylesheet" type="text/css" />
    <script src="JavaScript.js" type="text/javascript"></script>
    <telerik:RadCodeBlock runat="server">
        <script type="text/javascript">
            var hiddenField = null;
            var ajaxpanel = null;
            var listView = null;
            var previewWin = null;
            var imgHolder = null;

            function pageLoad()
            {
                $ = $telerik.$;
                hiddenField = $get("<%=HiddenFieldSelectedItem.ClientID  %>");
                ajaxpanel = $find("<%=RadAjaxPanel1.ClientID  %>");
                listView = $find("<%= ListViewAlbums.ClientID %>");
                previewWin = $find("<%= PreviewWindow.ClientID %>");
                imgHolder = $get("imageHolder");
                $addHandler(imgHolder, "load", sizePreviewWindow);
            }

        </script>
    </telerik:RadCodeBlock>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
                <asp:ScriptReference Path="~/Scripts/jquery.blockUI.js" />
            </Scripts>
        </telerik:RadScriptManager>
        <telerik:RadSkinManager ID="RadSkinManager1" runat="server"></telerik:RadSkinManager>
        <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" />
        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="conditionalPostback">
            <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
            <telerik:RadWindow ID="PreviewWindow" runat="server" VisibleStatusbar="false" VisibleTitlebar="true"
                OffsetElementID="offsetElement" Top="-10" Left="316" AutoSizeBehaviors="Width, Height"
                AutoSize="true" KeepInScreenBounds="false">
                <ContentTemplate>
                    <img src="javascript:void(0);" alt="Image holder" id="imageHolder" />
                </ContentTemplate>
            </telerik:RadWindow>
            <asp:HiddenField ID="HiddenFieldSelectedItem" runat="server" />
            <h1>All albums</h1>
            <telerik:RadListView runat="server" AllowMultiItemSelection="true" ID="ListViewAlbums" Skin="Metro"
                DataKeyNames="ID, Name">
                <SelectedItemTemplate>
                    <div onclick='selectItem("<%# Container.DataItemIndex %>");' class="rlvA selected albums">
                        <telerik:RadBinaryImage runat="server" ResizeMode="Crop" CropPosition="Center" ID="RadBinaryImage1" DataValue='<%# Eval("Thumbnail") %>'
                            AutoAdjustImageControlSize="false"></telerik:RadBinaryImage>
                        <asp:Label ID="LabelTotalNumber" CssClass="count" runat="server" Text='<%# Eval("Images.Count") %>'></asp:Label>
                        <br />
                        <asp:Label ID="ProductNameLabel" runat="server" Text='<%# string.Format("Photos in {0}", Eval("Name")) %>'></asp:Label>
                        <br style="clear: both; display: block;" />
                        <asp:ImageButton ID="Button1" runat="server" CommandName="Edit" Style="clear: both;"
                            ImageUrl="~/Img/Edit.gif"></asp:ImageButton>&nbsp;
                     <asp:ImageButton ID="Button2" runat="server" ImageUrl="~/Img/Delete.gif"
                         OnClientClick='<%# string.Format("fireConfirm({0}); return false;", Container.DataItemIndex) %>'></asp:ImageButton>
                    </div>
                </SelectedItemTemplate>
                <ItemTemplate>
                    <div class="rlvI albums" onclick='selectItem("<%# Container.DataItemIndex %>");'>
                        <telerik:RadBinaryImage runat="server" ResizeMode="Crop" CropPosition="Center" ID="RadBinaryImage1" DataValue='<%# Eval("Thumbnail") %>'
                            AutoAdjustImageControlSize="false"></telerik:RadBinaryImage>
                        <asp:Label ID="LabelTotalNumber" CssClass="count" runat="server" Text='<%# Eval("Images.Count") %>'></asp:Label>
                        <br />
                        <asp:Label ID="ProductNameLabel" runat="server" Text='<%# string.Format("Photos in {0}", Eval("Name")) %>'></asp:Label>
                        <br style="clear: both; display: block;" />
                        <asp:ImageButton ID="Button1" runat="server" CommandName="Edit" Style="clear: both;" ImageUrl="~/Img/Edit.gif"></asp:ImageButton>&nbsp;
                    <asp:ImageButton ID="Button2" runat="server"
                        OnClientClick='<%# string.Format("fireConfirm({0}); return false;", Container.DataItemIndex) %>'
                        ImageUrl="~/Img/Delete.gif"></asp:ImageButton>
                    </div>
                </ItemTemplate>
                <LayoutTemplate>
                    <div class="RadListView RadListViewFloated RadListView_Metro">
                        <asp:Button ID="Button1" runat="server" CommandName="InitInsert" Text="Add new album"></asp:Button>
                        <div class="rlvFloated rlvAutoScroll">
                            <div id="itemPlaceholder" runat="server">
                            </div>
                        </div>
                    </div>
                </LayoutTemplate>
                <EditItemTemplate>
                    <fieldset class="editTemplate">
                        <table cellpadding="0" cellspacing="2" style="height: 100%">
                            <tr>
                                <td style="width: 20%;">Name:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>' Width="120px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Display="Dynamic" runat="server" ErrorMessage="The Name is required"
                                        ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%;">Description:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Description") %>' Width="120px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%;">Change thumbnail:
                                </td>
                                <td style="width: 80%; padding-left: 5px;">
                                    <telerik:RadAsyncUpload runat="server" ID="RadAsyncUpload1" MaxFileInputsCount="1" AllowedFileExtensions="jpg,jpeg,png,gif">
                                    </telerik:RadAsyncUpload>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:ImageButton ID="Button1" Width="16px" Height="16px" CausesValidation="true" runat="server" CommandName="Update" text="Update"
                                        ImageUrl="~/Img/Update.gif"></asp:ImageButton>
                                    <asp:ImageButton ID="Button2" Width="16px" Height="16px" CausesValidation="false" runat="server" CommandName="Cancel" text="Cancel"
                                        ImageUrl="~/Img/Cancel.gif"></asp:ImageButton>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <fieldset class="editTemplate">
                        <table cellpadding="0" cellspacing="2" style="height: 100%">
                            <tr>
                                <td style="width: 50%;">Name:
                                </td>
                                <td style="width: 50%; padding-left: 5px;">
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>' Width="127px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ErrorMessage="The Name is required"
                                        ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%;">Description:
                                </td>
                                <td style="width: 50%; padding-left: 5px;">
                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Description") %>' Width="127px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%;">Upload thumbnail:
                                </td>
                                <td style="width: 50%; padding-left: 5px;">
                                    <telerik:RadAsyncUpload runat="server" MaxFileInputsCount="1" ID="RadAsyncUpload1" AllowedFileExtensions="jpg,jpeg,png,gif">
                                    </telerik:RadAsyncUpload>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 50%;">Upload zip with all album's images:
                                </td>
                                <td style="width: 50%; padding-left: 5px;">
                                    <telerik:RadAsyncUpload runat="server" MaxFileInputsCount="1" ID="RadAsyncUpload2" AllowedFileExtensions="zip">
                                    </telerik:RadAsyncUpload>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:ImageButton ID="Button1" Width="16px" Height="16px" runat="server" CausesValidation="true" CommandName="PerformInsert" text="Insert"
                                        ImageUrl="~/Img/Update.gif"></asp:ImageButton>
                                    <asp:ImageButton ID="Button2" Width="16px" Height="16px" runat="server" CausesValidation="false" CommandName="Cancel" text="Cancel"
                                        ImageUrl="~/Img/Cancel.gif"></asp:ImageButton>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </InsertItemTemplate>
            </telerik:RadListView>

            <br />
            <h1>All images from <asp:Label runat="server" ID="labelAlbumName"></asp:Label> album</h1>
            <telerik:RadListView runat="server" ID="ImagesListView"
                DataKeyNames="ID">
                <ItemTemplate>
                    <div class="rlvI imageHolder" onmouseout="imageDivMouseOut(this,event);" onmouseover="imageDivMouseOver(this);">
                        <telerik:RadBinaryImage runat="server" onclick='openWin(this);return false;' ID="RadBinaryImage1" DataValue='<%# Eval("Data") %>'
                            AutoAdjustImageControlSize="false" Height="200px" Width="200px"></telerik:RadBinaryImage>
                        <div class="floatingDiv" style="display: none;">
                            <asp:LinkButton runat="server" ID="DownloadImageButton" Text="Download" CommandName="DownloadImage"></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton1" runat="server" Text="Edit" CommandName="Edit"></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" Text="Delete" CommandName="Delete"></asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
                <EditItemTemplate>
                    <fieldset class="editTemplateSecond">
                        <table cellpadding="0" cellspacing="2" style="height: 100%">
                            <tr>
                                <td style="width: 50%;">Upload image:
                                </td>
                                <td style="width: 50%; padding-left: 5px;">
                                    <telerik:RadAsyncUpload runat="server" MaxFileInputsCount="1" ID="RadAsyncUpload1" AllowedFileExtensions="jpg,jpeg,png,gif">
                                    </telerik:RadAsyncUpload>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:ImageButton ID="Button1" Width="16px" Height="16px" CausesValidation="true" runat="server" CommandName="Update" text="Update"
                                        ImageUrl="~/Img/Update.gif"></asp:ImageButton>
                                    <asp:ImageButton ID="Button2" Width="16px" Height="16px" CausesValidation="false" runat="server" CommandName="Cancel" text="Cancel"
                                        ImageUrl="~/Img/Cancel.gif"></asp:ImageButton>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </EditItemTemplate>
                <LayoutTemplate>
                    <div class="RadListView RadListViewFloated RadListView_Metro" style="width: 1200px;">
                        <asp:Button ID="ButtonDownloadAllAsZip" runat="server"
                            CommandName="DownloadAllAsZip" Text="Download zip file with all images from current album"></asp:Button>
                        <div class="rlvFloated rlvAutoScroll">
                            <div id="itemPlaceholder" runat="server">
                            </div>
                        </div>
                    </div>
                </LayoutTemplate>
            </telerik:RadListView>
        </telerik:RadAjaxPanel>
    </form>
</body>
</html>
