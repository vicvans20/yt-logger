defmodule YtLogger.Web.UserControllerTest do
  use YtLogger.Web.ConnCase

  alias YtLogger.Account

  @create_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", password_hash: "some password_hash", role: "some role"}
  @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", password_hash: "some updated password_hash", role: "some updated role"}
  @invalid_attrs %{email: nil, first_name: nil, last_name: nil, password_hash: nil, role: nil}

  def fixture(:user) do
    {:ok, user} = Account.create_user(@create_attrs)
    user
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Users"
  end

  test "renders form for new users", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New User"
  end

  test "creates user and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == user_path(conn, :show, id)

    conn = get conn, user_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show User"
  end

  test "does not create user and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "New User"
  end

  test "renders form for editing chosen user", %{conn: conn} do
    user = fixture(:user)
    conn = get conn, user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit User"
  end

  test "updates chosen user and redirects when data is valid", %{conn: conn} do
    user = fixture(:user)
    conn = put conn, user_path(conn, :update, user), user: @update_attrs
    assert redirected_to(conn) == user_path(conn, :show, user)

    conn = get conn, user_path(conn, :show, user)
    assert html_response(conn, 200) =~ "some updated email"
  end

  test "does not update chosen user and renders errors when data is invalid", %{conn: conn} do
    user = fixture(:user)
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit User"
  end

  test "deletes chosen user", %{conn: conn} do
    user = fixture(:user)
    conn = delete conn, user_path(conn, :delete, user)
    assert redirected_to(conn) == user_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, user)
    end
  end
end
