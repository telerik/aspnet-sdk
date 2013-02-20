using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;


public partial class _Default : System.Web.UI.Page
{
    DataClassesDataContext context = new DataClassesDataContext();

    public IQueryable<Employee> GetProducts()
    {
        return from e in context.Employees
               select e;
    }

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);

        if (!IsPostBack)
        {
            RadTreeList1.ExpandToLevel(1);
        }
    }

    public void UpdateProduct(int EmployeeID)
    {
        Employee updatedEmployee = context.Employees.Where(e=>e.EmployeeID == EmployeeID).First();
        TryUpdateModel(updatedEmployee);

        if (ModelState.IsValid)
        {
            context.SubmitChanges();
            MessageLabel.Text = string.Format("Employee with ID {0} is updated!", EmployeeID);
        }
    }

    public void InsertProduct(Employee e)
    {
        if (ModelState.IsValid)
        {
            context.Employees.InsertOnSubmit(e);
            context.SubmitChanges();
            MessageLabel.Text = "New Employee is inserted!";
        }
    }

    public void DeleteProduct(int EmployeeID)
    {
        Employee deletedEmployee = context.Employees.Where(e => e.EmployeeID == EmployeeID).First();
        context.Employees.DeleteOnSubmit(deletedEmployee);
        context.SubmitChanges();
        MessageLabel.Text = string.Format("Employee with ID {0} is deleted!", EmployeeID);
    }
}