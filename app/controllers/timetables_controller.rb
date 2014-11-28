class TimetablesController < ApplicationController
  before_action :authenticate_user!

  before_action :load_timetables
  before_action :initialize_timetable, only: [:index, :new, :create]
  before_action :load_timetable, only: [:edit, :update, :destroy]

  def create
    @timetable.user = current_user
    if @timetable.update_attributes(timetable_params)
      redirect_to timetables_path, flash: { success: 'Quadro fechado!' }
    else
      render 'index'
    end
  end

  def edit
    render 'index'
  end

  def update
    if @timetable.update_attributes(timetable_params)
      redirect_to timetables_path, flash: { success: 'Fechamento atualizado!' }
    else
      render 'index'
    end
  end

  def destroy
    @timetable.destroy
    redirect_to timetables_path, flash: { success: 'Fechamento removido!' }
  end

  private

  def initialize_timetable
    @timetable = Timetable.new
  end

  def timetable_params
    params.require(:timetable).permit(:closing_day)
  end

  def load_timetables
    @timetables = current_user.timetables.all.page params[:page]
  end

  def load_timetable
    @timetable = Timetable.find(params[:id])
  end
end
