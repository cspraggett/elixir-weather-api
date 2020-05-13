defmodule Weather.GetWeather do
  import Logger
  import SweetXml

  @api Application.get_env(:weather, :api_key)
  @url Application.get_env(:weather, :url)
  def print, do: IO.puts("#{@url}#{@api}")

  def fetch() do
    Logger.info("Getting current temperature in Toronto")
    {:ok, %{body: xdata}} = HTTPoison.get("#{@url}#{@api}")

    temp =
      xdata
      |> xpath(~x"//temperature/@value"f)
      |> IO.puts()
  end
end
