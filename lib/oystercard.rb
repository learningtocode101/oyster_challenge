class Oystercard
attr_reader :balance, :in_journey, :entry_station
MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1
DEFAULT_BALANCE = 0

  def initialize
    @balance = DEFAULT_BALANCE
    #@in_journey = false
    @entry_station = nil
  end

  def top_up(amount)
    raise "Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient £#{MINIMUM_FARE} balance" if @balance < MINIMUM_FARE
    @entry_station = station
    #@in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station
  end

private

def deduct(fare)
  @balance -= fare
end

end
