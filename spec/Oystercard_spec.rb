require 'oystercard'

describe Oystercard do
  it 'checks default balance is zero' do
    expect(subject.balance).to eq 0
  end

  it "adds topup amount to card" do
    expect{ subject.top_up 1 }.to change { subject.balance }.by 1
  end

  it "raises an error is maximum top up limit is reached" do
    max_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(max_balance)
    expect { subject.top_up 1 }.to raise_error("Maximum balance is £#{max_balance}")
  end
end
