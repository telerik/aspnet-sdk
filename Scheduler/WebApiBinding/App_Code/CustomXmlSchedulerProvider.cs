using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Telerik.Web.UI;
using System.Text;
using System.Linq.Expressions;

/// <summary>
/// Summary description for CustomXmlSchedulerProvider
/// </summary>
public class CustomXmlSchedulerProvider : XmlSchedulerProvider
{
	public CustomXmlSchedulerProvider(string dataFileName, bool persistChanges)
		: base(dataFileName, persistChanges)
	{

	}

	public override IEnumerable<Appointment> GetAppointments(ISchedulerInfo schedulerInfo)
	{
		var myInfo = schedulerInfo as MySchedulerInfo;
        if (myInfo !=null && myInfo.CategoryNames != null)
		{
			var appointmentsList = base.GetAppointments(schedulerInfo);
			var appointmentsWithCalendarResource = appointmentsList.Where(a => a.Resources.GetResourceByType("Calendar") != null).Select(a => a);

			var predicate = PredicateBuilder.False<Appointment>();

			foreach (string categoryName in myInfo.CategoryNames)
			{
				string temp = categoryName;
				predicate = predicate.Or(a => a.Resources.GetResourceByType("Calendar").Text == temp);
			}

			return appointmentsWithCalendarResource.AsQueryable().Where(predicate).Select(a => a).AsEnumerable();
		}
		else
		{
			return base.GetAppointments(schedulerInfo);
		}

	}
}

public static class PredicateBuilder
{
	public static Expression<Func<T, bool>> True<T>() { return f => true; }
	public static Expression<Func<T, bool>> False<T>() { return f => false; }

	public static Expression<Func<T, bool>> Or<T>(this Expression<Func<T, bool>> expr1,
														Expression<Func<T, bool>> expr2)
	{
		var invokedExpr = Expression.Invoke(expr2, expr1.Parameters.Cast<Expression>());
		return Expression.Lambda<Func<T, bool>>
			  (Expression.OrElse(expr1.Body, invokedExpr), expr1.Parameters);
	}

	public static Expression<Func<T, bool>> And<T>(this Expression<Func<T, bool>> expr1,
														 Expression<Func<T, bool>> expr2)
	{
		var invokedExpr = Expression.Invoke(expr2, expr1.Parameters.Cast<Expression>());
		return Expression.Lambda<Func<T, bool>>
			  (Expression.AndAlso(expr1.Body, invokedExpr), expr1.Parameters);
	}
}