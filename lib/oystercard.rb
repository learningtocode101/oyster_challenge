class Oystercard
attr_reader :balance, :history, :journey
MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1
DEFAULT_BALANCE = 0

  def initialize
    @balance = DEFAULT_BALANCE
    @journey = {entry_station: nil, exit_station: nil}
    @history = []
  end

  def top_up(amount)
    raise "Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient £#{MINIMUM_FARE} balance" if @balance < MINIMUM_FARE
    return if in_journey?
    @journey[:entry_station] = station

  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey[:exit_station] = station
    updates_history
    return if !in_journey?
  end

  def in_journey?
    if @journey[:entry_station]
      true
    elsif @journey[:exit_station]
      false
    end
end

private

def deduct(fare)
  @balance -= fare
end

def updates_history
  @history << @journey
  @journey = {entry_station: nil, exit_station: nil}
end

end
