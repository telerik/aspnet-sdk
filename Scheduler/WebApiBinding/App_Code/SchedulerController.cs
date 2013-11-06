using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using Telerik.Web.UI;
using System.Web.Script.Serialization;

public class SchedulerController : ApiController
{

    public SchedulerController()
        : base()
    {
    }

    private JavaScriptSerializer _serializer;
    private JavaScriptSerializer JavaScriptSerializer
    {
        get
        {
            if (_serializer == null)
            {
                _serializer = new JavaScriptSerializer();
            }

            return _serializer;
        }
    }
    private XmlSchedulerProvider _provider;
    private XmlSchedulerProvider Provider
    {
        get
        {
            if (_provider == null)
            {
                _provider = new CustomXmlSchedulerProvider(System.Web.HttpContext.Current.Server.MapPath("~/App_Data/Appointments_Outlook.xml"), true);
            }

            return _provider;
        }
    }

    private WebServiceAppointmentController _controller;
    private WebServiceAppointmentController Controller
    {
        get
        {
            if (_controller == null)
            {
                _controller = new WebServiceAppointmentController(Provider);
            }

            return _controller;
        }
    }

    [HttpGet]
    public IEnumerable<AppointmentData> GetAppointments(string schedulerInfo)
    {
        return Controller.GetAppointments(JavaScriptSerializer.Deserialize<MySchedulerInfo>(schedulerInfo));
    }

    [HttpPost]
    public IEnumerable<AppointmentData> InsertAppointment(WebApiData data)
    {
        return Controller.InsertAppointment(data.SchedulerInfo, data.AppointmentData);
    }

    [HttpPut]
    public IEnumerable<AppointmentData> UpdateAppointment(WebApiData data)
    {
     
        return Controller.UpdateAppointment(data.SchedulerInfo, data.AppointmentData);
    }

    [HttpPost]
    public IEnumerable<AppointmentData> CreateRecurrenceException(WebApiData data)
    {
        return Controller.CreateRecurrenceException(data.SchedulerInfo, data.RecurrenceExceptionData);
    }

    [HttpDelete]
    public IEnumerable<AppointmentData> RemoveRecurrenceExceptions(WebApiData data)
    {
        return Controller.RemoveRecurrenceExceptions(data.SchedulerInfo, data.MasterAppointmentData);
    }

    [HttpDelete]
    public IEnumerable<AppointmentData> DeleteAppointment(WebApiData data)
    {
        return Controller.DeleteAppointment(data.SchedulerInfo, data.AppointmentData, data.DeleteSeries);
    }

    [HttpGet]
    public IEnumerable<ResourceData> GetResources(string schedulerInfo)
    {
        var o = new JavaScriptSerializer().Deserialize<MySchedulerInfo>(schedulerInfo);
        return Controller.GetResources(o);
    }
}
