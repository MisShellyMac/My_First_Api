require 'httparty'

class WeatherController < ApplicationController
  WEATHER_URI = "http://api.openweathermap.org/data/2.5/weather?mode=json&units=imperial&"

  def index; end

  def city_redirect
    if params[:city].present?
      redirect_to city_path(params[:city])
    else
      redirect_to root_path
    end
  end

  def city
    @city = params[:city]

    # let's get some weather data from the api
    response = HTTParty.get(WEATHER_URI + "q=#{@city}")
    @current_temperature = response["main"]["temp"]
    @number_of_clouds    = response["clouds"]["all"]
  end
end
