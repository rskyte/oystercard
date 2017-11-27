require "oystercard.rb"


describe Oystercard do
subject(:card) { described_class.new }

  it "should be initialised with a default balance of 0" do
    expect(card.balance).to eq 0
  end

  it "should be able to be topped-up" do
    card.topup(50)
    expect(card.balance).to eq 50
  end

  it "should have a maximum balance of 90" do
    maxed_limit = Oystercard::MAXIMUM_BALANCE
    expect { card.topup(maxed_limit + 1) }.to raise_error "Maximum Balance Is #{
    maxed_limit}"
  end

  it "should have an in_journey attribute" do
    expect(card).to respond_to(:in_journey)
  end

  it "should touch in" do
    card.topup(20)
    card.touch_in
    expect(card.in_journey).to eq true
  end

  it "should touch out" do
    card.topup(20)
    card.touch_in
    card.touch_out
    expect(card.in_journey).to eq false
  end

  it "should not let you touch in with balance less than 1" do
    expect {card.touch_in}.to raise_error "Insufficient Funds"
  end

  it "should deduct the minimum fare for a journey when touching out" do
    card.topup(20)
    card.touch_in
    expect {card.touch_out}.to change {card.balance}.by(-Oystercard::MINIMUM_FARE)
  end



  end
