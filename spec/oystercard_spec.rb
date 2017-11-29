require 'oystercard.rb'

describe Oystercard do
  subject(:card) { described_class.new }
  let(:station) { double(:my_station, name: 'name') }
  before do |example|
    unless example.metadata[:skip_before]
      card.topup(20)
      card.touch_in(station)
    end
  end

  describe 'Card balance' do

    it 'should be initialised with a default balance of 0', :skip_before do
      expect(card.balance).to eq 0
    end

    it 'should be able to be topped-up' do
      expect(card.balance).to eq 20
    end

    it 'should have a maximum balance of 90', :skip_before do
      maxed_limit = Oystercard::MAXIMUM_BALANCE
      expect { card.topup(maxed_limit + 1) }
        .to raise_error "Maximum Balance Is #{maxed_limit}"
    end
  end

  context 'Card in use' do
    describe '#touch_in' do

      it 'should touch in' do
        expect(card.in_journey?).to eq true
      end

      it 'should not let you touch in with balance less than 1', :skip_before do
        expect { card.touch_in(station) }
          .to raise_error 'Insufficient Funds'
      end

      it 'remembers touch in station' do
        expect(card.entry_station).to eq 'name'
      end
    end

    describe '#touch_out' do

      it 'should touch out' do
        card.touch_out
        expect(card.in_journey?).to eq false
      end

      it 'should deduct the minimum fare for a journey when touching out' do
        expect { card.touch_out }.to change { card.balance }.by(-Oystercard::MINIMUM_FARE)
      end

      it 'forgets entry station at touch out' do
        card.touch_out
        expect(card.entry_station).to eq nil
      end
    end
  end
end
