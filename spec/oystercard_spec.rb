require 'oystercard.rb'

describe Oystercard do
  subject(:card) { described_class.new(0 ,journey_log) } #(0 ,journey_log)
  let(:station) { double(:my_station, name: 'name') }
  #let(:journey) { double(:my_journey,
  #   fare: Oystercard::MINIMUM_FARE,
  #   start: journey)}
  # let(:penalty_journey) { double(:my__penalty_journey,
  #   finish: true,
  #   start: double(:my_penalty_journey1, finish: true, fare: Oystercard::PENALTY_FARE),
  #   fare: Oystercard::PENALTY_FARE) }
  let(:journey_log) { double(:my_journey_log,
    in_journey?: false,
    fare: Oystercard::PENALTY_FARE,
    start: true,
    journeys: [],
    finish: true)}
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
        allow(journey_log).to receive(:in_journey?) { true }
        expect(card.in_journey?).to eq true
      end

      it 'charges penalty fare for double touch in' do
        allow(journey_log).to receive(:in_journey?) { true }
        expect { card.touch_in(station) }.to change { card.balance }
        .by -Oystercard::PENALTY_FARE
      end

      it 'should not let you touch in with balance less than 1', :skip_before do
        expect { card.touch_in(station) }
          .to raise_error 'Insufficient Funds'
      end
    end

    describe '#touch_out' do

      it 'should touch out' do
        card.touch_out(station)
        expect(card.in_journey?).to eq false
      end

      it 'should deduct the correct fare for a journey when touching out' do
        allow(journey_log).to receive(:in_journey?) { true }
        allow(journey_log).to receive(:fare) { Oystercard::MINIMUM_FARE}
        expect { card.touch_out(station) }.to change { card.balance }.by(-Oystercard::MINIMUM_FARE)
      end

      it 'records journey history' do
        allow(journey_log).to receive(:finish) {journey_log.journeys << 1}
        expect { card.touch_out(station) }.to change { card.read_journeys.size }.by 1
      end

      it 'creates a new journey if there is no current journey', :skip_before do
        card.topup(20)
        allow(journey_log).to receive(:finish) {journey_log.journeys << 1}
        expect { card.touch_out(station) }.to change { card.read_journeys.size }.by 1
      end
    end
  end
end
