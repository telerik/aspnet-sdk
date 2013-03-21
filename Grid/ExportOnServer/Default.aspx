<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default"
    EnableViewState="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Styles/styles.css" rel="Stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" />
    <div class="gridBack">
        <div class="divPanel">
            <div style="float: left" class="exportedFileInfo">
                <asp:Label ID="LastExportedDate" runat="server"></asp:Label>
            </div>
            <div style="float: right">
                <telerik:RadComboBox ID="RadComboBox1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="RadComboBox1_SelectedIndexChanged">
                    <Items>
                        <telerik:RadComboBoxItem Text="Export to Excel" Value="XLS" Selected="true" />
                        <telerik:RadComboBoxItem Text="Export to PDF" Value="PDF" />
                        <telerik:RadComboBoxItem Text="Export to Word" Value="DOC" />
                        <telerik:RadComboBoxItem Text="Export to CSV" Value="CSV" />
                    </Items>
                </telerik:RadComboBox>
            </div>
            <div style="clear: both">
            </div>
            <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="XmlDataSource1" Width="615px"
                OnGridExporting="RadGrid1_GridExporting" AutoGenerateColumns="false">
                <MasterTableView>
                    <Columns>
                        <telerik:GridBoundColumn DataField="Id" HeaderText="ID">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Name" HeaderText="Name">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Age" HeaderText="Age">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="IsActive" HeaderText="Is Active">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
        <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="demoDB.xml" />
        <asp:LinkButton ID="ButtonExport" runat="server" Text="GENERATE FILE" OnClick="ButtonExport_Click"
            CssClass="linkBtnStyle" />
        <asp:HyperLink ID="FileHyperLink" runat="server" Text="CLICK HERE TO OPEN THE FILE"
            Visible="false" CssClass="linkBtnStyle"></asp:HyperLink>
        <asp:LinkButton ID="FileStream" runat="server" Text="CLICK HERE TO DOWNLOAD THE FILE"
            OnClick="FileStream_Click" CssClass="linkBtnStyle" Visible="false" />
    </div>
    </form>
</body>
</html>
