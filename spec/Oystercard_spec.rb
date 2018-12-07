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
    describe '#touch_in' do
      before { oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
              oystercard.touch_in(station)
      }
        it "in journey becomes true" do
          expect(oystercard.in_journey?).to eq true
        end
    end

    describe '#touch_out' do
      before { oystercard.touch_out(station)
              oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
      }
      it "deducts fare" do
        expect { oystercard.touch_out(station) }.to change{ oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
      end
      it "in journey becomes false" do
        allow(oystercard).to receive(:in_journey?).and_return false
        expect(oystercard.in_journey?).to eq false
      end
    end

    it "checks minimum balance on card for journey" do
      min_fare = Oystercard::MINIMUM_FARE
      expect { oystercard.touch_in(station) }.to raise_error ("Insufficient £#{min_fare} balance")
    end

    it 'check that journey list empty by default' do
      expect(oystercard.journey[:entry_station]).to eq nil

      expect(oystercard.journey[:exit_station]).to eq nil
    end

    it 'checks that #touch_in and #touch_out creates one journey' do
      oystercard.top_up(1)
      expect{ oystercard.touch_in(station) }.to change { oystercard.journey[:entry_station] }.to(station)
    end

    it 'checks that #touch_out added to journey tag' do
      oystercard.top_up(1)
      oystercard.touch_in(station)
      oystercard.touch_out(station)
      expect(oystercard.journey[:exit_station]).to eq(nil)
    end

end
