class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from ActionController::ParameterMissing do |e|
    respond_to do |format|
      format.json { render json: { message: "不正なリクエストです。"}, status: 400 }
    end
  end
end
