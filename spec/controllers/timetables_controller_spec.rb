require 'rails_helper'

describe TimetablesController do
  login_user

  describe 'GET #index' do
    let(:page) { '3' }

    it 'should load the timetables of requested page' do
      expect(Timetable).to receive(:page).with(page)
      get :index, page: page
    end

    it 'assigns a new Timetable to @timetable' do
      get :index
      expect(assigns(:timetable)).to be_a_new(Timetable)
    end
  end

  describe 'POST #create' do
    let(:timetable_params) do
      {
        timetable: {
          closing_day: Date.today
        }
      }
    end

    context 'with valid params' do
      it 'save a timetable' do
        expect do
          post :create, timetable_params
        end.to change { Timetable.count }.by(1)
      end

      it 'redirect to timetable listing' do
        post :create, timetable_params
        expect(response).to redirect_to(timetables_path)
      end
    end

    context 'with invalid params' do
      it 'render index template' do
        timetable_params[:timetable].merge!(closing_day: '')
        post :create, timetable_params
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'GET #edit' do
    let(:edit_timetable) { timetables(:timetable_1) }
    let(:unallowed_timetable) { timetables(:unallowed_timetable) }

    context 'when the current_user is the timetable owner' do
      it 'assigns edit_timetable to @timetable' do
        get :edit, id: edit_timetable.id
        expect(assigns(:timetable)).to eq(edit_timetable)
      end
    end

    context 'when the current_user is NOT the timetable owner' do
      it 'redirect to timetable listing' do
        get :edit, id: unallowed_timetable.id
        expect(response).to redirect_to(timetables_path)
      end
    end
  end
end
