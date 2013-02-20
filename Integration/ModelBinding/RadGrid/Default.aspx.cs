using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;


public partial class _Default : System.Web.UI.Page
{
    DataClassesDataContext context = new DataClassesDataContext();

    public IQueryable<Product> GetProducts([Control("RadComboBoxCategories")] int? categoryValue)
    {
        if (categoryValue.HasValue)
        {
            return from p in context.Products
                   where p.CategoryID == categoryValue
                   select p;
        }

        return from p in context.Products
               select p;
    }

    public void UpdateProduct(int ProductID)
    {
        Product updatedProduct = context.Products.Where(p => p.ProductID == ProductID).First();
        TryUpdateModel(updatedProduct);

        if (ModelState.IsValid)
        {
            context.SubmitChanges();
            MessageLabel.Text = string.Format("Product with ID {0} is updated!", ProductID);
        }
    }

    public void InsertProduct(Product p)
    {
        if (ModelState.IsValid)
        {
            context.Products.InsertOnSubmit(p);
            context.SubmitChanges();
            MessageLabel.Text = "New product is inserted!";
        }
    }

    public void DeleteProduct(int ProductID)
    {
        Product deletedProduct = context.Products.Where(p => p.ProductID == ProductID).First();
        context.Products.DeleteOnSubmit(deletedProduct);
        context.SubmitChanges();
        MessageLabel.Text = string.Format("Product with ID {0} is deleted!", ProductID);
    }

    public IQueryable<Category> GetCategories()
    {
        return from c in context.Categories
               select c;
    }

    protected void RadComboBoxCategories_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadGrid1.Rebind();
    }
}