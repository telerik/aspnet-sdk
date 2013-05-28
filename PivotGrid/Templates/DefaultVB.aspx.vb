
Imports System
Imports System.Collections.Generic
Imports System.Configuration
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports System.Web.UI
Imports Telerik.Web.UI
Imports LinqToSqlReadOnly
Imports System.Linq

Namespace Telerik.PivotGrid.Examples.Templates

    Partial Public MustInherit Class DefaultVB
        Inherits System.Web.UI.Page

        Private dataContext As NorthwindReadOnlyDataContext

        Protected ReadOnly Property DbContext() As NorthwindReadOnlyDataContext
            Get
                If dataContext Is Nothing Then
                    dataContext = New NorthwindReadOnlyDataContext()
                End If
                Return dataContext
            End Get
        End Property

        Protected Sub RadPivotGrid1_NeedDataSource(sender As Object, e As PivotGridNeedDataSourceEventArgs) Handles RadPivotGrid1.NeedDataSource
            Dim orderDetails = From o In DbContext.Orders _
                               Join od In DbContext.Order_Details On o.OrderID Equals od.OrderID _
                               Join p In DbContext.Products On od.ProductID Equals p.ProductID _
            Where (o.OrderDate.Value.Year >= 1997) _
            Select Year = o.OrderDate.Value.Year, _
            Quarter = "Quarter " & CType((o.OrderDate.Value.Month / 4) + 1, Integer), _
            ProductName = p.ProductName, _
            Category = p.Category.CategoryName, _
            TotalPrice = od.UnitPrice * od.Quantity, _
            Quantity = od.Quantity

            RadPivotGrid1.DataSource = orderDetails

        End Sub
    End Class
End Namespace