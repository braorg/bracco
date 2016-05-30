defmodule Bracco.AcceptLang do
  import Plug.Conn

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case get_req_header(conn, "accept-language") do
      [] -> conn
      [locale] ->
        Gettext.put_locale(Bracco.Gettext, locale)
        conn
    end
  end
end
