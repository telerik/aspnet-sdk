using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
using NorthwindDAL;

namespace OrderCart
{	
	[Serializable]	
	[DataObject]
	public class Contractors
	{
		/// <summary>
		/// Holds the collection of customers.
		/// </summary>
		private List<Customer> customers;
		public List<Customer> Customers
		{
			get
			{
				if (customers != null)
				{
					return customers;
				}
				else
				{
					customers = new List<Customer>();
					return customers;
				}
			}
			set
			{
				customers = value;
			}
		}

		public Contractors()
		{
			CreateCustomers();
		}

		/// <summary>
		/// Fills the Customer collection with data.
		/// </summary>
		private void CreateCustomers()
		{
			NorthwindEntities model = new NorthwindEntities();
			var customers = from customer in model.Customers
							select customer;
			foreach (NorthwindDAL.Customer cust in customers)
			{
				Customers.Add(new Customer() {
					CustomerID = cust.CustomerID,
					ContactName = cust.ContactName,
					ContactTitle = cust.ContactTitle,
					CompanyName = cust.CompanyName
				});
			}			
		}		

		/// <summary>
		/// Updates the provided Customer object.
		/// </summary>
		/// <param name="customer">The customer which will be updated.</param>
		[DataObjectMethod(DataObjectMethodType.Update)]
		public void UpdateCustomer(Customer customer)
		{
			NorthwindEntities model = new NorthwindEntities();
			var customerToBeUpdated = (from cust in model.Customers
									  where cust.CustomerID == customer.CustomerID
									  select cust).FirstOrDefault();
			foreach (PropertyInfo property in customer.GetType().GetProperties())
			{
				customerToBeUpdated.GetType().GetProperty(property.Name).
					SetValue(customerToBeUpdated, property.GetValue(customer, new object[] { }), new object[] {});
			}
			model.SaveChanges();
			
		}

		/// <summary>
		/// Gets all the customers.
		/// </summary>
		/// <returns>Customers table.</returns>
		[DataObjectMethod(DataObjectMethodType.Select)]
		public List<Customer> GetAllCustomers()
		{
			return Customers;
		}

		/// <summary>
		/// Inserts a new customer.
		/// </summary>
		/// <param name="customer">Customer that will be inserted. </param>
		[DataObjectMethod(DataObjectMethodType.Insert)]		
		public void AddCustomer(Customer customer)
		{
			Customers.Add(customer);
			NorthwindEntities model = new NorthwindEntities();
			NorthwindDAL.Customer customerToBeInserted = new NorthwindDAL.Customer();
			var customerID = (from cust in model.Customers
							 where cust.CustomerID == customer.CustomerID
							 select cust).FirstOrDefault();
			if (customerID != null)
			{ return; }
			foreach (PropertyInfo property in customer.GetType().GetProperties())
			{
				customerToBeInserted.GetType().GetProperty(property.Name).
					SetValue(customerToBeInserted, property.GetValue(customer, new object[] { }), new object[] { });
			}
			model.Customers.AddObject(customerToBeInserted);
			model.SaveChanges();
		}

		/// <summary>
		/// Deletes a customer.
		/// </summary>
		/// <param name="customer">The Customer object which will be deleted.</param>
		[DataObjectMethod(DataObjectMethodType.Delete)]		
		public void DeleteCustomer(Customer customer)
		{
			Customers.Remove(customer);
			NorthwindEntities model = new NorthwindEntities();
			var custToBeDeleted = (from cust in model.Customers
								  where cust.CustomerID == customer.CustomerID
								  select cust).FirstOrDefault();
			model.Customers.DeleteObject(custToBeDeleted);
			model.SaveChanges();
		}		
	}
}
