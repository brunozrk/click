require 'rails_helper'

describe ReportHelper do
  describe '#text_color' do
    context 'when status is true' do
      it { expect(helper.text_color(true)).to eq 'green' }
    end

    context 'when status is false' do
      it { expect(helper.text_color(false)).to eq 'red' }
    end
  end

  describe '#icon' do
    context 'when status is true' do
      it { expect(helper.icon(true)).to eq 'plus' }
    end

    context 'when status is false' do
      it { expect(helper.icon(false)).to eq 'minus' }
    end
  end

  describe '#format_time' do
    it 'format time to HH:MM' do
      expect(helper.format_time(17_400.0)).to eq '04:50'
      expect(helper.format_time(13_000.0)).to eq '03:36'
    end
  end
end
