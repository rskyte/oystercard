require_relative 'station'

class Journey
  attr_reader :start_point, :end_point

  PENALTY_FARE = 45

  def start(station)
    @start_point = station.name
    @complete = try_to_complete_journey
    self
  end

  def finish(station)
    @end_point = station.name
    @complete = try_to_complete_journey
    self
  end

  def try_to_complete_journey
    !!@start_point && !!@end_point
  end

  def fare
    complete? ? Oystercard::MINIMUM_FARE : PENALTY_FARE
  end

  def complete?
    @complete
  end

end
