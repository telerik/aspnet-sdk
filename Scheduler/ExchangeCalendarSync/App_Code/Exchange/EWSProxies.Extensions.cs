using System;
using System.Text.RegularExpressions;
using System.Xml.Serialization;
using Telerik.Web.UI;

namespace Telerik.Web.Examples.Scheduler.Exchange
{
	public partial class TimeZoneType
	{
		[XmlIgnore]
		public TimeSpan BaseOffsetParsed
		{
			get
			{
				if (string.IsNullOrEmpty(BaseOffset))
				{
					return TimeSpan.Zero;
				}

				// RFC 2445 section 4.3.6
				//
				// dur-value  = (["+"] / "-") "P" (dur-date / dur-time / dur-week)
				// dur-date   = dur-day [dur-time]
				// dur-time   = "T" (dur-hour / dur-minute / dur-second)
				// dur-week   = 1*DIGIT "W"
				// dur-hour   = 1*DIGIT "H" [dur-minute]
				// dur-minute = 1*DIGIT "M" [dur-second]
				// dur-second = 1*DIGIT "S"
				// dur-day    = 1*DIGIT "D"

				const string durationRegex = @"([\+\-])?(P)(?:(?:(\d+)W)?(?:(\d+)D)?)?(?:T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?)?";
				Match durationMatch = Regex.Match(BaseOffset, durationRegex);
				if (durationMatch.Success)
				{
					TimeSpan value = TimeSpan.Zero;

					int sign = durationMatch.Groups[1].Value == "-" ? -1 : 1;

					int weeks;
					if (int.TryParse(durationMatch.Groups[3].Value, out weeks))
					{
						value += TimeSpan.FromDays(sign*7*weeks);
					}

					int days;
					if (int.TryParse(durationMatch.Groups[4].Value, out days))
					{
						value += TimeSpan.FromDays(sign*days);
					}

					int hours;
					if (int.TryParse(durationMatch.Groups[5].Value, out hours))
					{
						value += TimeSpan.FromHours(sign*hours);
					}

					int minutes;
					if (int.TryParse(durationMatch.Groups[6].Value, out minutes))
					{
						value += TimeSpan.FromMinutes(sign*minutes);
					}

					int seconds;
					if (int.TryParse(durationMatch.Groups[7].Value, out seconds))
					{
						value += TimeSpan.FromMinutes(sign*seconds);
					}

					return value;
				}

				return TimeSpan.Zero;
			}
		}
	}

	public partial class RecurrencePatternBaseType
	{
		public abstract RecurrencePattern ConvertToRecurrencePattern();

		public static RecurrencePatternBaseType CreateFromSchedulerRecurrencePattern(RecurrencePattern schedulerPattern)
		{
			if (schedulerPattern.Frequency == RecurrenceFrequency.Daily)
			{
				if (schedulerPattern.DaysOfWeekMask == RecurrenceDay.EveryDay)
				{
					DailyRecurrencePatternType pattern = new DailyRecurrencePatternType();
					pattern.Interval = schedulerPattern.Interval;
					return pattern;
				}
				else
				{
					WeeklyRecurrencePatternType pattern = new WeeklyRecurrencePatternType();
					pattern.Interval = 1; // Interval is ignored in this case.
					pattern.DaysOfWeek = DaysOfWeekStringConverter.ConvertFromRecurrenceDay(schedulerPattern.DaysOfWeekMask, false);
					return pattern;
				}
			}

			if (schedulerPattern.Frequency == RecurrenceFrequency.Weekly)
			{
				WeeklyRecurrencePatternType pattern = new WeeklyRecurrencePatternType();
				pattern.Interval = schedulerPattern.Interval;
				pattern.DaysOfWeek = DaysOfWeekStringConverter.ConvertFromRecurrenceDay(schedulerPattern.DaysOfWeekMask, false);
				return pattern;
			}

			if (schedulerPattern.Frequency == RecurrenceFrequency.Monthly)
			{
				if (schedulerPattern.DayOfMonth > 0)
				{
					AbsoluteMonthlyRecurrencePatternType pattern = new AbsoluteMonthlyRecurrencePatternType();
					pattern.Interval = schedulerPattern.Interval;
					pattern.DayOfMonth = schedulerPattern.DayOfMonth;
					return pattern;
				}
				else
				{
					RelativeMonthlyRecurrencePatternType pattern = new RelativeMonthlyRecurrencePatternType();
					pattern.Interval = schedulerPattern.Interval;
					pattern.DayOfWeekIndex = DayOfWeekIndexConverter.ConvertFromDayOrdinal(schedulerPattern.DayOrdinal);
					pattern.DaysOfWeek = DayOfWeekConverter.ConvertFromRecurrenceDay(schedulerPattern.DaysOfWeekMask);
					return pattern;
				}
			}

			if (schedulerPattern.Frequency == RecurrenceFrequency.Yearly)
			{
				if (schedulerPattern.DayOfMonth > 0)
				{
					AbsoluteYearlyRecurrencePatternType pattern = new AbsoluteYearlyRecurrencePatternType();
					pattern.Month = (MonthNamesType) Enum.Parse(typeof(MonthNamesType), schedulerPattern.Month.ToString());
					pattern.DayOfMonth = schedulerPattern.DayOfMonth;
					return pattern;
				}
				else
				{
					RelativeYearlyRecurrencePatternType pattern = new RelativeYearlyRecurrencePatternType();
					pattern.Month = (MonthNamesType) Enum.Parse(typeof(MonthNamesType), schedulerPattern.Month.ToString());
					pattern.DayOfWeekIndex = DayOfWeekIndexConverter.ConvertFromDayOrdinal(schedulerPattern.DayOrdinal);
					pattern.DaysOfWeek = DaysOfWeekStringConverter.ConvertFromRecurrenceDay(schedulerPattern.DaysOfWeekMask, true);
					return pattern;
				}
			}

			return null;
		}
	}

	public partial class DailyRecurrencePatternType
	{
		public override RecurrencePattern ConvertToRecurrencePattern()
		{
			RecurrencePattern pattern = new RecurrencePattern();
			pattern.Frequency = RecurrenceFrequency.Daily;
			pattern.Interval = Interval;
			pattern.DaysOfWeekMask = RecurrenceDay.EveryDay;
			return pattern;
		}
	}

	public partial class WeeklyRecurrencePatternType
	{
		public override RecurrencePattern ConvertToRecurrencePattern()
		{
			RecurrencePattern pattern = new RecurrencePattern();
			pattern.Frequency = RecurrenceFrequency.Weekly;
			pattern.Interval = Interval;
			pattern.DaysOfWeekMask = DaysOfWeekStringConverter.ConvertToRecurrenceDay(DaysOfWeek);
			return pattern;
		}
	}

	public partial class AbsoluteMonthlyRecurrencePatternType
	{
		public override RecurrencePattern ConvertToRecurrencePattern()
		{
			RecurrencePattern pattern = new RecurrencePattern();
			pattern.Frequency = RecurrenceFrequency.Monthly;
			pattern.DayOfMonth = DayOfMonth;
			pattern.Interval = Interval;
			return pattern;
		}
	}

	public partial class RelativeMonthlyRecurrencePatternType
	{
		public override RecurrencePattern ConvertToRecurrencePattern()
		{
			RecurrencePattern pattern = new RecurrencePattern();
			pattern.Frequency = RecurrenceFrequency.Monthly;
			pattern.DayOrdinal = DayOfWeekIndexConverter.ConvertToDayOrdinal(DayOfWeekIndex);
			pattern.DaysOfWeekMask = DayOfWeekConverter.ConvertToRecurrenceDay(DaysOfWeek);
			pattern.Interval = Interval;
			return pattern;
		}
	}

	public partial class AbsoluteYearlyRecurrencePatternType
	{
		public override RecurrencePattern ConvertToRecurrencePattern()
		{
			RecurrencePattern pattern = new RecurrencePattern();
			pattern.Frequency = RecurrenceFrequency.Yearly;
			pattern.DayOfMonth = DayOfMonth;
			pattern.Month = (RecurrenceMonth) Enum.Parse(typeof(RecurrenceMonth), Month.ToString());
			return pattern;
		}
	}

	public partial class RelativeYearlyRecurrencePatternType
	{
		public override RecurrencePattern ConvertToRecurrencePattern()
		{
			RecurrencePattern pattern = new RecurrencePattern();
			pattern.Frequency = RecurrenceFrequency.Yearly;
			pattern.DayOrdinal = DayOfWeekIndexConverter.ConvertToDayOrdinal(DayOfWeekIndex);
			pattern.DaysOfWeekMask = DaysOfWeekStringConverter.ConvertToRecurrenceDay(DaysOfWeek);
			pattern.Month = (RecurrenceMonth) Enum.Parse(typeof(RecurrenceMonth), Month.ToString());
			return pattern;
		}
	}

	public partial class RegeneratingPatternBaseType
	{
		public override RecurrencePattern ConvertToRecurrencePattern()
		{
			return null;
		}
	}


	public partial class RecurrenceRangeBaseType
	{
		public abstract RecurrenceRange ConvertToRecurrenceRange();
		
		public static RecurrenceRangeBaseType CreateFromSchedulerRecurrenceRule(RecurrenceRule schedulerRule, RadScheduler owner)
		{
			RecurrenceRange schedulerRange = schedulerRule.Range;

			DateTime start = schedulerRange.Start;

			//DateTime start = owner.UtcDayStart(schedulerRange.Start);
			if (schedulerRule.Pattern.Frequency == RecurrenceFrequency.Monthly ||
				schedulerRule.Pattern.Frequency == RecurrenceFrequency.Yearly)
			{
				DateTime monthStart = new DateTime(schedulerRange.Start.Year, schedulerRange.Start.Month, 1, 0, 0, 0, DateTimeKind.Utc);
				start = monthStart;
			}

			if (schedulerRange.RecursUntil < DateTime.MaxValue)
			{
				EndDateRecurrenceRangeType range = new EndDateRecurrenceRangeType();
				range.StartDate = start;
				range.EndDate = schedulerRange.RecursUntil.AddDays(-1);
				return range;
			}

			if (schedulerRange.MaxOccurrences < int.MaxValue)
			{
				NumberedRecurrenceRangeType range = new NumberedRecurrenceRangeType();
				range.StartDate = start;
				range.NumberOfOccurrences = schedulerRange.MaxOccurrences;
				return range;
			}

			NoEndRecurrenceRangeType noEndRange = new NoEndRecurrenceRangeType();
			noEndRange.StartDate = start;

			return noEndRange;
		}
	}

	public partial class NoEndRecurrenceRangeType
	{
		public override RecurrenceRange ConvertToRecurrenceRange()
		{
			RecurrenceRange range = new RecurrenceRange();
			range.Start = StartDate;
			return range;
		}
	}

	public partial class NumberedRecurrenceRangeType
	{
		public override RecurrenceRange ConvertToRecurrenceRange()
		{
			RecurrenceRange range = new RecurrenceRange();
			range.Start = StartDate;
			range.MaxOccurrences = NumberOfOccurrences;
			return range;
		}
	}

	public partial class EndDateRecurrenceRangeType
	{
		public override RecurrenceRange ConvertToRecurrenceRange()
		{
			RecurrenceRange range = new RecurrenceRange();
			range.Start = StartDate;
			range.RecursUntil = EndDate.Date.AddDays(1);
			return range;
		}
	}
}