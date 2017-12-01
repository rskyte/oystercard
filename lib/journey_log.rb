require_relative 'journey'

class JourneyLog

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)
    @current_journey = @journey_class.new
    current_journey.start(station)
  end

  def finish(station)
    current_journey
    current_journey.finish(station)
  end

  def journeys
    @journeys.dup
  end

  def start_point
    current_journey.start_point
  end

  def end_point
    current_journey.end_point
  end

  def in_journey?
    !!@current_journey
  end

  def fare
    fare = current_journey.fare
    journey_reset
    fare
  end

  private

  def journey_reset
    @journeys << current_journey
    @current_journey = nil
  end

  def current_journey
    @current_journey ||= @journey_class.new
  end
end
