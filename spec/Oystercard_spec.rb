require 'oystercard'

describe Oystercard do
  it 'checks default balance is zero' do
    expect(subject.balance).to eq 0
  end

end
