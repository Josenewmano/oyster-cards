require_relative 'journey_log'

class OysterCard
  attr_reader :balance, :limit, :entry_station, :list_of_journeys

  LIMIT = 90
  MINIMUM = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @limit = LIMIT
    @journey_log = JourneyLog.new
  end

  def top_up(amount)
    raise "Top-up will exceed limit of £#{@limit}" if exceed_limit?(amount)

    @balance += amount
    "Your balance is £#{@balance}"
  end


  def touch_in(station)
    raise 'Insufficient balance' if insufficient_balance?
    fare if @journey_log.current_journey != nil
    @journey_log.start(station)
  end

  def touch_out(exit_station)
    fare if @journey_log.current_journey == nil
    @journey_log.current_journey.end_journey(exit_station)
    deduct(MINIMUM)
  end

  # def journey_history
  #   journey_history = []
  #   @list_of_journeys.each do |journey|
  #     journey_history.push("Entered at: #{journey[:entry]}, exited at: #{journey[:exit]}")
  #   end
  #   journey_history unless journey_history.empty?
  # end

  private

  def deduct(amount)
    # raise "Not enough money on the card" if overdrawn?(amount)
    @balance -= amount
    "Your balance is now £#{@balance}"
  end

  def exceed_limit?(amount)
    @balance + amount > @limit
  end

  # def overdrawn?(amount)
  #   @balance < amount
  # end

  def insufficient_balance?
    @balance < MINIMUM
  end

  def fare
      @balance -= PENALTY_FARE
      @journey = nil
  end
end
