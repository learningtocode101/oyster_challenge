class Oystercard
attr_reader :balance, :in_journey
MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Maximum balance is £#{MAXIMUM_BALANCE}" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in
    raise "Insufficient £#{MINIMUM_FARE} balance" if @balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

  def in_journey?
    in_journey
  end

private

def deduct(fare)
  @balance -= fare
end

end
