using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Telerik.Web.UI;

/// <summary>
/// Summary description for MySchedulerInfo
/// </summary>
/// 

public class MySchedulerInfo : SchedulerInfo
{
	public string[] CategoryNames { get; set; }
	public MySchedulerInfo(ISchedulerInfo baseInfo, string[] categoryNames)
		: base(baseInfo)
	{
		CategoryNames = categoryNames;
	}
	public MySchedulerInfo()
	{

	}
}