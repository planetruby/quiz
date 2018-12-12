####
# Entry by Delton Ding
#   see https://rubytalk.org/t/ruby-quiz-challenge-8-base32-alphabet-convert-the-super-sekretoooo-240-bit-cryptokitties-genome-to-kai-notation-annipurrsary/74871/2

module Delton

def kai_encode( num )
  num.to_s(2).rjust(240, '0').scan(/.{5}/).map {|n| '123456789abcdefghijklmnopqrstuvwx'[n.to_i(2)]}.join
end

def kai_fmt( kai )
  kai.scan(/.{4}/).join(' ')
end

end  ## module Delton



####
# Entry by Frank J. Cameron
#   see https://rubytalk.org/t/ruby-quiz-challenge-8-base32-alphabet-convert-the-super-sekretoooo-240-bit-cryptokitties-genome-to-kai-notation-annipurrsary/74871/3

module Frank

 Encode = [(1..9),('a'..'k'),('l'..'x')].map(&:to_a).inject(&:+)

 def kai_encode( num )
    num
    .to_s(2)
    .rjust(240, '0')
    .yield_self{|bs| (0..235).step(5).map{|i| bs[i,5]}}
    .map{|n| Encode[n.to_i(2)]}
    .join
  end

  def kai_fmt( kai )
    kai
    .chars
    .each_slice(4)
    .map(&:join)
    .join(' ')
  end
end  

end  ## module Frank


#############
# Test entry
#   by Gerald Bauer

module TestAnswer

  ALPHABET = '123456789abcdefghijkmnopqrstuvwx'
  BASE = ALPHABET.length ## 32 chars/letters/digits

  def kai_encode( num )
    buf = String.new
    while num >= BASE
      mod = num % BASE
      buf = ALPHABET[mod] + buf
      num = (num - mod)/BASE
    end
    ALPHABET[num] + buf
  end

  def kai_fmt( kai )
    ## note: allow spaces; remove them all first
    kai = kai.gsub( ' ', '' )
    kai.reverse.gsub( /(.{4})/, '\1 ').reverse.strip
  end

end
