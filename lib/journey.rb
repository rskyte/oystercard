require_relative 'station'

class Journey
  attr_reader :start_point, :end_point, :fare

  def initialize
    @fare = 0
  end

  def start(station)
    @start_point = station.name
    @start_zone = station.zone
    @complete = try_to_complete_journey
    self
  end

  def finish(station)
    @end_point = station.name
    @end_zone = station.zone
    @complete = try_to_complete_journey
    self
  end

  def try_to_complete_journey
    !!@start_point && !!@end_point
  end

  def calc_fare
     (@start_zone - @end_zone).abs + Oystercard::MINIMUM_FARE
  end

  def choose_fare
    complete? ? calc_fare : Oystercard::PENALTY_FARE
  end

  def fare
    @fare += choose_fare
  end

  def complete?
    @complete
  end



end
