
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Web.UI;
using Telerik.Web.UI;
using LinqToSqlReadOnly;
using System.Linq;

namespace Telerik.PivotGrid.Examples.Templates
{
    public partial class DefaultCS : System.Web.UI.Page
    {
        private NorthwindReadOnlyDataContext dataContext;

        protected NorthwindReadOnlyDataContext DbContext
        {
            get
            {
                if (dataContext == null)
                {
                    dataContext = new NorthwindReadOnlyDataContext();
                }
                return dataContext;
            }
        }

        protected void RadPivotGrid1_NeedDataSource(object sender, PivotGridNeedDataSourceEventArgs e)
        {
            var orderDetails = from o in DbContext.Orders
                               join od in DbContext.Order_Details on o.OrderID equals od.OrderID
                               join p in DbContext.Products on od.ProductID equals p.ProductID
                               where o.OrderDate.Value.Year >= 1997
                               select new
                               {
                                   Year = o.OrderDate.Value.Year,
                                   Quarter = "Quarter " + ((o.OrderDate.Value.Month / 4) + 1),
                                   ProductName = p.ProductName,
                                   Category = p.Category.CategoryName,
                                   TotalPrice = od.UnitPrice * od.Quantity,
                                   Quantity = od.Quantity
                               };
            RadPivotGrid1.DataSource = orderDetails;
        }
    }
}