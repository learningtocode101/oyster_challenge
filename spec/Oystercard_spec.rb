require 'oystercard'

describe Oystercard do
  let(:station) { double :station }

  it 'checks default balance is zero' do
    expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
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

      it "returns true when card user touches in" do
        subject.touch_in(station)
        expect(subject.entry_station).to be_truthy
      end

      it "deducts fare when card user touches out" do
        expect { subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
      end

      it "remembers entry station" do
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end

    end

  it "checks minimum balance on card for journey" do
    min_fare = Oystercard::MINIMUM_FARE
    expect { subject.touch_in(station) }.to raise_error ("Insufficient £#{min_fare} balance")
  end

  it "sets entry_station to nil when users touches out" do
    expect(subject.entry_station). to be_falsey
  end
end
