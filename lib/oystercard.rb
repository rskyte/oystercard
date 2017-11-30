require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_accessor :balance
  attr_reader :journey_list

  NEW_CARD_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(balance = NEW_CARD_BALANCE)
    @balance = balance
    @journey_list = []
    @current_journey = nil
  end

  def topup(amount)
    raise "Maximum Balance Is #{MAXIMUM_BALANCE}" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station, journey = Journey.new)
    double_touch_in if in_journey?
    #raise 'Must touch out before starting new journey' if in_journey?
    raise 'Insufficient Funds' if no_funds?
    @current_journey = journey.start(station)
  end

  def touch_out(station, journey = Journey.new)
    @current_journey = journey if !in_journey?
    @current_journey.finish(station)
    deduct(@current_journey.fare)
    journey_reset
  end

  def in_journey?
    !!@current_journey
  end

  private

  def double_touch_in
    deduct(@current_journey.fare)
    journey_reset
  end

  def journey_reset
    @journey_list << @current_journey
    @current_journey = nil
  end

  def over_limit?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def no_funds?
    @balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end
end
