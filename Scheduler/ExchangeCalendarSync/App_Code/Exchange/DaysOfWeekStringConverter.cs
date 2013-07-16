using System.Text;
using Telerik.Web.UI;

namespace Telerik.Web.Examples.Scheduler.Exchange
{
	public static class DaysOfWeekStringConverter
	{
		public static string ConvertFromRecurrenceDay(RecurrenceDay recurrenceDay, bool useWildcards)
		{
			if (useWildcards)
			{
				if ((recurrenceDay & RecurrenceDay.EveryDay) == RecurrenceDay.EveryDay)
				{
					return "Day";
				}

				if ((recurrenceDay & RecurrenceDay.WeekDays) == RecurrenceDay.WeekDays)
				{
					return "Weekday";
				}

				if ((recurrenceDay & RecurrenceDay.WeekendDays) == RecurrenceDay.WeekendDays)
				{
					return "WeekendDay";
				}
			}

			StringBuilder result = new StringBuilder();

			if ((recurrenceDay & RecurrenceDay.Monday) == RecurrenceDay.Monday)
			{
				result.Append("Monday ");
			}

			if ((recurrenceDay & RecurrenceDay.Tuesday) == RecurrenceDay.Tuesday)
			{
				result.Append("Tuesday ");
			}

			if ((recurrenceDay & RecurrenceDay.Wednesday) == RecurrenceDay.Wednesday)
			{
				result.Append("Wednesday ");
			}

			if ((recurrenceDay & RecurrenceDay.Thursday) == RecurrenceDay.Thursday)
			{
				result.Append("Thursday ");
			}

			if ((recurrenceDay & RecurrenceDay.Friday) == RecurrenceDay.Friday)
			{
				result.Append("Friday ");
			}

			if ((recurrenceDay & RecurrenceDay.Saturday) == RecurrenceDay.Saturday)
			{
				result.Append("Saturday ");
			}

			if ((recurrenceDay & RecurrenceDay.Sunday) == RecurrenceDay.Sunday)
			{
				result.Append("Sunday ");
			}


			return result.ToString().Trim();
		}

		public static RecurrenceDay ConvertToRecurrenceDay(string daysOfWeek)
		{
			RecurrenceDay finalMask = RecurrenceDay.None;
			foreach (string day in daysOfWeek.Split(' '))
			{
				switch (day)
				{
					case "Monday":
						finalMask |= RecurrenceDay.Monday;
						break;

					case "Tuesday":
						finalMask |= RecurrenceDay.Tuesday;
						break;

					case "Wednesday":
						finalMask |= RecurrenceDay.Wednesday;
						break;

					case "Thursday":
						finalMask |= RecurrenceDay.Thursday;
						break;

					case "Friday":
						finalMask |= RecurrenceDay.Friday;
						break;

					case "Saturday":
						finalMask |= RecurrenceDay.Saturday;
						break;

					case "Sunday":
						finalMask |= RecurrenceDay.Sunday;
						break;

					case "WeekendDay":
						finalMask |= RecurrenceDay.WeekendDays;
						break;

					case "Weekday":
						finalMask |= RecurrenceDay.WeekDays;
						break;

					case "Day":
						finalMask |= RecurrenceDay.EveryDay;
						break;
				}
			}
			return finalMask;
		}
	}
}