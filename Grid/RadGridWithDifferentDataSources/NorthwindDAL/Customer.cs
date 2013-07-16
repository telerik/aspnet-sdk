using System;

namespace OrderCart
{
	[Serializable]
	public class Customer
	{
		public string CustomerID { get; set; }
		public string ContactName { get; set; }
		public string ContactTitle { get; set; }
		public string CompanyName { get; set; }
	}
}
