require 'rails_helper'

describe ReportHelper do
  describe '#sign' do
    pending
  end

  describe '#hour_minute' do
    it { expect(helper.hour_minute(8.hour)).to eq '08:00' }
    it { expect(helper.hour_minute(30.hour)).to eq '30:00' }
  end
end
