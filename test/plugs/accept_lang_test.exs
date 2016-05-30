defmodule Bracco.AcceptLangTest do
  use Bracco.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "accept-language request header not specified" do
    conn = conn()
    |> Bracco.AcceptLang.call(%{})

    assert Gettext.get_locale(Bracco.Gettext) == "en"
  end

  test "accept-language request header contains en" do
    conn = conn()
    |> put_req_header("accept-language", "en")
    |> Bracco.AcceptLang.call(%{})

    assert Gettext.get_locale(Bracco.Gettext) == "en"
  end

  test "lccept-language request header contains it" do
    conn = conn()
    |> put_req_header("accept-language", "it")
    |> Bracco.AcceptLang.call(%{})

    assert Gettext.get_locale(Bracco.Gettext) == "it"
  end
end
