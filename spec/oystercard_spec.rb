require 'oystercard'
describe Oystercard do
subject(:card) { described_class.new }

  it "should be initialised with a default balance of 0" do
    expect(card.balance).to eq 0
  end

  it "should be able to be topped-up" do
    card.topup(50)
    expect(card.balance).to eq 50
  end

end
