<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DefaultCS.aspx.cs" Inherits="Telerik.PivotGrid.Examples.Templates.DefaultCS"
    MasterPageFile="~/MasterPage.master" %>

<%@ Register TagPrefix="qsf" Namespace="Telerik.QuickStart" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register Src="TemplateInfoCS.ascx" TagName="TemplateInfo" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .templateContainer
        {
            cursor: pointer;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadAjaxPanel ID="radAjaxPanel1" runat="server" LoadingPanelID="RadAjaxLoadingPanel1">
        <telerik:RadPivotGrid AllowPaging="true" PageSize="14" ID="RadPivotGrid1" runat="server"
            OnNeedDataSource="RadPivotGrid1_NeedDataSource">
            <ClientSettings EnableFieldsDragDrop="true">
            </ClientSettings>
            <Fields>
                <%-- ROW FIELDS --%>
                <telerik:PivotGridRowField DataField="Category">
                    <CellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="CellTemplate" />
                    </CellTemplate>
                    <TotalHeaderCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="TotalHeaderCellTemplate" />
                    </TotalHeaderCellTemplate>
                </telerik:PivotGridRowField>
                <telerik:PivotGridRowField DataField="ProductName">
                    <CellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="CellTemplate" />
                    </CellTemplate>
                    <TotalHeaderCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="TotalHeaderCellTemplate" />
                    </TotalHeaderCellTemplate>
                </telerik:PivotGridRowField>
                <%-- COLUMN FIELDS --%>
                <telerik:PivotGridColumnField DataField="Year">
                    <CellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="CellTemplate" />
                    </CellTemplate>
                    <TotalHeaderCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="TotalHeaderCellTemplate" />
                    </TotalHeaderCellTemplate>
                </telerik:PivotGridColumnField>
                <telerik:PivotGridColumnField DataField="Quarter">
                    <CellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="CellTemplate" />
                    </CellTemplate>
                    <TotalHeaderCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="TotalHeaderCellTemplate" />
                    </TotalHeaderCellTemplate>
                </telerik:PivotGridColumnField>
                <%-- AGGREGATE FIELDS --%>
                <telerik:PivotGridAggregateField DataField="TotalPrice" Aggregate="Sum">
                    <CellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="CellTemplate" />
                    </CellTemplate>
                    <ColumnGrandTotalCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="ColumnGrandTotalCellTemplate" />
                    </ColumnGrandTotalCellTemplate>
                    <ColumnGrandTotalHeaderCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="ColumnGrandTotalHeaderCellTemplate" />
                    </ColumnGrandTotalHeaderCellTemplate>
                    <ColumnTotalCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="ColumnTotalCellTemplate" />
                    </ColumnTotalCellTemplate>
                    <HeaderCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="HeaderCellTemplate" />
                    </HeaderCellTemplate>
                    <RowAndColumnGrandTotalCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="RowAndColumnGrandTotalCellTemplate" />
                    </RowAndColumnGrandTotalCellTemplate>
                    <RowAndColumnTotalCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="RowAndColumnTotalCellTemplate" />
                    </RowAndColumnTotalCellTemplate>
                    <RowGrandTotalCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="RowGrandTotalCellTemplate" />
                    </RowGrandTotalCellTemplate>
                    <RowGrandTotalHeaderCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="RowGrandTotalHeaderCellTemplate" />
                    </RowGrandTotalHeaderCellTemplate>
                    <RowTotalCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="RowTotalCellTemplate" />
                    </RowTotalCellTemplate>
                </telerik:PivotGridAggregateField>
                <telerik:PivotGridAggregateField DataField="Quantity" Aggregate="Sum">
                    <CellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="CellTemplate" />
                    </CellTemplate>
                    <ColumnGrandTotalCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="ColumnGrandTotalCellTemplate" />
                    </ColumnGrandTotalCellTemplate>
                    <ColumnGrandTotalHeaderCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="ColumnGrandTotalHeaderCellTemplate" />
                    </ColumnGrandTotalHeaderCellTemplate>
                    <ColumnTotalCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="ColumnTotalCellTemplate" />
                    </ColumnTotalCellTemplate>
                    <HeaderCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="HeaderCellTemplate" />
                    </HeaderCellTemplate>
                    <RowAndColumnGrandTotalCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="RowAndColumnGrandTotalCellTemplate" />
                    </RowAndColumnGrandTotalCellTemplate>
                    <RowAndColumnTotalCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="RowAndColumnTotalCellTemplate" />
                    </RowAndColumnTotalCellTemplate>
                    <RowGrandTotalCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="RowGrandTotalCellTemplate" />
                    </RowGrandTotalCellTemplate>
                    <RowGrandTotalHeaderCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="RowGrandTotalHeaderCellTemplate" />
                    </RowGrandTotalHeaderCellTemplate>
                    <RowTotalCellTemplate>
                        <uc1:TemplateInfo ID="TemplateInfo1" runat="server" TemplateName="RowTotalCellTemplate" />
                    </RowTotalCellTemplate>
                </telerik:PivotGridAggregateField>
            </Fields>
        </telerik:RadPivotGrid>
    </telerik:RadAjaxPanel>
</asp:Content>
