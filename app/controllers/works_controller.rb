class WorksController < ApplicationController
  before_action :set_works, only: [:index], if: -> { request.format.json? }

  def index
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    ActiveRecord::Base.transaction do
      @work.save!
      respond_to do |format|
        format.json { render json: { message: "勤務データを作成しました。"}, status: 201 }
      end
    end
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

  def work_params
   params.require(:work).permit(:started_at, :ended_at, :times, :note)
  end
end
