using Telerik.Web.UI;

namespace Telerik.Web.Examples.Scheduler.Exchange
{
	public static class DayOfWeekConverter
	{
		public static DayOfWeekType ConvertFromRecurrenceDay(RecurrenceDay recurrenceDay)
		{
			switch (recurrenceDay)
			{
				case RecurrenceDay.Monday:
					return DayOfWeekType.Monday;

				case RecurrenceDay.Tuesday:
					return DayOfWeekType.Tuesday;

				case RecurrenceDay.Wednesday:
					return DayOfWeekType.Wednesday;

				case RecurrenceDay.Thursday:
					return DayOfWeekType.Thursday;

				case RecurrenceDay.Friday:
					return DayOfWeekType.Friday;

				case RecurrenceDay.Saturday:
					return DayOfWeekType.Saturday;

				case RecurrenceDay.Sunday:
					return DayOfWeekType.Sunday;

				case RecurrenceDay.EveryDay:
					return DayOfWeekType.Day;

				case RecurrenceDay.WeekDays:
					return DayOfWeekType.Weekday;

				case RecurrenceDay.WeekendDays:
					return DayOfWeekType.WeekendDay;
			}

			return DayOfWeekType.Day;
		}

		public static RecurrenceDay ConvertToRecurrenceDay(DayOfWeekType dayOfWeek)
		{
			switch (dayOfWeek)
			{
				case DayOfWeekType.Monday:
					return RecurrenceDay.Monday;

				case DayOfWeekType.Tuesday:
					return RecurrenceDay.Tuesday;

				case DayOfWeekType.Wednesday:
					return RecurrenceDay.Wednesday;

				case DayOfWeekType.Thursday:
					return RecurrenceDay.Thursday;

				case DayOfWeekType.Friday:
					return RecurrenceDay.Friday;

				case DayOfWeekType.Saturday:
					return RecurrenceDay.Saturday;

				case DayOfWeekType.Sunday:
					return RecurrenceDay.Sunday;

				case DayOfWeekType.Day:
					return RecurrenceDay.EveryDay;

				case DayOfWeekType.Weekday:
					return RecurrenceDay.WeekDays;

				case DayOfWeekType.WeekendDay:
					return RecurrenceDay.WeekendDays;
			}

			return RecurrenceDay.None;
		}
	}
}