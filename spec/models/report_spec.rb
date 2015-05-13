require 'rails_helper'

describe Report do
  context 'relations' do
    it { expect(subject).to belong_to(:user) }
  end

  context 'validations' do
    context 'presence of' do
      it { expect(subject).to validate_presence_of(:day) }
      it { expect(subject).to validate_presence_of(:remote) }
    end

    context 'uniqueness of' do
      it { expect(subject).to validate_uniqueness_of(:day).scoped_to(:user_id) }
    end

    context 'validate_entry_exit_order' do
      let(:report)        { build(:report, first_entry: '12:00', second_entry: '11:00') }
      let(:report_case_2) { build(:report, second_entry: '11:00') }

      it { expect(report).to_not be_valid }
      it { expect(report_case_2).to_not be_valid }

      it 'contains base error' do
        expect(report.valid?).to eq false
        expect(report.errors[:base].size).to eq 1
      end
    end
  end

  context 'with new instance' do
    let(:report) { build(:report) }

    it 'is valid' do
      expect(report).to be_valid
    end
  end

  describe '#worked' do
    let(:report) { build(:report) }
    it { expect(report.worked).to eq 8.hour }
  end

  describe '#balance' do
    let(:user)                  { build :user, hours_per_day: '08:00' }
    let(:report_positive)       { build :report, user: user, second_exit: '19:00' }
    let(:report_negative)       { build :report, user: user, second_exit: '17:00' }
    let(:report_away)           { build :report, user: user, away: true }
    let(:report_nonworking_day) { build :report, user: user, working_day: false }

    context 'when positive balance' do
      it { expect(report_positive.balance).to eq(time: 3600.0, sign: true) }
    end

    context 'when negative balance' do
      it { expect(report_negative.balance).to eq(time: 3600.0, sign: false) }
    end

    context 'when away' do
      it { expect(report_away.balance).to eq(time: 28_800.0, sign: false) }
    end

    context 'when nonworking day' do
      it { expect(report_nonworking_day.balance).to eq(time: 28_800.0, sign: true) }
    end

    context 'with hours_per_day different from rounded number' do
      before { user.update_attributes(hours_per_day: '08:30') }

      context 'when positive balance' do
        it { expect(report_positive.balance).to eq(time: 1800.0, sign: true) }
      end

      context 'when negative balance' do
        it { expect(report_negative.balance).to eq(time: 5400.0, sign: false) }
      end
    end
  end

  describe '#self.find_by_date_range' do
    let(:date) { Date.new(2014, 02, 03)  }

    it 'finds reports by date range' do
      expect(described_class.find_by_date_range(date, date).count).to eq 3
    end
  end
end
