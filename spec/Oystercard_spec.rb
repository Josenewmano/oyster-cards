require_relative '../lib/Oystercard.rb'

describe Oystercard do
  let (:station1) { double (:station) }
  let (:station2) { double (:station) }

  it "has a balance when created" do
    expect(subject.balance).to eq 0
  end

  it "can have the balance topped up" do
    expect(subject.top_up(5)).to eq "Your balance is £5"
  end

  it "has a maximum balance of £90" do
    subject.top_up(subject.limit)
    expect {subject.top_up(1) }.to raise_error("Top-up will exceed limit of £#{subject.limit}")
  end

=begin
  it "deduct amount from balance as long as balance is sufficient" do
    subject.top_up(50)
    expect(subject.deduct(5)).to eq "Your balance is now £45"
  end
=end

=begin
  it "prevents deduction if amount is greater than balance" do
    subject.top_up(4)
    expect{subject.deduct(5)}.to raise_error("Not enough money on the card")
  end
=end

  it {is_expected.to respond_to(:in_journey?)}

  it "will not touch in if balance is below the minimum fare" do
    expect { subject.touch_in(:station1) }.to raise_error("Insufficient balance")
  end

  it "remembers the entry station after touching in" do
    subject.top_up(5)
    expect { subject.touch_in(:station1) }.to change{ subject.entry_station }.to(:station1)
  end

  describe "with positive balance and touched in" do 
    before (:each) do
      subject.top_up(5)
      subject.touch_in(:station1)
    end
    
    it "is 'in journey'" do
      expect(subject.in_journey?).to be true
    end

    it "is not 'in journey' if it has been touched out" do
      subject.touch_out(:station2)
      expect(subject.in_journey?).to be false
    end

    it "will deduct the minimum fare when a journey is complete (touching out)" do
      expect { subject.touch_out(:station2) }.to change{ subject.balance }.by(-1)
    end
    
    it "will record exit station and add to journey history" do
      subject.touch_out(:station2)
      expect(subject.journey_history).to eq(["Entered at: #{:station1}, exited at: #{:station2}"])
    end
  end

end