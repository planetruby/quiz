####################################
# Vote On My Tesla Color Contract

Color = Enum.new( :solid_black,              # 0
                  :midnight_silver_metallic, # 1
                  :deep_blue_metallic,       # 2
                  :silver_metallic,          # 3
                  :red_multi_coat )          # 4

Votes  = Event.new( :color, :num )
Winner = Event.new( :color )


# constructor for initializing VoteOnMyTeslaColor
#  the owner is the genius who made the revolutionary smart contract PonzICO
#  obviously blue starts with 10 votes because it is objectively the BEST color
def setup
  @owner = msg.sender
  @votes = Mapping.of( Color   => Integer )
  @voted = Mapping.of( Address => Bool    )

  # YOURE MY BOY BLUE
  @votes[ Color.deep_blue_metallic ] = 10

  # hardcode production PonzICO address
  @ponzico = PonzICO.at( 0x1ce7986760ADe2BF0F322f5EF39Ce0DE3bd0C82B )
end

# SUPER ACCREDITED INVESTORS ONLY, YOU CAN ONLY VOTE ONCE
def vote( choice )
  assert @ponzico.invested[msg.sender] >= 100.finney && @voted[msg.sender] == false

  color = Color( choice )
  # 0.1 ETH (100 finney) invested in PonzICO per vote, truncated
  num =  @ponzico.invested[msg.sender] / 100.finney
  @votes[color]      += num
  @voted[msg.sender]  = true
  log Votes.new( color, num )
end


# pay to vote again! I don't care!
#  ...but it'll cost you 1 ether for me to look the other way, wink wink
def its_like_chicago
  assert @voted[msg.sender] && msg.value >= 1.ether
  @voted[msg.sender] = false
end

def winnovate
   assert msg.sender == owner
   winner = Color.solid_black
   (1..5).each do |choice|
     if @votes[choice] > @votes[choice-1]
        winner = Color(choice)
     end
  end

  log Winner.new( winner )
  # keeping dat blockchain bloat on check
  selfdestruct(owner)
end
