require_relative 'journey'

class JourneyLog

  def initialize
    @journeys = []
    @journey_class = journey_class
    @current_journey = nil
  end

  def start(station)
    current_journey
  end

  def finish(station)
    @current_journey.end_journey(station)
    @list_of_journeys.push(@journey.journey)
  end

  private

  def current_journey
    #checks if there is a current journey
    @current_journey = Journey.new(station)
  end


    

end