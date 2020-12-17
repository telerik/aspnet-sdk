using System.Collections.Generic;
using System.Runtime.Serialization;

#region Customer Model
[DataContract]
public class Customer
{
    [DataMember]
    public int CustomerID { get; set; }
    [DataMember]
    public string CompanyName { get; set; }
    [DataMember]
    public string ContactName { get; set; }
    [DataMember]
    public string ContactTitle { get; set; }
    [DataMember]
    public string Address { get; set; }
    [DataMember]
    public string __type { get; set; }
}
[DataContract]
public class CustomersResult
{
    [DataMember]
    public List<Customer> Data { get; set; }
    [DataMember]
    public int Count { get; set; }
    [DataMember]
    public string Action { get; set; }
    [DataMember]
    public string __type { get; set; }
}
#endregion