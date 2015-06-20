require 'rails_helper'

describe ReportPresenter do
  let(:presenter) { described_class.new(report) }

  describe '#estimated_second_exit' do
    context 'when second_exit is NOT blank' do
      let(:report) { FactoryGirl.build(:report) }
      it { expect(presenter.estimated_second_exit).to eq report.second_exit }
    end

    context 'when second_exit is blank and estimated_exit exists' do
      let(:report) { FactoryGirl.build(:report_without_second_exit) }
      it { expect(presenter.estimated_second_exit.squish).to include '18:30' }
    end

    context 'when second_exit and estimated_exit are blank' do
      let(:report) { FactoryGirl.build(:report_without_second_exit, second_entry: '') }
      it { expect(presenter.estimated_second_exit).to eq nil }
    end
  end

  describe '#info' do
    context 'when notice is blank and working_day is true' do
      let(:report) { FactoryGirl.build(:report) }
      it { expect(presenter.info).to be_nil }
    end

    describe 'return some html' do
      let(:notice) { 'some text' }
      let(:nonworking_day) { '(Dia não útil)' }

      context 'when notice is NOT blank' do
        context 'when working_day is TRUE' do
          let(:report) { FactoryGirl.build(:report, notice: notice, working_day: true) }
          it { expect(presenter.info).to include notice }
          it { expect(presenter.info).to_not include nonworking_day }
        end

        context 'when working_day is FALSE' do
          let(:report) { FactoryGirl.build(:report, notice: notice, working_day: false) }
          it { expect(presenter.info).to include "#{notice} #{nonworking_day}" }
        end
      end

      context 'when working_day is FALSE' do
        context 'when notice is blank' do
          let(:report) { FactoryGirl.build(:report, working_day: false) }
          it { expect(presenter.info).to include nonworking_day }
          it { expect(presenter.info).to_not include notice }
        end
      end
    end
  end
end
