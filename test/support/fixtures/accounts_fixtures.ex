defmodule AccessControl.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AccessControl.Accounts` context.
  """

  @doc """
  Generate a resource.
  """
  def resource_fixture(attrs \\ %{}) do
    {:ok, resource} =
      attrs
      |> Enum.into(%{
        name: "some name",
        path: "some path"
      })
      |> AccessControl.Accounts.create_resource()

    resource
  end
end
