require_relative 'station'
require_relative 'journey_log'

class Oystercard
  attr_accessor :balance

  NEW_CARD_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(balance = NEW_CARD_BALANCE, journey_log = JourneyLog.new)
    @balance = balance
    @journey_log = journey_log
  end

  def topup(amount)
    raise "Maximum Balance Is #{MAXIMUM_BALANCE}" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    journey_admin if in_journey?
    raise 'Insufficient Funds' if no_funds?
    journey_log.start(station)
  end

  def touch_out(station)
    raise 'Insufficient Funds' if no_funds?
    journey_log.finish(station)
    journey_admin
  end

  def in_journey?
    journey_log.in_journey?
  end

  def read_journeys
    journey_log.journeys
  end

  private

  def journey_log
    @journey_log
  end

  def journey_admin
    deduct(get_fare)
  end

  def get_fare
    journey_log.fare
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
