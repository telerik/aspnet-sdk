<%@ Control Language="VB" AutoEventWireup="false" CodeFile="TemplateInfoVB.ascx.vb"
    Inherits="PivotGrid_Examples_Templates_TemplateInfoVB" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Label ID="Label1" runat="server" Text='<%# GetCellText() %>' CssClass="templateContainer" />
<telerik:RadToolTip ID="RadToolTip1" runat="server" TargetControlID="Label1" ShowEvent="OnClick"
    Text='<%# GetToolTipContent() %>' />
