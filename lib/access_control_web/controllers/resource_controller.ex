defmodule AccessControlWeb.ResourceController do
  use AccessControlWeb, :controller

  alias AccessControl.Accounts
  alias AccessControl.Accounts.Resource

  def index(conn, _params) do
    resources = Accounts.list_resources()
    render(conn, "index.html", resources: resources)
  end

  def new(conn, _params) do
    changeset = Accounts.change_resource(%Resource{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"resource" => resource_params}) do
    case Accounts.create_resource(resource_params) do
      {:ok, resource} ->
        conn
        |> put_flash(:info, "Resource created successfully.")
        |> redirect(to: Routes.resource_path(conn, :show, resource))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    resource = Accounts.get_resource!(id)
    render(conn, "show.html", resource: resource)
  end

  def edit(conn, %{"id" => id}) do
    resource = Accounts.get_resource!(id)
    changeset = Accounts.change_resource(resource)
    render(conn, "edit.html", resource: resource, changeset: changeset)
  end

  def update(conn, %{"id" => id, "resource" => resource_params}) do
    resource = Accounts.get_resource!(id)

    case Accounts.update_resource(resource, resource_params) do
      {:ok, resource} ->
        conn
        |> put_flash(:info, "Resource updated successfully.")
        |> redirect(to: Routes.resource_path(conn, :show, resource))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", resource: resource, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    resource = Accounts.get_resource!(id)
    {:ok, _resource} = Accounts.delete_resource(resource)

    conn
    |> put_flash(:info, "Resource deleted successfully.")
    |> redirect(to: Routes.resource_path(conn, :index))
  end
end
