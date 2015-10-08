using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MongoDB.Driver;
using MongoDB.Bson;
using System.Configuration;
using MongoDB.Driver.Builders;
using MongoDB.Bson.Serialization;
namespace WebApplication2.Model
{
    public class DAL
    {
        string con = "";
        MongoServer server;
        MongoDatabase emptbl;
        public DAL()
        {
            con = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
            server = MongoServer.Create(con);
            emptbl = server.GetDatabase("Employee");

        }
        public List<Employee> getEmployeeList()
        {
            List<Employee> list = new List<Employee>();
            var collection = emptbl.GetCollection<Employee>("Employee");
            foreach (Employee emp in collection.FindAll())
            {
                list.Add(emp);
            }
            return list;

        }
        public void insert(Employee emp)
        {
            try
            {
                MongoCollection<Employee> collection = emptbl.GetCollection<Employee>("Employee");
                BsonDocument employee = new BsonDocument{
                    {"empName",emp.empName},
                    {"empId",emp.empId},
                    {"salary",emp.salary},
                    {"address", emp.address},
                    {"phone",emp.phone}
                };
                collection.Insert(employee);
            }
            catch { };
        }

        public void updateEmployee(Employee emp)
        {
            MongoCollection<Employee> collection = emptbl.GetCollection<Employee>("Employee");
            IMongoQuery query = Query.EQ("_id", emp._id);
            IMongoUpdate update = MongoDB.Driver.Builders.Update.Set("empName", emp.empName)
                                                                 .Set("empId", emp.empId)
                                                                 .Set("salary", emp.salary)
                                                                 .Set("address", emp.address)
                                                                 .Set("phone", emp.phone);
            collection.Update(query, update);


        }

        public void DeleteEmployee(ObjectId id)
        {
            MongoCollection<Employee> collection = emptbl.GetCollection<Employee>("Employee");
            IMongoQuery query = Query.EQ("_id", id);
            collection.Remove(query);
        }
    }
}