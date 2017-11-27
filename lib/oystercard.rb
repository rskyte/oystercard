class Oystercard

  attr_accessor :balance

  NEW_CARD_BALANCE = 0
  MAXIMUM_BALANCE = 90

  def initialize(balance = NEW_CARD_BALANCE)
    @balance = balance
  end

  def topup(amount)
    raise "Maximum Balance Is #{MAXIMUM_BALANCE}" if over_limit?(amount)
    @balance += amount
  end


private

def over_limit?(amount)
  @balance + amount > MAXIMUM_BALANCE
end


end
