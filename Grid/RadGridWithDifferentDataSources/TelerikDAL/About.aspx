<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
CodeFile="About.aspx.cs" Inherits="About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
	<h2>
		About
	</h2>
	<p>
		The purpose of the project is to illustrate how you could use RadGrid or any other
		databound control with the different options for binding like Entity Framework, LinqToSql,
		OpenAccess, XML, and custom classes.
		<br />
		<br />
		<a href="RadGridBoundToXmlDocument.aspx">RadGrid with manual CRUD operations with XML document.</a>
		<br />
		<a href="RadGridWithCustomObject.aspx">RadGrid with manual CRUD operations with custom class.</a>
		<br />
		<a href="RadGridWithEntityDataSource.aspx">RadGrid with automatic CRUD operations with EntityDataSource control.</a>
		<br />
		<a href="RadGridWithEntityManualCRUD.aspx">RadGrid with manual CRUD operations with Entity Framework.</a>
		<br />
		<a href="RadGridWithLinqToSqlDataSource.aspx">RadGrid with automatic CRUD operations with LinqDataSource.</a>
		<br />
		<a href="RadGridWithLinqToSqlManualCRUD.aspx">RadGrid with manual CRUD operations with LinqToSql.</a>
		<br />
		<a href="RadGridWithNeedDataSourceAndOpenAccess.aspx">RadGrid with manual CRUD operations with OpenAccess.</a>
		<br />
		<a href="RadGridWithObjectDataSource.aspx">RadGrid with automatic CRUD operations with ObjectDataSource control.</a>
		<br />
		<a href="RadGridWithOpenAccessLinqDataSource.aspx">RadGrid with automatic CRUD operations with OpenaAccessLinqDataSource.</a>
		<br />
	</p>
</asp:Content>
