class Journey
  attr_reader :entry_station, :exit_station, :journey

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
    @journey = {entry: @entry_station}
  end

  def in_journey?
    @exit_station == nil
  end
  
  def end_journey(exit_station)
    @exit_station = exit_station
    @journey[:exit] = @exit_station
  end
end