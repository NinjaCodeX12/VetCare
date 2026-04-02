using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace appPF_InventarioVetCare
{
    public partial class Usuarios : System.Web.UI.Page
    {
        // Cadena de conexión obtenida desde el Web.config
        string strCon = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Solo se ejecuta la primera vez que carga la página
            if (!IsPostBack)
            {
                CargarEmpleados();   // Llena el ComboBox de empleados
                ListarUsuarios();    // Muestra los usuarios en el GridView
            }
        }

        // Método para cargar los empleados activos en el DropDownList
        void CargarEmpleados()
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarEmpleadosActivos", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();

                ddlEmpleado.DataSource = cmd.ExecuteReader();
                ddlEmpleado.DataTextField = "nombre_completo"; // Lo que se muestra
                ddlEmpleado.DataValueField = "id_empleado";    // Valor real
                ddlEmpleado.DataBind();

                // Agregamos una opción inicial
                ddlEmpleado.Items.Insert(0, new ListItem("-- Seleccione Empleado --", "0"));
            }
        }

        // Método para listar los usuarios (con filtro opcional)
        void ListarUsuarios(string textoBusqueda = "")
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlCommand cmd = new SqlCommand("SP_ListarUsuarios", con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Enviamos el texto de búsqueda al procedimiento almacenado
                cmd.Parameters.AddWithValue("@Filtro", textoBusqueda);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvUsuarios.DataSource = dt;
                gvUsuarios.DataBind();
            }
        }

        // Evento del botón Buscar
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            // Filtra los usuarios según el texto ingresado
            ListarUsuarios(txtBuscar.Text.Trim());
        }

        // Método para guardar (Insertar o Editar)
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            // Determina qué procedimiento usar
            string sp = (hfIdUsuario.Value == "0") ? "SP_InsertarUsuario" : "SP_EditarUsuario";

            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlCommand cmd = new SqlCommand(sp, con);
                cmd.CommandType = CommandType.StoredProcedure;

                // Si es edición, enviamos el ID
                if (hfIdUsuario.Value != "0")
                    cmd.Parameters.AddWithValue("@id_usuario", hfIdUsuario.Value);

                // Parámetros del usuario
                cmd.Parameters.AddWithValue("@username", txtUser.Text.Trim());
                cmd.Parameters.AddWithValue("@rol", ddlRol.SelectedValue);
                cmd.Parameters.AddWithValue("@id_empleado", ddlEmpleado.SelectedValue);

                // Solo se envía la contraseña cuando es nuevo usuario
                if (hfIdUsuario.Value == "0")
                    cmd.Parameters.AddWithValue("@clave", txtPass.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Limpiar formulario y actualizar lista
            Limpiar();
            ListarUsuarios();
        }

        // Evento al seleccionar un usuario del GridView (para editar)
        protected void gvUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            int i = gvUsuarios.SelectedIndex;

            // Cargamos los datos seleccionados en el formulario
            hfIdUsuario.Value = gvUsuarios.DataKeys[i].Values["id_usuario"].ToString();
            txtUser.Text = gvUsuarios.DataKeys[i].Values["username"].ToString();
            ddlRol.SelectedValue = gvUsuarios.DataKeys[i].Values["rol"].ToString();
            ddlEmpleado.SelectedValue = gvUsuarios.DataKeys[i].Values["id_empleado"].ToString();

            // Ocultamos el campo de contraseña en edición
            divPassword.Visible = false;

            // Cambiamos apariencia del botón
            btnGuardar.Text = "Actualizar Staff";
            btnGuardar.CssClass = "btn btn-warning shadow-sm fw-bold";
        }

        // Evento para eliminar un usuario
        protected void gvUsuarios_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            using (SqlConnection con = new SqlConnection(strCon))
            {
                SqlCommand cmd = new SqlCommand("SP_EliminarUsuario", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@id_usuario",
                    gvUsuarios.DataKeys[e.RowIndex].Values["id_usuario"]);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Actualiza la lista después de eliminar
            ListarUsuarios();
        }

        // Botón limpiar formulario
        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Limpiar();
        }

        // Método para limpiar los campos del formulario
        void Limpiar()
        {
            hfIdUsuario.Value = "0";
            txtUser.Text = "";
            txtPass.Text = "";

            // Reinicia el combo de empleados
            if (ddlEmpleado.Items.Count > 0)
                ddlEmpleado.SelectedIndex = 0;

            // Mostrar nuevamente el campo contraseña
            divPassword.Visible = true;

            // Restaurar botón a estado inicial
            btnGuardar.Text = "Registrar Usuario";
            btnGuardar.CssClass = "btn btn-primary shadow-sm fw-bold";
        }
    }
}