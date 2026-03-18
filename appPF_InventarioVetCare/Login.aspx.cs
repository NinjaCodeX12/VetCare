using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace appPF_InventarioVetCare
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string conexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

            using (SqlConnection con = new SqlConnection(conexion))
            {
                SqlCommand cmd = new SqlCommand("SP_ValidarUsuario", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Usuario", txtCorreo.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                con.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    Session["usuario"] = dr["username"].ToString();
                    Session["rol"] = dr["rol"].ToString();

                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
   
                }
            }
        }
    }
}