require_relative '../lib/journey'

describe Journey do 
  it "is 'in journey'" do
    journey = Journey.new("station")
    expect(journey.in_journey?).to be true
  end

  it "is completed when the journey log has an entry station and an exit station" do
    journey = Journey.new("station")
    journey.end_journey("station")
    expect(journey.journey).to include(:entry, :exit)
  end
end