require_relative '../lib/station'

describe Station do

  it 'creates a station name upon creation' do
    station = Station.new(:Bank, 1)
    expect(station.station_name).to eq(:Bank)
  end

  it 'creates a station zone upon creation' do
    station = Station.new(:Bank, 1)
    expect(station.zone).to eq 1
  end
end