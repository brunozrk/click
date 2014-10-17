class ReportsController < ApplicationController
  before_action :initialize_report, only: [:new, :create]
  before_action :load_report, only: [:edit, :update, :destroy]

  def index
    @reports = current_user.reports.page params[:page]
  end

  def create
    @report.user = current_user
    if @report.update_attributes(report_params)
      redirect_to reports_path
    else
      render 'new'
    end
  end

  def update
    if @report.update_attributes(report_params)
      redirect_to reports_path
    else
      render 'edit'
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_path
  end

  private

  def initialize_report
    @report = Report.new
  end

  def load_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(
      :first_entry,
      :first_exit,
      :second_entry,
      :second_exit,
      :remote,
      :notice,
      :day,
      :away
    )
  end
end
