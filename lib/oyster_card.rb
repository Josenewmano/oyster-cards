class OysterCard
  attr_reader :balance, :limit, :entry_station, :list_of_journeys

  LIMIT = 90
  MINIMUM = 1

  def initialize
    @balance = 0
    @limit = LIMIT
    @list_of_journeys = []
  end

  def top_up(amount)
    raise "Top-up will exceed limit of £#{@limit}" if exceed_limit?(amount)

    @balance += amount
    "Your balance is £#{@balance}"
  end


  def touch_in(station)
    raise 'Insufficient balance' if insufficient_balance?

    @journey = Journey.new(station)
  end

  def touch_out(exit_station)
    @journey.end_journey(exit_station)
    @list_of_journeys.push(@journey.journey)
    deduct(MINIMUM)
    'Journey complete.'
  end

  def journey_history
    journey_history = []
    @list_of_journeys.each do |journey|
      journey_history.push("Entered at: #{journey[:entry]}, exited at: #{journey[:exit]}")
    end
    journey_history unless journey_history.empty?
  end

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
end
