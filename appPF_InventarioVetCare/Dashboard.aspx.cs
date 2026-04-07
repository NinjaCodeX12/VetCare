using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace appPF_InventarioVetCare
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string conexion = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarDashboard();
                CargarMovimientos();
                CargarStockBajo();
            }
        }

        private void CargarDashboard()
        {
            using (SqlConnection con = new SqlConnection(conexion))
            {
                con.Open();

                lblProductos.Text = new SqlCommand("SELECT COUNT(*) FROM producto", con).ExecuteScalar().ToString();

                lblStockDisponible.Text = new SqlCommand("SELECT ISNULL(SUM(stock_actual),0) FROM producto", con).ExecuteScalar().ToString();

                lblStockBajo.Text = new SqlCommand("SELECT COUNT(*) FROM producto WHERE stock_actual <= stock_minimo", con).ExecuteScalar().ToString();

                lblMovimientosHoy.Text = new SqlCommand(@"
                    SELECT COUNT(*) FROM movimiento_almacen 
                    WHERE CAST(fecha AS DATE) = CAST(GETDATE() AS DATE)", con)
                    .ExecuteScalar().ToString();
            }
        }

        private void CargarMovimientos()
        {
            using (SqlConnection con = new SqlConnection(conexion))
            {
                SqlDataAdapter da = new SqlDataAdapter(@"
                    SELECT TOP 5 p.nombre AS producto, u.username AS usuario, d.cantidad
                    FROM detalle_movimiento d
                    INNER JOIN producto p ON d.id_producto = p.id_producto
                    INNER JOIN movimiento_almacen m ON d.id_movimiento = m.id_movimiento
                    INNER JOIN usuario u ON m.id_usuario = u.id_usuario
                    ORDER BY m.fecha DESC", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rpMovimientos.DataSource = dt;
                rpMovimientos.DataBind();
            }
        }

        private void CargarStockBajo()
        {
            using (SqlConnection con = new SqlConnection(conexion))
            {
                SqlDataAdapter da = new SqlDataAdapter(@"
                    SELECT nombre,
                    (stock_actual * 100 / stock_minimo) AS porcentaje
                    FROM producto
                    WHERE stock_actual <= stock_minimo", con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                rpStockBajo.DataSource = dt;
                rpStockBajo.DataBind();
            }
        }
    }
}