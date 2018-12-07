class Oystercard
attr_reader :balance, :entry_station, :exit_station
MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1
DEFAULT_BALANCE = 0

  def initialize
    @balance = DEFAULT_BALANCE
    @entry_station = []
    @exit_station = []
  end

  def top_up(amount)
    raise "Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient £#{MINIMUM_FARE} balance" if @balance < MINIMUM_FARE
    @entry_station << station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = []
    @exit_station = station
  end

  def in_journey?
    @entry_station
  end

private

def deduct(fare)
  @balance -= fare
end

end
