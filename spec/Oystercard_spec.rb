require 'oystercard'

describe Oystercard do
  it 'checks default balance is zero' do
    expect(subject.balance).to eq 0
  end

  it "adds topup amount to card" do
    subject.top_up(7)
    expect(subject.balance).to eq 7
  end
end
