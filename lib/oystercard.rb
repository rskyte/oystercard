class Oystercard
  attr_accessor :balance
  attr_reader :entry_station

  NEW_CARD_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize(balance = NEW_CARD_BALANCE)
    @balance = balance
    @entry_station = nil
  end

  def topup(amount)
    raise "Maximum Balance Is #{MAXIMUM_BALANCE}" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient Funds' if no_funds?
    @entry_station = station.name
  end

  def touch_out
    @entry_station = nil
    deduct
  end

  def in_journey?
    !!@entry_station
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
