
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using Telerik.Web.UI;

public class SchedulerDBProvider : DbSchedulerProviderBase
{
    private IDictionary<int, Resource> _teachers;
    private IDictionary<int, Resource> _students;

    private IDictionary<int, Resource> Teachers
    {
        get
        {
            if (_teachers == null)
            {
                _teachers = new Dictionary<int, Resource>();
                foreach (Resource teacher in LoadTeachers())
                {
                    _teachers.Add((int)teacher.Key, teacher);
                }
            }

            return _teachers;
        }
    }

    private IDictionary<int, Resource> Students
    {
        get
        {
            _students = new Dictionary<int, Resource>();
            foreach (Resource student in LoadStudents())
            {
                _students.Add((int)student.Key, student);
            }

            return _students;
        }
    }

    public override IEnumerable<Appointment> GetAppointments(ISchedulerInfo shedulerInfo)
    {
        

        List<Appointment> appointments = new List<Appointment>();

        using (DbConnection conn = OpenConnection())
        {
            DbCommand cmd = DbFactory.CreateCommand();
            cmd.Connection = conn;
            cmd.CommandText = "SELECT [ClassID], [Subject], [Start], [End], [RecurrenceRule], [RecurrenceParentId], [Reminder], [Description], [AppointmentColor] FROM [DbProvider_Classes]";
            
            using (DbDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    Appointment apt = new Appointment();
                    apt.ID = reader["ClassID"];
                    apt.Subject = Convert.ToString(reader["Subject"]);
                    apt.Description = Convert.ToString(reader["Description"]);
                    apt.Attributes["AppointmentColor"] = Convert.ToString(reader["AppointmentColor"]);
                    apt.Start = DateTime.SpecifyKind(Convert.ToDateTime(reader["Start"]), DateTimeKind.Utc);
                    apt.End = DateTime.SpecifyKind(Convert.ToDateTime(reader["End"]), DateTimeKind.Utc);
                    apt.RecurrenceRule = Convert.ToString(reader["RecurrenceRule"]);
                    apt.RecurrenceParentID = reader["RecurrenceParentId"] == DBNull.Value ? null : reader["RecurrenceParentId"];

                    if (reader["Reminder"] != DBNull.Value)
                    {
                        IList<Reminder> reminders = Reminder.TryParse(Convert.ToString(reader["Reminder"]));
                        if (reminders != null)
                        {
                            apt.Reminders.AddRange(reminders);
                        }
                    }

                    if (apt.RecurrenceParentID != null)
                    {
                        apt.RecurrenceState = RecurrenceState.Exception;
                    }
                    else
                        if (apt.RecurrenceRule != string.Empty)
                        {
                            apt.RecurrenceState = RecurrenceState.Master;
                        }

                    LoadResources(apt);
                    appointments.Add(apt);
                }
            }
        }
        return appointments;
    }    

    public override void Insert(ISchedulerInfo shedulerInfo, Appointment appointmentToInsert)
    {
        if (!PersistChanges)
        {
            return;
        }

        using (DbConnection conn = OpenConnection())
        {
            using (DbTransaction tran = conn.BeginTransaction())
            {
                DbCommand cmd = DbFactory.CreateCommand();
                cmd.Connection = conn;
                cmd.Transaction = tran;

                PopulateAppointmentParameters(cmd, appointmentToInsert);

                cmd.CommandText =
                    @"	INSERT	INTO [DbProvider_Classes]
									([Subject], [Start], [End], [TeacherID],
									[RecurrenceRule], [RecurrenceParentID], [Reminder], [Description], [AppointmentColor])
							VALUES	(@Subject, @Start, @End, @TeacherID,
									@RecurrenceRule, @RecurrenceParentID, @Reminder, @Description, @AppointmentColor)";

                if (DbFactory is SqlClientFactory)
                {
                    cmd.CommandText += Environment.NewLine + "SELECT SCOPE_IDENTITY()";
                }
                else
                {
                    cmd.ExecuteNonQuery();

                    cmd.CommandText = "SELECT @@IDENTITY";
                }
                int identity = Convert.ToInt32(cmd.ExecuteScalar());

                FillClassStudents(appointmentToInsert, cmd, identity);

                tran.Commit();
            }
        }
    }

    public override void Update(ISchedulerInfo shedulerInfo, Appointment appointmentToUpdate)
    {
        if (!PersistChanges)
        {
            return;
        }

        using (DbConnection conn = OpenConnection())
        {
            using (DbTransaction tran = conn.BeginTransaction())
            {
                DbCommand cmd = DbFactory.CreateCommand();
                cmd.Connection = conn;
                cmd.Transaction = tran;

                PopulateAppointmentParameters(cmd, appointmentToUpdate);

                cmd.Parameters.Add(CreateParameter("@ClassID", appointmentToUpdate.ID));
                cmd.CommandText = "UPDATE [DbProvider_Classes] SET [Subject] = @Subject, [Description] = @Description,  [Reminder] = @Reminder, [AppointmentColor] = @AppointmentColor, [Start] = @Start, [End] = @End, [TeacherID] = @TeacherID, [RecurrenceRule] = @RecurrenceRule, [RecurrenceParentID] = @RecurrenceParentID WHERE [ClassID] = @ClassID";
                cmd.ExecuteNonQuery();

                ClearClassStudents(appointmentToUpdate.ID, cmd);

                FillClassStudents(appointmentToUpdate, cmd, appointmentToUpdate.ID);

                tran.Commit();
            }
        }
    }

    public override void Delete(ISchedulerInfo shedulerInfo, Appointment appointmentToDelete)
    {
        if (!PersistChanges)
        {
            return;
        }

        using (DbConnection conn = OpenConnection())
        {
            DbCommand cmd = DbFactory.CreateCommand();
            cmd.Connection = conn;

            using (DbTransaction tran = conn.BeginTransaction())
            {
                cmd.Transaction = tran;

                ClearClassStudents(appointmentToDelete.ID, cmd);

                cmd.Parameters.Clear();
                cmd.Parameters.Add(CreateParameter("@ClassID", appointmentToDelete.ID));
                cmd.CommandText = "DELETE FROM [DbProvider_Classes] WHERE [ClassID] = @ClassID";
                cmd.ExecuteNonQuery();

                tran.Commit();
            }
        }
    }

    public override IDictionary<ResourceType, IEnumerable<Resource>> GetResources(ISchedulerInfo schedulerInfo)
    {
        Dictionary<ResourceType, IEnumerable<Resource>> resCollection = new Dictionary<ResourceType, IEnumerable<Resource>>();

        resCollection.Add(new ResourceType("Teacher", false), Teachers.Values);
        resCollection.Add(new ResourceType("Student", true), Students.Values);

        return resCollection;
    }

    public override IEnumerable<ResourceType> GetResourceTypes(RadScheduler owner)
    {
        ResourceType[] resourceTypes = new ResourceType[2];
        resourceTypes[0] = new ResourceType("Teacher", false);
        resourceTypes[1] = new ResourceType("Student", true);

        return resourceTypes;
    }

    public override IEnumerable<Resource> GetResourcesByType(RadScheduler owner, string resourceType)
    {
        switch (resourceType)
        {
            case "Teacher":
                return Teachers.Values;

            case "Student":
                return Students.Values;

            default:
                throw new InvalidOperationException("Unknown resource type: " + resourceType);
        }
    }

    private void LoadResources(Appointment apt)
    {
        using (DbConnection conn = OpenConnection())
        {
            DbCommand cmd = DbFactory.CreateCommand();
            cmd.Connection = conn;

            cmd.Parameters.Add(CreateParameter("@ClassID", apt.ID));
            cmd.CommandText = "SELECT [TeacherID] FROM [DbProvider_Classes] WHERE [ClassID] = @ClassID AND [TeacherID] IS NOT NULL";
            using (DbDataReader reader = cmd.ExecuteReader())
            {
                if (reader.Read())
                {
                    Resource teacher = Teachers[Convert.ToInt32(reader["TeacherID"])];
                    apt.Resources.Add(teacher);
                }
            }

            cmd.Parameters.Clear();
            cmd.Parameters.Add(CreateParameter("@ClassID", apt.ID));
            cmd.CommandText = "SELECT [StudentID] FROM [DbProvider_ClassStudents] WHERE [ClassID] = @ClassID";
            using (DbDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    Resource student = Students[Convert.ToInt32(reader["StudentID"])];
                    apt.Resources.Add(student);
                }
            }
        }
    }

    private IEnumerable<Resource> LoadTeachers()
    {
        List<Resource> resources = new List<Resource>();

        using (DbConnection conn = OpenConnection())
        {
            DbCommand cmd = DbFactory.CreateCommand();
            cmd.Connection = conn;
            cmd.CommandText = "SELECT [TeacherID], [Name], [Phone] FROM [DbProvider_Teachers]";

            using (DbDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    Resource res = new Resource();
                    res.Type = "Teacher";
                    res.Key = reader["TeacherID"];
                    res.Text = Convert.ToString(reader["Name"]);
                    res.Attributes["Phone"] = Convert.ToString(reader["Phone"]);
                    resources.Add(res);
                }
            }
        }

        return resources;
    }

    private IEnumerable<Resource> LoadStudents()
    {
        List<Resource> resources = new List<Resource>();

        using (DbConnection conn = OpenConnection())
        {
            DbCommand cmd = DbFactory.CreateCommand();
            cmd.Connection = conn;
            cmd.CommandText = "SELECT [StudentID], [Name] FROM [DbProvider_Students]";

            using (DbDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    Resource res = new Resource();
                    res.Type = "Student";
                    res.Key = reader["StudentID"];
                    res.Text = Convert.ToString(reader["Name"]);
                    resources.Add(res);
                }
            }
        }

        return resources;
    }

    private void FillClassStudents(Appointment appointment, DbCommand cmd, object classId)
    {
        foreach (Resource student in appointment.Resources.GetResourcesByType("Student"))
        {
            cmd.Parameters.Clear();
            cmd.Parameters.Add(CreateParameter("@ClassID", classId));
            cmd.Parameters.Add(CreateParameter("@StudentID", student.Key));

            cmd.CommandText = "INSERT INTO [DbProvider_ClassStudents] ([ClassID], [StudentID]) VALUES (@ClassID, @StudentID)";
            cmd.ExecuteNonQuery();
        }
    }

    private void ClearClassStudents(object classId, DbCommand cmd)
    {
        cmd.Parameters.Clear();
        cmd.Parameters.Add(CreateParameter("@ClassID", classId));
        cmd.CommandText = "DELETE FROM [DbProvider_ClassStudents] WHERE [ClassID] = @ClassID";
        cmd.ExecuteNonQuery();
    }

    private void PopulateAppointmentParameters(DbCommand cmd, Appointment apt)
    {
        cmd.Parameters.Add(CreateParameter("@Subject", apt.Subject));
        cmd.Parameters.Add(CreateParameter("@Start", apt.Start));
        cmd.Parameters.Add(CreateParameter("@End", apt.End));
        cmd.Parameters.Add(CreateParameter("@Description", apt.Description));
        cmd.Parameters.Add(CreateParameter("@AppointmentColor", apt.Attributes["AppointmentColor"]));

        Resource teacher = apt.Resources.GetResourceByType("Teacher");
        object teacherId = null;
        if (teacher != null)
        {
            teacherId = teacher.Key;
        }
        cmd.Parameters.Add(CreateParameter("@TeacherID", teacherId));

        string rrule = null;
        if (apt.RecurrenceRule != string.Empty)
        {
            rrule = apt.RecurrenceRule;
        }
        cmd.Parameters.Add(CreateParameter("@RecurrenceRule", rrule));

        object parentId = null;
        if (apt.RecurrenceParentID != null)
        {
            parentId = apt.RecurrenceParentID;
        }
        cmd.Parameters.Add(CreateParameter("@RecurrenceParentId", parentId));

        cmd.Parameters.Add(CreateParameter("@Reminder", apt.Reminders.ToString()));
    }
}


