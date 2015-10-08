using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MongoDB.Driver;
using MongoDB.Bson;

    public class Employee
    {
        public ObjectId _id { get; set; }
        public string empName { get; set; }
        public string empId { get; set; }
        public double salary { get; set; }
        public string address { get; set; }
        public string phone { get; set; }
    }
