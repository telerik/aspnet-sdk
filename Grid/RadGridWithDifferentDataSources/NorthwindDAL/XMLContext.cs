using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace NorthwindDAL.Xml
{
	public class XMLContext
	{
		/// <summary>
		/// Load the source document
		/// </summary>
		/// <param name="path">Path to the source document</param>
		/// <returns>XDocument</returns>
		public XDocument LoadDocument(string path)
		{
			XDocument sourceDocument = XDocument.Load(path);
			return sourceDocument;
		}

		/// <summary>
		///     Get all the customers elements from the file
		/// </summary>
		/// <param name="sourceDocument">File that will be traversed.</param>
		/// <param name="tableName">The node that should be taken.</param>
		/// <returns>IEnumerable</returns>
		public IList<XElement> GetTable(XDocument document, XName tableName)
		{
			XElement table = document.Descendants(tableName).FirstOrDefault();
			return table.Elements().ToList();
		}

		/// <summary>
		/// Deletes an element from the datasource.
		/// </summary>
		/// <param name="table">The table from which the element should be deleted.</param>
		/// <param name="element">The element should be deleted.</param>
		public void DeleteElement(IList<XElement> table, XElement element)
		{
			//XElement orderToDelete = (from order in table
			//where order.Attribute(element.Attributes().FirstOrDefault().Name).Value == element.Attributes().FirstOrDefault().Value
			//select order).FirstOrDefault();
			table.Remove(element);
			//orderToDelete.Remove();
		}

		/// <summary>
		/// Save the changes to the specified document
		/// </summary>
		/// <param name="sourceDocument">Path where the document will be saved</param>
		/// <param name="path">Path to the file where the changes will be saved</param>
		public void SaveChanges(XDocument sourceDocument, string path)
		{
			sourceDocument.Save(path);
		}

		/// <summary>
		/// Updates an element from the datasource.
		/// </summary>
		/// <param name="table"></param>
		/// <param name="element"></param>
		public void UpdateElement(IList<XElement> table, XElement element)
		{
			XElement orderToUpdate = (from order in table
									  where order.Attribute(element.Attributes().FirstOrDefault().Name).Value == element.Attributes().FirstOrDefault().Value
									  select order).FirstOrDefault();
			foreach (XElement el in orderToUpdate.Descendants())
			{
				el.Value = element.Element(el.Name).Value;
			}
		}

		/// <summary>
		/// Inserts an element to the datasource.
		/// </summary>
		/// <param name="document"></param>
		/// <param name="element"></param>
		/// <param name="entity"></param>
		public void InsertElement(XDocument document, XElement element, string entity)
		{
			XElement parentEntity = document.Descendants(entity).FirstOrDefault();
			parentEntity.Add(element);
		}
	}
}
