defmodule Weather.GetWeather do
  import Logger
  import SweetXml

  @api Application.get_env(:weather, :api_key)
  @url Application.get_env(:weather, :url)

  @moduledoc """
  Fetches current weather data for Toronto from openweathermap.org
  and displays the current temperature, feels like temperature and wind speed.
  """
  def main(_) do
    get_data()
    |> display()
  end

  def get_data() do
    Logger.info("Getting current temperature in Toronto")

    {:ok, %{body: xdata}} = HTTPoison.get("#{@url}#{@api}")
    xdata
  end

  def display(xdata) do
    IO.puts("Current Temp: #{get_temp(xdata)}˚Celsius")
    IO.puts("Feels like: #{get_feels_like(xdata)}˚Celsius")
    IO.puts("Wind speed: #{get_wind_speed(xdata) * 3.6} KM/hour")
  end

  def get_wind_speed(xdata) do
    xdata
    |> xpath(~x"//wind/speed/@value"f)
  end

  def get_feels_like(xdata) do
    xdata
    |> xpath(~x"//feels_like/@value"f)
  end

  def get_temp(xdata) do
    xdata
    |> xpath(~x"//temperature/@value"f)
  end
end
