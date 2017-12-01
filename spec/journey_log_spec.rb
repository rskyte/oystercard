require 'journey_log'

describe JourneyLog do

  let(:journey) { double :journey, start: true, finish: true, start_point: true, end_point: true, fare: true}
  let(:station) { double :station }
  let(:journey_class) { double :journey_class, new: journey }
  subject(:jl) { described_class.new(journey_class) }

  describe 'journey history' do
    it "should return a journey history" do
      expect(jl.journeys).to eq []
    end
  end

  describe "#start" do
    it "should start a new journey with an entry station" do
      jl.start(station)
      expect(jl.start_point).to be true
    end
  end

  describe '#finish' do
    it "should add an exit station to the current journey" do
      jl.start(station)
      jl.finish(station)
      expect(jl.end_point).to eq true
    end

    it "should log all journeys" do
      jl.start(station)
      jl.finish(station)
      expect { jl.fare }.to change { jl.journeys.size }.by 1
    end
  end
end
