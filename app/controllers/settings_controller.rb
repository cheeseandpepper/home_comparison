class SettingsController < ApplicationController

  def index
    @feature_types = FeatureType.all
  end

  def update
    Factories::FeatureTypesFactory.new(settings_params).update!
    redirect_to settings_path
  end

  private

  def settings_params
    params.require(:feature_types).permit!
  end

end
