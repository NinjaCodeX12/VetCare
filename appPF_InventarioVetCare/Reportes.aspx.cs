using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;

namespace appPF_InventarioVetCare
{
    public partial class Reportes : System.Web.UI.Page
    {
        string conexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTabla();
                CargarGraficos();
            }
        }

        private void CargarTabla()
        {
            using (SqlConnection con = new SqlConnection(conexion))
            {
                SqlDataAdapter da = new SqlDataAdapter(@"
                    SELECT p.nombre, p.stock_actual, c.nombre AS categoria
                    FROM producto p
                    INNER JOIN categoria c ON p.id_categoria = c.id_categoria", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rpReporte.DataSource = dt;
                rpReporte.DataBind();
            }
        }

        private void CargarGraficos()
        {
            using (SqlConnection con = new SqlConnection(conexion))
            {
                con.Open();

                var nombres = new System.Collections.Generic.List<string>();
                var stock = new System.Collections.Generic.List<int>();

                SqlCommand cmd = new SqlCommand("SELECT nombre, stock_actual FROM producto", con);
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    nombres.Add(dr["nombre"].ToString());
                    stock.Add(Convert.ToInt32(dr["stock_actual"]));
                }
                dr.Close();

                var categorias = new System.Collections.Generic.List<string>();
                var cantidades = new System.Collections.Generic.List<int>();

                SqlCommand cmd2 = new SqlCommand(@"
                    SELECT c.nombre, COUNT(*) cantidad
                    FROM producto p
                    INNER JOIN categoria c ON p.id_categoria = c.id_categoria
                    GROUP BY c.nombre", con);

                SqlDataReader dr2 = cmd2.ExecuteReader();

                while (dr2.Read())
                {
                    categorias.Add(dr2["nombre"].ToString());
                    cantidades.Add(Convert.ToInt32(dr2["cantidad"]));
                }

                JavaScriptSerializer js = new JavaScriptSerializer();

                hfNombres.Value = js.Serialize(nombres);
                hfStock.Value = js.Serialize(stock);
                hfCategorias.Value = js.Serialize(categorias);
                hfCantidades.Value = js.Serialize(cantidades);
            }
        }
    }
}