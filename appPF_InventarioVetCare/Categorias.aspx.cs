using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace appPF_InventarioVetCare
{
    public partial class Categorias : System.Web.UI.Page
    {
        string strConexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ListarCategorias();
            }
        }

        void ListarCategorias()
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarCategorias", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();

                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());

                gvCategorias.DataSource = dt;
                gvCategorias.DataBind();

                lblTotalCat.Text = dt.Rows.Count.ToString();
            }
        }

        protected void btnGuardarCat_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_InsertarCategoria", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@nombre", txtNombreCat.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
            }

            txtNombreCat.Text = "";
            ListarCategorias();
        }

        protected void gvCategorias_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvCategorias.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(strConexion))
            {
                SqlCommand cmd = new SqlCommand("SP_EliminarCategoria", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id_categoria", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            ListarCategorias();
        }

        protected void gvCategorias_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCategorias.PageIndex = e.NewPageIndex;
            ListarCategorias();
        }
    }
}