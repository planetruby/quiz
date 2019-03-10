####################################
# PonzICO contract


# log event of successful investment/withdraw and address
Investment = Event.new( :investor, :amount )
Withdrawal = Event.new( :investor, :amount )

# constructor for initializing PonzICO.
#  the owner is the genius who made this revolutionary smart contract
def setup
	@owner     = msg.sender
  @total     = 0
  @invested  = Mapping.of( Address => Money )
  @balances  = Mapping.of( Address => Money )
  @investors = Array.of( Address )
end

# the logic for a small fee for the creator of this contract
#  miniscule in the grand scheme of things
def owner_fee( amount )
  assert @total < 200_000.ether
  fee = amount / 2
  @balances[@owner] += fee
  fee
end

# This is where the magic is withdrawn.
#  For users with balances. Can only be used to withdraw full balance.
def withdraw
  assert @balances[msg.sender] > 0

  amount = @balances[msg.sender]
  @balances[msg.sender] = 0
  if !msg.sender.send(amount)
    @balances[msg.sender] = amount
  else
    log Withdrawal.new(msg.sender, amount)
  end
end

# What's better than withdrawing? Re-investing profits!
def reinvest
  assert @balances[msg.sender] > 0

  dividend = @balances[msg.sender]
  @balances[msg.sender] = 0
  fee = owner_fee( dividend )
  dividend -= fee
  @investors.each do |investor|
    @balances[investors] += dividend * @invested[investors] / total
  end
  @invested[msg.sender] += (dividend + fee);
  total += (dividend + fee)
  log Investment.new(msg.sender, dividend+fee)
end

# This is the where the magic is invested.
#  Note the accreditedInvestor() modifier, to ensure only sophisticated
#  investors with 0.1 ETH or more can invest. #SelfRegulation
def invest
  assert msg.value > 100.finney

  # first send the owner's modest 50% fee but only if the total invested is less than 200000 ETH
  dividend = msg.value
  fee = owner_fee( dividend )
  dividend -= fee
  # then accrue balances from the generous remainder to everyone else previously invested
  @inverstors.each do |investor|
    @balances[investors += dividend * @invested[investors / total
  end

  # finally, add this enterprising new investor to the public balances
  if @invested[msg.sender] == 0
    @investors.push( msg.sender )
    @invested[msg.sender] = msg.value
  else
    @invested[msg.sender] += msg.value
  end
  total += msg.value
  log Investment.new(msg.sender, msg.value)
end


# finally, fallback function. no one should send money to this contract
#  without first being added as an investment.
def receive() throw; end
