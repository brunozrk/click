class ReportsController < ApplicationController
  before_action :authenticate_user!

  before_action :initialize_report, only: [:new, :create]
  before_action :load_report, only: [:edit, :update, :destroy]
  before_action :require_permission, only: [:edit, :update, :destroy]

  def new
    @report.day = Date.today
  end

  def index
    @reports = current_user.reports.page params[:page]
  end

  def create
    @report.user = current_user
    if @report.update_attributes(report_params)
      redirect_to reports_path, flash: { success: 'Relatório criado!' }
    else
      render 'new'
    end
  end

  def update
    if @report.update_attributes(report_params)
      redirect_to reports_path, flash: { success: 'Relatório atualizado!' }
    else
      render 'edit'
    end
  end

  def destroy
    @report.destroy
    redirect_to reports_path, flash: { success: 'Relatório removido!' }
  end

  private

  def require_permission
    return unless current_user != @report.user
    redirect_to reports_path
  end

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
