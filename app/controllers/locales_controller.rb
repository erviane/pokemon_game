class LocalesController < ApplicationController
  def update
    cookies.permanent[:locale] = params[:locale] if locale_from(params[:locale])
    redirect_back fallback_location: root_path
  end
end
