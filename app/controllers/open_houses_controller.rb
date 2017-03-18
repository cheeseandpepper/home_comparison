class OpenHousesController < ApplicationController

  def index
    @houses = House.active
  end
end
