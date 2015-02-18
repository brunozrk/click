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

  describe '#pop_over_info' do
    context 'when notice is blank and working_day is true' do
      let(:notice) { '' }
      it { expect(helper.pop_over_info(notice, true)).to be_nil }
    end
    describe 'return some html' do
      let(:notice) { 'some text' }
      let(:nonworking_day) { '(Dia não útil)' }

      context 'when notice is NOT blank' do
        context 'when working_day is TRUE' do
          it { expect(helper.pop_over_info(notice, true)).to include notice }
          it { expect(helper.pop_over_info(notice, true)).to_not include nonworking_day }
        end

        context 'when working_day is FALSE' do
          it { expect(helper.pop_over_info(notice, false)).to include "#{notice} #{nonworking_day}" }
        end
      end

      context 'when working_day is FALSE' do
        context 'when notice is blank' do
          it { expect(helper.pop_over_info('', false)).to include nonworking_day }
          it { expect(helper.pop_over_info('', false)).to_not include notice }
        end
      end
    end
  end
end
