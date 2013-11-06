<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>
<%@ Import Namespace="System.Web.Http" %>

<script RunAt="server">
    void Application_Start(object sender, EventArgs e)
    {
        System.Web.Routing.RouteTable.Routes.MapHttpRoute(
             name: "ActionApi",
             routeTemplate: "api/{controller}/{action}/"
         );

        var jsonFormater = new System.Net.Http.Formatting.JsonMediaTypeFormatter();
        
        GlobalConfiguration.Configuration.Formatters.Clear();
        GlobalConfiguration.Configuration.Formatters.Add(jsonFormater);
    }
</script>
