class Oystercard
  attr_accessor :balance
  NEW_CARD_BALANCE = 0

  def initialize(balance = NEW_CARD_BALANCE)
    @balance = balance
  end

  def topup(amount)
    @balance += amount
  end

end
