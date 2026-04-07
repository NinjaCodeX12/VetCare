using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace appPF_InventarioVetCare
{
    public partial class Empleados : System.Web.UI.Page
    {
        string cn = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                listar();
            }
        }

        // LISTAR EMPLEADOS
        void listar()
        {
            using (SqlConnection con = new SqlConnection(cn))
            {
                SqlDataAdapter da = new SqlDataAdapter("sp_listar_empleados", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dt = new DataTable();
                da.Fill(dt);

                // Repeater (como categorías)
                rpEmpleados.DataSource = dt;
                rpEmpleados.DataBind();

                // Total
                lblTotalEmp.Text = dt.Rows.Count.ToString();
            }
        }

        // GUARDAR / ACTUALIZAR
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd;

                    // Insertar o actualizar
                    if (string.IsNullOrEmpty(hfId.Value))
                        cmd = new SqlCommand("sp_insertar_empleado", con);
                    else
                        cmd = new SqlCommand("sp_actualizar_empleado", con);

                    cmd.CommandType = CommandType.StoredProcedure;

                    if (!string.IsNullOrEmpty(hfId.Value))
                        cmd.Parameters.AddWithValue("@id_empleado", hfId.Value);

                    cmd.Parameters.AddWithValue("@nombre", txtNombre.Text.Trim());
                    cmd.Parameters.AddWithValue("@apellido", txtApellido.Text.Trim());
                    cmd.Parameters.AddWithValue("@dni", txtDni.Text.Trim());
                    cmd.Parameters.AddWithValue("@telefono", txtTelefono.Text.Trim());

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                listar();
                limpiar();

                // SweetAlert OK
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "ok", "mensajeGuardado();", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "err", $"mensajeError('{ex.Message.Replace("'", "")}');", true);
            }
        }

        // ELIMINAR (como categorías)
        protected void EliminarEmpleado(object sender, EventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(hfEliminar.Value);

                using (SqlConnection con = new SqlConnection(cn))
                {
                    SqlCommand cmd = new SqlCommand("sp_eliminar_empleado", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id_empleado", id);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                listar();

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "del", "mensajeEliminado();", true);
            }
            catch
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "err", "mensajeError('Error al eliminar');", true);
            }
        }

        // LIMPIAR FORM
        void limpiar()
        {
            hfId.Value = "";
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtDni.Text = "";
            txtTelefono.Text = "";
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            limpiar();
        }
    }
}