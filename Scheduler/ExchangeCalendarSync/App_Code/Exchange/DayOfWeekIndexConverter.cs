namespace Telerik.Web.Examples.Scheduler.Exchange
{
	public static class DayOfWeekIndexConverter
	{
		public static DayOfWeekIndexType ConvertFromDayOrdinal(int dayOrdinal)
		{
			switch (dayOrdinal)
			{
				case 1:
					return DayOfWeekIndexType.First;

				case 2:
					return DayOfWeekIndexType.Second;

				case 3:
					return DayOfWeekIndexType.Third;

				case 4:
					return DayOfWeekIndexType.Fourth;

				case -1:
					return DayOfWeekIndexType.Last;
			}

			return DayOfWeekIndexType.First;
		}

		public static int ConvertToDayOrdinal(DayOfWeekIndexType dayOfWeekIndex)
		{
			switch (dayOfWeekIndex)
			{
				case DayOfWeekIndexType.First:
					return 1;

				case DayOfWeekIndexType.Second:
					return 2;

				case DayOfWeekIndexType.Third:
					return 3;

				case DayOfWeekIndexType.Fourth:
					return 4;

				case DayOfWeekIndexType.Last:
					return -1;
			}

			return 0;
		}
	}
}