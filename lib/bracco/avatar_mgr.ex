defmodule Bracco.AvatarMgr do
  @static_path "priv/static"

  def convert_to_local_path(original_url) do
    get_image_binary(original_url)
    |> write_static_path(original_url)
  end

  defp get_image_binary(url) do
    case HTTPoison.get(url, [], [follow_redirect: true]) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        body
      _ ->
        nil
    end
  end

  defp write_static_path(image, url) do
    image_name = String.split(url, "/") |> List.last
    Path.join(@static_path, avatars_image_path(image_name))
    |> File.write!(image)

    avatars_image_path(image_name)
  end

  defp avatars_image_path(image_name) do
    Path.join("avatars", image_name) <> ".png"
  end
end
