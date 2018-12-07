require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  let(:max_limit) { double Oystercard::MAXIMUM_BALANCE}
  subject(:oystercard) { described_class.new }

  it 'checks default balance is zero' do
    expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
  end

  describe '#top_up' do
    context 'no money on card' do
      it "adds top up amount to card" do
        expect{ oystercard.top_up 1 }.to change { oystercard.balance }.by 1
      end
    end
    context "maximum limit balance on card" do
      before { oystercard.top_up(Oystercard::MAXIMUM_BALANCE) }
        it "raises an error " do
          max_balance = Oystercard::MAXIMUM_BALANCE
          expect { oystercard.top_up 1 }.to raise_error("Maximum balance is £#{max_balance}")
        end
    end
  end
    describe '#touh_in' do
      before { oystercard.top_up(Oystercard::MAXIMUM_BALANCE) }
        it "returns true when card user touches in" do
          oystercard.touch_in(station)
          expect(oystercard.entry_station).to be_truthy
        end
        it "remembers entry station" do
          oystercard.touch_in(station)
          expect(oystercard.entry_station).to eq [station]
        end
    end

    describe '#touch_out' do
      it "deducts fare when" do
        oystercard.touch_out(station)
        expect { oystercard.touch_out(station) }.to change{ oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
      end
    end
      it "displays a list of journeys for exit_station" do
        oystercard.touch_out(station)
        expect(oystercard.exit_station).to eq station
      end

    it "checks minimum balance on card for journey" do
      min_fare = Oystercard::MINIMUM_FARE
      expect { oystercard.touch_in(station) }.to raise_error ("Insufficient £#{min_fare} balance")
    end

    it "sets entry_station  when users touches out" do
      oystercard.touch_out(station)
      expect(oystercard.entry_station). to eq []
    end

end
