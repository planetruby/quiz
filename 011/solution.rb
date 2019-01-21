####
# Entry by Frank J. Cameron
#   see https://rubytalk.org/t/re-ruby-quiz-challenge-11-blockchain-contracts-disassemble-assemble-ethereum-virtual-machine-evm-opcodes-bytecodes/74915

module Frank

  @@op2hex = Ethereum::Opcodes::TABLE
             .transform_values{|v| v.to_s.freeze}

  @@hex2op = Ethereum::Opcodes::TABLE.invert
             .transform_values{|v| v.to_s(16).rjust(2, '0').freeze}

  def disassemble(hex)
    n = 0
    hex.chars.each_slice(2).map{|a,b|
      if n == 0
        c = "#{a}#{b}".to_i(16)
        t = (0x60..0x7f).include?(c) ? "#{n = c - 0x5f; ' 0x'}" : ''
        "\r\n#{@@op2hex[c]}#{t}"
      else
        n -= 1
        "#{a}#{b}"
      end
    }.join[8..]
  end

  def assemble(code)
    code.scan(/^(\w+)(?: 0x(\w+))?\r?$/).map{|a,b|
      "#{@@hex2op[a.intern]}#{b}"
    }.join.prepend('0x')
  end

end # module Frank


#############
# Test entry
#   by Gerald Bauer

module TestAnswer

def disassemble( hex )  # returns (code) text with opcodes
  hex = hex[2..-1]  if hex.start_with?( '0x' )    # cut off leading 0x

  bytes = [hex].pack('H*').bytes   # convert (hex) string to bytearray

  lines = []
  while bytes.size > 0
    opcode = bytes.shift

    ins = Ethereum::Opcodes::TABLE[opcode]
    if ins =~ /^PUSH([0-9]+)$/
      num  = $1.to_i
      args_hex = num.times.map { '%02x' % bytes.shift }.join
      lines << "#{ins} 0x#{args_hex}"
    else
      lines << "#{ins}"
    end
  end
  lines.join( "\n" )
end


def assemble( code )  # returns (hex) string
  hex = '0x'

  words = code.split
  words.each do |word|
    if word =~ /^0x/
      hex << word[2..-1]
    else  # assume instruction / opcode mnemonic
      opcode = Ethereum::Opcodes::REVERSE_TABLE[word.to_sym]
      hex << ('%02x' % opcode)
    end
  end
  hex
end

end # module TestAnswer



