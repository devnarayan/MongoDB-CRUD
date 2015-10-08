using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MongoDB.Driver;
using MongoDB.Bson;
using System.Data;
using System.Configuration;

namespace WebApplication2
{
    public partial class CRUD : System.Web.UI.Page
    {
        Model.DAL dal = new Model.DAL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEMployee();
            }
        }

        private void LoadEMployee()
        {

            try
            {
                GridView1.DataSource = dal.getEmployeeList().ToList();
                GridView1.DataBind();
            }
            catch (Exception) { }
        }

        protected void Save(object sender, EventArgs e)
        {
            Employee emp = new Employee();
            if (hdn.Value == "Edit")
            {
                if (ViewState["_idEdit"] != "")
                    emp._id = ObjectId.Parse(ViewState["_idEdit"].ToString());

                emp.empName = txtEmployeeName.Text;
                emp.empId = txtID.Text;
                emp.salary = Convert.ToDouble(txtSal.Text);
                emp.address = txtAddress.Text;
                emp.phone = txtPhn.Text;
                //dal.insert(emp);
                // emp._id = Xid;

                dal.updateEmployee(emp);
                LoadEMployee();
            }
            else
            {
                //Employee emp = new Employee();
                emp.empName = txtEmployeeName.Text;
                emp.empId = txtID.Text;
                emp.salary = Convert.ToDouble(txtSal.Text);
                emp.address = txtAddress.Text;
                emp.phone = txtPhn.Text;
                dal.insert(emp);
                LoadEMployee();
            }
        }
        protected void Add(object sender, EventArgs e)
        {
            txtEmployeeName.Text = string.Empty;
            txtID.Text = string.Empty;
            txtSal.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtPhn.Text = string.Empty;
            popup.Show();
        }
        public void Edit(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            hdn.Value = "Edit";
            using (GridViewRow row = (GridViewRow)((LinkButton)sender).Parent.Parent)
            {

                txtEmployeeName.Text = row.Cells[0].Text;
                txtID.Text = row.Cells[1].Text;
                txtSal.Text = row.Cells[2].Text;
                txtAddress.Text = row.Cells[3].Text;
                txtPhn.Text = row.Cells[4].Text;
                popup.Show();
            }
            ViewState["_idEdit"] = btn.CommandArgument;
        }
        protected void delete(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            Employee emp = new Employee();
            var x = emp._id;
            if (btn.Text == "Delete")
            {
                dal.DeleteEmployee(ObjectId.Parse(btn.CommandArgument));
                LoadEMployee();
            }
            else
            {
                hdn.Value = "Edit";
            }
        }

    }
}