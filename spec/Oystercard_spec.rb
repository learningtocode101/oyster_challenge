require 'oystercard'

describe Oystercard do
  it 'checks default balance is zero' do
    expect(subject.balance).to eq 0
  end

  it "adds topup amount to card" do
    expect{ subject.top_up 1 }.to change { subject.balance }.by 1
  end
end
