<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
    <link href="Skins/Vista/Menu.Vista.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <%--Needed for JavaScript IntelliSense in VS2010--%>
                <%--For VS2008 replace RadScriptManager with ScriptManager--%>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </telerik:RadScriptManager>
        <script type="text/javascript">
            //Put your JavaScript code here.
        </script>
        <div>
            <telerik:RadMenu ID="RadMenu1" runat="server" EnableEmbeddedSkins="false" Skin="Vista">
                <Items>
                    <telerik:RadMenuItem runat="server" Text="Home">
                        <Items>
                            <telerik:RadMenuItem CssClass="Products" Width="640px">
                                <ItemTemplate>
                                    <div id="CatWrapper" class="Wrapper" style="width: 435px;">
                                        <h3>Categories</h3>
                                        <telerik:RadSiteMap ID="RadSiteMap1" runat="server" Skin="Hay">
                                            <LevelSettings>
                                                <telerik:SiteMapLevelSetting Level="0">
                                                    <ListLayout RepeatColumns="3" RepeatDirection="Vertical" />
                                                </telerik:SiteMapLevelSetting>
                                            </LevelSettings>
                                            <Nodes>
                                                <telerik:RadSiteMapNode NavigateUrl="#" Text="Furniture">
                                                    <Nodes>
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Tables & Chairs" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Sofas" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Occasional Furniture" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Childerns Furniture" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Beds" />
                                                    </Nodes>
                                                </telerik:RadSiteMapNode>
                                                <telerik:RadSiteMapNode NavigateUrl="#" Text="Decor">
                                                    <Nodes>
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Bed Linen" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Throws" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Curtains & Blinds" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Rugs" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Carpets" />
                                                    </Nodes>
                                                </telerik:RadSiteMapNode>
                                                <telerik:RadSiteMapNode NavigateUrl="#" Text="Storage">
                                                    <Nodes>
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Wall Shelving" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Kids Storage" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Baskets" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Multimedia Storage" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Floor Shelving" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Toilet Roll Holders" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Storage Jars" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Drawers" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Boxes" />
                                                    </Nodes>
                                                </telerik:RadSiteMapNode>
                                                <telerik:RadSiteMapNode NavigateUrl="#" Text="Lights">
                                                    <Nodes>
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Ceiling" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Table" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Floor" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Shades" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Wall Lights" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Spotlights" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="Push Light" />
                                                        <telerik:RadSiteMapNode NavigateUrl="#" Text="String Lights" />
                                                    </Nodes>
                                                </telerik:RadSiteMapNode>
                                            </Nodes>
                                        </telerik:RadSiteMap>
                                    </div>
                                    <div id="FeatProduct">
                                        <h3>Featured</h3>
                                        <img src="Img/lamp.jpg" alt="Deco Mirror Table Lamp - $ 24.99" width="128px" height="150px" />
                                        <p>
                                            Deco Mirror Table Lamp
                                        <br />
                                            <span class="price">$ 24.99</span>
                                        </p>
                                    </div>
                                </ItemTemplate>
                            </telerik:RadMenuItem>
                        </Items>
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Text="Customers">
                    </telerik:RadMenuItem>
                    <telerik:RadMenuItem runat="server" Text="Employees">
                    </telerik:RadMenuItem>
                </Items>

            </telerik:RadMenu>
        </div>
    </form>
</body>
</html>
