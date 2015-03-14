require 'rails_helper'

describe ApplicationHelper do
  describe '#flash_class' do
    context 'success' do
      it 'returns success class' do
        expect(flash_class('success')).to eq 'success'
      end
    end

    context 'error' do
      it 'returns danger class' do
        expect(flash_class('error')).to eq 'danger'
      end
    end

    context 'notice' do
      it 'returns info class' do
        expect(flash_class('notice')).to eq 'info'
      end
    end

    context 'alert' do
      it 'returns warning class' do
        expect(flash_class('alert')).to eq 'warning'
      end
    end
  end

  describe 'flash_icon' do
    context 'success' do
      it 'returns fa-check class' do
        expect(flash_icon('success')).to eq 'fa-check'
      end
    end

    context 'error' do
      it 'returns fa-ban class' do
        expect(flash_icon('error')).to eq 'fa-ban'
      end
    end

    context 'notice' do
      it 'returns fa-info class' do
        expect(flash_icon('notice')).to eq 'fa-info'
      end
    end

    context 'alert' do
      it 'returns fa-warning class' do
        expect(flash_icon('alert')).to eq 'fa-warning'
      end
    end
  end

  describe 'message' do
    context 'when param is empty' do
      it 'returns an empty string' do
        expect(message('')).to eq ''
      end
    end

    context 'when param is not empty' do
      let(:messages) { [ 'msg1', 'msg2' ] }
      let(:msg1)     { '<p>msg1</p>' }
      let(:msg2)     { '<p>msg2</p>' }

      it 'returns a html safe callout callout-danger class within p' do
        [ msg1, msg2 ].each do |msg|
          expect(message(messages)).to match msg
        end
      end
    end
  end

  describe 'popover' do
    it 'returns popover toggle with content passed as parameter' do
      expect(popover('test')).to eq "popover data-toggle='popover' data-content='test'"
    end
  end
end
