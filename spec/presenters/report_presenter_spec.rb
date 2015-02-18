require 'rails_helper'

describe ReportPresenter do
  let(:presenter) { described_class.new(report) }

  describe '#last_exit' do
    context 'when second_exit is NOT blank' do
      let(:report) { FactoryGirl.build(:report) }
      it { expect(presenter.last_exit).to eq report.second_exit }
    end

    context 'when second_exit is blank and estimated_exit exists' do
      let(:report) { FactoryGirl.build(:report_without_second_exit) }
      it { expect(presenter.last_exit.squish).to include '18:30' }
    end

    context 'when second_exit and estimated_exit are blank' do
      let(:report) { FactoryGirl.build(:report_without_second_exit, second_entry: '') }
      it { expect(presenter.last_exit).to eq nil }
    end
  end
end
