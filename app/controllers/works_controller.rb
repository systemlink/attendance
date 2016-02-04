class WorksController < ApplicationController
  before_action :set_works, only: [:index], if: -> { request.format.json? }

  def index
  end

  private

  def set_works
    @works = Work.search(params_search_started_at, params_search_ended_at)
  end

  def params_search_started_at
    params.require(:search_started_at)
  end

  def params_search_ended_at
    params.require(:search_ended_at)
  end
end
