<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TemplateInfoCS.ascx.cs"
    Inherits="PivotGrid_Examples_Templates_TemplateInfoCS" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Label ID="Label1" runat="server" Text='<%# GetCellText() %>' CssClass="templateContainer" />
<telerik:RadToolTip ID="RadToolTip1" runat="server" TargetControlID="Label1" ShowEvent="OnClick"
    Text='<%# GetToolTipContent() %>' />
