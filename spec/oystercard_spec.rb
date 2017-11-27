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

end
