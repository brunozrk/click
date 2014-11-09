require 'rails_helper'

describe ReportHelper do
  describe '#sign' do
    pending
  end

  describe '#hour_minute' do
    it { expect(helper.hour_minute(8.hour)).to eq '08:00' }
    it { expect(helper.hour_minute(30.hour)).to eq '30:00' }
  end

  describe '#second_exit' do
    let(:report) { FactoryGirl.build(:report) }
    let(:report_without_second_exit) { FactoryGirl.build(:report_without_second_exit) }
    let(:report_without_second_reports) { FactoryGirl.build(:report_without_second_exit, second_entry: '') }

    context 'when second_exit is NOT blank' do
      it { expect(helper.second_exit(report)).to eq report.second_exit }
    end

    context 'when second_exit is blank and estimated_exit exists' do
      let(:expected) do
        "<span title='Saída Estimada' class='text-muted'>
          <i class='fa fa-fw fa-sign-out'></i>
          18:30
        </span>".squish
      end
      it { expect(helper.second_exit(report_without_second_exit).squish).to eq expected }
    end

    context 'when second_exit and estimated_exit are blank' do
      it { expect(helper.second_exit(report_without_second_reports)).to eq nil }
    end
  end
end
