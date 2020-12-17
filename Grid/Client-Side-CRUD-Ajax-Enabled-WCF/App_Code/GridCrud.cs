using System.Collections.Generic;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Web;
using System.Web.Script.Serialization;

[ServiceContract(Namespace = "")]
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
public class GridCrud
{
    #region RadGrid Client-Side CRUD
    #region DataSource
    private string _sessionKey = "MySessionKey";
    public List<Customer> SessionDataSource
    {
        get
        {
            if (HttpContext.Current.Session[_sessionKey] == null)
            {
                HttpContext.Current.Session[_sessionKey] = Enumerable.Range(1, 100).Select(
                cu => new Customer
                {
                    CustomerID = cu,
                    Address = "Address " + cu,
                    CompanyName = "CompanyName " + cu,
                    ContactName = "ContactName " + cu,
                    ContactTitle = "ContactTitle " + cu
                }
                ).ToList();
            }
            return (List<Customer>)HttpContext.Current.Session[_sessionKey];
        }
    }
    #endregion

    #region CRUD methods
    [WebGet]
    public CustomersResult GetCustomers()
    {
        System.Threading.Thread.Sleep(3000);
        return new CustomersResult
        {
            Data = SessionDataSource,
            Count = SessionDataSource.Count(),
            Action = "Read"
        };
    }

    [WebGet]
    public CustomersResult UpdateCustomers(string customersJSON)
    {
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        List<Customer> updatedCustomers = (List<Customer>)serializer.Deserialize(customersJSON, typeof(List<Customer>));

        foreach (Customer updatedCustomer in updatedCustomers)
        {
            Customer dbCustomer = SessionDataSource.FirstOrDefault(c => c.CustomerID == updatedCustomer.CustomerID);
            dbCustomer.CompanyName = updatedCustomer.CompanyName;
            dbCustomer.ContactName = updatedCustomer.ContactName;
            dbCustomer.ContactTitle = updatedCustomer.ContactTitle;
            dbCustomer.Address = updatedCustomer.Address;
        }

        return new CustomersResult()
        {
            Data = updatedCustomers,
            Count = updatedCustomers.Count,
            Action = "Update"
        };
    }

    [WebGet]
    public CustomersResult InsertCustomers(string customersJSON)
    {
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        List<Customer> insertedCustomers = (List<Customer>)serializer.Deserialize(customersJSON, typeof(List<Customer>));

        var lastId = SessionDataSource.Count > 0 ? SessionDataSource.Max(cu => cu.CustomerID) : 0;

        foreach (Customer insertedCustomer in insertedCustomers)
        {
            Customer newCustomer = new Customer()
            {
                CustomerID = lastId + 1,
                CompanyName = insertedCustomer.CompanyName,
                ContactName = insertedCustomer.ContactName,
                ContactTitle = insertedCustomer.ContactTitle,
                Address = insertedCustomer.Address
            };
            insertedCustomer.CustomerID = newCustomer.CustomerID;

            SessionDataSource.Add(newCustomer);
        }

        return new CustomersResult
        {
            Data = insertedCustomers,
            Count = insertedCustomers.Count,
            Action = "Create"
        };
    }

    [WebGet]
    public CustomersResult DeleteCustomers(string customersJSON)
    {
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        List<Customer> customers = (List<Customer>)serializer.Deserialize(customersJSON, typeof(List<Customer>));

        foreach (Customer removedCustomer in customers)
        {
            Customer customer = SessionDataSource.Find(c => c.CustomerID == removedCustomer.CustomerID);
            SessionDataSource.Remove(customer);
        }

        return new CustomersResult()
        {
            Data = customers,
            Count = customers.Count,
            Action = "Delete"
        };
    }
    #endregion
    #endregion
}
