defmodule AccessControl.AccountsTest do
  use AccessControl.DataCase

  alias AccessControl.Accounts

  describe "resources" do
    alias AccessControl.Accounts.Resource

    import AccessControl.AccountsFixtures

    @invalid_attrs %{name: nil, path: nil}

    test "list_resources/0 returns all resources" do
      resource = resource_fixture()
      assert Accounts.list_resources() == [resource]
    end

    test "get_resource!/1 returns the resource with given id" do
      resource = resource_fixture()
      assert Accounts.get_resource!(resource.id) == resource
    end

    test "create_resource/1 with valid data creates a resource" do
      valid_attrs = %{name: "some name", path: "some path"}

      assert {:ok, %Resource{} = resource} = Accounts.create_resource(valid_attrs)
      assert resource.name == "some name"
      assert resource.path == "some path"
    end

    test "create_resource/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_resource(@invalid_attrs)
    end

    test "update_resource/2 with valid data updates the resource" do
      resource = resource_fixture()
      update_attrs = %{name: "some updated name", path: "some updated path"}

      assert {:ok, %Resource{} = resource} = Accounts.update_resource(resource, update_attrs)
      assert resource.name == "some updated name"
      assert resource.path == "some updated path"
    end

    test "update_resource/2 with invalid data returns error changeset" do
      resource = resource_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_resource(resource, @invalid_attrs)
      assert resource == Accounts.get_resource!(resource.id)
    end

    test "delete_resource/1 deletes the resource" do
      resource = resource_fixture()
      assert {:ok, %Resource{}} = Accounts.delete_resource(resource)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_resource!(resource.id) end
    end

    test "change_resource/1 returns a resource changeset" do
      resource = resource_fixture()
      assert %Ecto.Changeset{} = Accounts.change_resource(resource)
    end
  end
end
