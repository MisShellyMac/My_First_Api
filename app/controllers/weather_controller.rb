require 'httparty'

class WeatherController < ApplicationController
  WEATHER_URI = "http://api.openweathermap.org/data/2.5/weather?mode=json&units=imperial&"

  Forecast_Uri = "http://api.openweathermap.org/data/2.5/forecast?mode=json&units=imperial&"

  Multi_day_Uri =
  "http://api.openweathermap.org/data/2.5/forecast/daily?mode=json&units=imperial&"

  def index; end

  def city_redirect
    if params[:city].present?
      redirect_to city_path(params[:city])
    else
      redirect_to root_path
    end
  end

  def city
    @city = params[:city].capitalize
    # let's get some weather data from the api
    response = HTTParty.get(WEATHER_URI + "q=#{@city}")
    @current_temperature = response["main"]["temp"]
    @number_of_clouds    = response["clouds"]["all"]
    @wind_speed =
    response["wind"]["speed"]
    @humidity =
    response["main"]["humidity"]

    @country = params[:country]
    response = HTTParty.get(Forecast_Uri + "q=#{@city},#{@country}+cnt=#{@cnt}")
    @forecast =
    response["list"].map do |value|
      value["main"]["temp"]

    @cnt = params[:cnt].to_i
    response = HTTParty.get(Multi_day_Uri + "q=#{@city},#{@country}+cnt=#{@cnt}")
    @multi_day = response["list"].map do |value|
      value["main"]["temp"]
      end
    end
  end
end
