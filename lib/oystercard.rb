class Oystercard

  attr_accessor :balance
  attr_reader :in_journey

  NEW_CARD_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(balance = NEW_CARD_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def topup(amount)
    raise "Maximum Balance Is #{MAXIMUM_BALANCE}" if over_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Insufficient Funds" if no_funds?
    @in_journey = true
  end

  def touch_out
    deduct
    @in_journey = false
  end


private

def over_limit?(amount)
  @balance + amount > MAXIMUM_BALANCE
end

def no_funds?
  @balance < MINIMUM_FARE
end

def deduct(amount = MINIMUM_FARE)
  @balance -= amount
end




end
