require 'oystercard'

describe Oystercard do
  it 'checks default balance is zero' do
    expect(subject.balance).to eq 0
  end

  it "adds topup amount to card" do
    expect{ subject.top_up 1 }.to change { subject.balance }.by 1
  end

  context "has a balance of maximum" do
    before { subject.top_up(Oystercard::MAXIMUM_BALANCE) }

      it "raises an error is maximum top up limit is reached" do
        max_balance = Oystercard::MAXIMUM_BALANCE
        expect { subject.top_up 1 }.to raise_error("Maximum balance is £#{max_balance}")
      end

      it "deduct fare from card" do
        expect { subject.deduct 8 }.to change { subject.balance }.by -8
      end

      it "returns true when card user touches in" do
        subject.touch_in
        expect(subject).to be_in_journey
      end
    end
  it "returns false when card users touches out" do
    subject.touch_out
    expect(subject).to_not be_in_journey
  end

  it "check default value of in_journey is false" do
    subject.in_journey?
    expect(subject).to_not be_in_journey
  end

  it "checks minimum balance on card for journey" do
    min_fare = Oystercard::MINIMUM_FARE
    expect { subject.touch_in }.to raise_error ("Insufficient £#{min_fare} balance")
  end
end
