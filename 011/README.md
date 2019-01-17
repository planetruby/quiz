# Ruby Quiz - Challenge #11 - Blockchain Contracts - Disassemble & Assemble Ethereum Virtual Machine (EVM) Opcodes / Bytecodes

Ethereum - the decentralized "world computer" -
lets you store and run your own (contract) code on the blockchain.

Remember
the "magic" sooper-sekret gene mixing operation formula
in the CryptoKitties GeneSciene contract?

You can find the "raw" bytecode encoded as a (hex) string
for the virtual stack machine
in the contract at
[`etherscan.io/address/0xf97e0a5b616dffc913e72455fde9ea8bbe946a2b#code`](https://etherscan.io/address/0xf97e0a5b616dffc913e72455fde9ea8bbe946a2b#code).

```
0x60606040526004361061006c5763ffffffff7c0100000000000000000000000000000000000000
0000000000000000006000350416630d9f5aed81146100715780631597ee441461009f57806354c1
5b82146100ee57806361a769001461011557806377a74a201461017e575b600080fd5b341561007c
57600080fd5b61008d6004356024356044356101cd565b60405190815260200160405180910390f3
...
52600019909101906020018161072b57905050905600
```

If you click on "Switch to Opcodes" you
will see an
almost endless stream of to-the-metal Ethereum stack machine
instructions:

```
PUSH1 0x60
PUSH1 0x40
MSTORE
PUSH1 0x04
CALLDATASIZE
LT
PUSH2 0x006c
JUMPI
PUSH4 0xffffffff
PUSH29 0x0100000000000000000000000000000000000000000000000000000000
PUSH1 0x00
CALLDATALOAD
DIV
AND
PUSH4 0x0d9f5aed
DUP2
EQ
PUSH2 0x0071
JUMPI
DUP1
PUSH4 0x1597ee44
EQ
PUSH2 0x009f
JUMPI
DUP1
PUSH4 0x54c15b82
...
```


The challenge:  Code a `disassemble` and an `assemble` method that pass the RubyQuizTest :-).

For the starter level 1 turn the hex string
into a series of opcodes with the `disassemble` method.

``` ruby
def disassemble( hex )
  # ...
end
```

And for the bonus level 2 turn the series of opcodes
back into a hex string with the `assemble` method.

``` ruby
def assemble( code )
  # ...
end
```


Start from scratch or, yes, use any library / gem you can find.
To help along the test includes all opcodes / bytecodes:

``` ruby
module Ethereum
  class Opcodes

    TABLE = {
      0x00 => :STOP,
      0x01 => :ADD,
      0x02 => :MUL,
      0x03 => :SUB,
      0x04 => :DIV,
      0x05 => :SDIV,
      0x06 => :MOD,
      0x07 => :SMOD,
      0x08 => :ADDMOD,
      0x09 => :MULMOD,
      0x0a => :EXP,
      0x0b => :SIGNEXTEND,
      0x10 => :LT,
      0x11 => :GT,
      0x12 => :SLT,
      0x13 => :SGT,
      0x14 => :EQ,
      0x15 => :ISZERO,
      0x16 => :AND,
      0x17 => :OR,
      0x18 => :XOR,
      0x19 => :NOT,
      0x1a => :BYTE,
      0x20 => :KECCAK256,   ## note: SHA3 in "older" tables
      0x30 => :ADDRESS,
      0x31 => :BALANCE,
      0x32 => :ORIGIN,
      0x33 => :CALLER,
      0x34 => :CALLVALUE,
      0x35 => :CALLDATALOAD,
      0x36 => :CALLDATASIZE,
      0x37 => :CALLDATACOPY,
      0x38 => :CODESIZE,
      0x39 => :CODECOPY,
      0x3a => :GASPRICE,
      0x3b => :EXTCODESIZE,
      0x3c => :EXTCODECOPY,
      0x40 => :BLOCKHASH,
      0x41 => :COINBASE,
      0x42 => :TIMESTAMP,
      0x43 => :NUMBER,
      0x44 => :DIFFICULTY,
      0x45 => :GASLIMIT,
      0x50 => :POP,
      0x51 => :MLOAD,
      0x52 => :MSTORE,
      0x53 => :MSTORE8,
      0x54 => :SLOAD,
      0x55 => :SSTORE,
      0x56 => :JUMP,
      0x57 => :JUMPI,
      0x58 => :PC,
      0x59 => :MSIZE,
      0x5a => :GAS,
      0x5b => :JUMPDEST,
      0xa0 => :LOG0,
      0xa1 => :LOG1,
      0xa2 => :LOG2,
      0xa3 => :LOG3,
      0xa4 => :LOG4,
      0xf0 => :CREATE,
      0xf1 => :CALL,
      0xf2 => :CALLCODE,
      0xf3 => :RETURN,
      0xf4 => :DELEGATECALL,
      0xf5 => :CREATE2,
      0xff => :SUICIDE,
      0xfd => :REVERT,
      0xfe => :INVALID,
    }

    32.times do |i|
      TABLE[0x60+i] = :"PUSH#{i+1}"
    end

    16.times do |i|
      TABLE[0x80+i] = :"DUP#{i+1}"
      TABLE[0x90+i] = :"SWAP#{i+1}"
    end


    REVERSE_TABLE = TABLE.reduce({}) do |table, (opcode, name)|
      table[name] = opcode
      table
    end
  end # class Opcodes
end # module Ethereum
```

Use:

``` ruby
Ethereum::Opcodes::TABLE[0x60]  #=> :PUSH1
Ethereum::Opcodes::TABLE[0x61]  #=> :PUSH2
Ethereum::Opcodes::TABLE[0x00]  #=> :STOP
```

to lookup the instruction name from the bytecode (e.g. `0x60`, `0x61`, `0x00`, etc.).
And use:

``` ruby
Ethereum::Opcodes::REVERSE_TABLE[:PUSH1]  #=> 0x60
Ethereum::Opcodes::REVERSE_TABLE[:PUSH2]  #=> 0x61
Ethereum::Opcodes::REVERSE_TABLE[:STOP]   #=> 0x00
```

to lookup the bytecode from the instruction name (e.g. `PUSH1`, `PUSH2`, `STOP`).

Note: In the hex string every byte is a bytecode instruction
with the ONLY exception of `PUSH1`, `PUSH2`, `PUSH3` .. `PUSH32`.
The `PUSH1` instruction places the following 1-byte on the stack
(e.g. disassemble to `PUSH1 0x60`).
The `PUSH2` instruction places the following 2-bytes on the stack
(e.g. disassemble to `PUSH4 0x006c`).
The `PUSH29` instruction places the following 29-bytes on the stack
(e.g. disassemble to `PUSH29 0x0100000000000000000000000000000000000000000000000000000000
`) and so on.

TIP: If interested read more about the Ethereum Virtual Machine (EVM)
and the opcodes / bytcodes in
the (free online) ["The Ethereum Virtual Machine"](https://github.com/ethereumbook/ethereumbook/blob/develop/13evm.asciidoc) chapter
in the Mastering Ethereum book by Andreas M. Antonopoulos and Gavin Wood.


To qualify for solving the code challenge / puzzle you must pass the test:


``` ruby
require 'minitest/autorun'

require_relative './opcodes'


class RubyQuizTest < MiniTest::Test

  def mixgenes_hex
     hex = <<TXT
0x60606040526004361061006c5763ffffffff7c0100000000000000000000000000000000000000
0000000000000000006000350416630d9f5aed81146100715780631597ee441461009f57806354c1
5b82146100ee57806361a769001461011557806377a74a201461017e575b600080fd5b341561007c
57600080fd5b61008d6004356024356044356101cd565b60405190815260200160405180910390f3
5b34156100aa57600080fd5b61008d60046024813581810190830135806020818102016040519081
0160405280939291908181526020018383602002808284375094965061055a95505050505050565b
34156100f957600080fd5b61010161059d565b604051901515815260200160405180910390f35b34
1561012057600080fd5b61012b6004356105a6565b60405160208082528190810183818151815260
200191508051906020019060200280838360005b8381101561016a57808201518382015260200161
0152565b505050509050019250505060405180910390f35b341561018957600080fd5b6101946004
3561061e565b604051808261018080838360005b838110156101ba57808201518382015260200161
01a2565b5050505090500191505060405180910390f35b60008060006101da610709565b6101e261
0709565b6101ea610709565b60008080808080438d90116101fe57600080fd5b8c409a508a151561
022b5760ff8d1660ff194316019c50438d101515610226576101008d039c505b8c409a505b8a8f8f
8f604051808581526020018481526020018381526020018281526020019450505050506040519081
900390209a50600099506102698f6105a6565b98506102748e6105a6565b97506030604051805910
6102855750595b90808252806020026020018201604052509650600093505b600c8410156103ee57
600392505b600183106103e35782846004020195506102c78b60028c610668565b915060028a0199
508160001415610349578886815181106102e457fe5b906020019060200201519450886001870381
5181106102ff57fe5b9060200190602002015189878151811061031557fe5b60ff90921660209283
0290910190910152848960001988018151811061033757fe5b60ff90921660209283029091019091
01525b6103558b60028c610668565b915060028a01995081600014156103d7578786815181106103
7257fe5b90602001906020020151945087600187038151811061038d57fe5b906020019060200201
518887815181106103a357fe5b60ff90921660209283029091019091015284886000198801815181
106103c557fe5b60ff9092166020928302909101909101525b600019909201916102ab565b600190
93019261029d565b600095505b603086101561053e57506000600486061580156104405750878681
51811061041757fe5b9060200190602002015160011689878151811061043057fe5b906020019060
2002015160011614155b15610491576104518b60038c610668565b915060038a01995061048e8987
8151811061046857fe5b9060200190602002015189888151811061047e57fe5b9060200190602002
01518461067e565b90505b60008160ff1611156104c057808787815181106104aa57fe5b60ff9092
16602092830290910190910152610533565b6104cc8b60018c610668565b915060018a0199508160
0014156104ff578886815181106104e957fe5b906020019060200201518787815181106104aa57fe
5b87868151811061050b57fe5b9060200190602002015187878151811061052157fe5b60ff909216
6020928302909101909101525b6001909501946103f3565b6105478761055a565b9f9e5050505050
50505050505050505050565b6000805b60308110156105975760209091029082602f829003815181
1061057d57fe5b9060200190602002015160ff16919091179060010161055e565b50919050565b60
005460ff1681565b6105ae610709565b6105b6610709565b600060306040518059106105c7575059
5b90808252806020026020018201604052509150600090505b6030811015610617576105f2848261
06f1565b8282815181106105fe57fe5b60ff9092166020928302909101909101526001016105df56
5b5092915050565b61062661071b565b61062e61071b565b60005b600c8110156106175761064784
826004026106f1565b8282600c811061065357fe5b60ff9092166020929092020152600101610631
565b600290810a91900a600019018102919091160490565b600083838260ff808316908416111561
0698578691508592505b82820360ff1660011480156106b65750600260ff84160660ff166000145b
156106e75760178360ff1610156106cf575060016106d3565b5060005b8085116106e757600260ff
84160460100193505b5050509392505050565b600061070283600584600502610668565b93925050
50565b60206040519081016040526000815290565b610180604051908101604052600c815b600081
52600019909101906020018161072b57905050905600
TXT

  hex = hex.gsub( /[ \t\n\r]/, '' )  ## remove all whitespaces and newlines (/r/n)
  hex
end

def mixgenes_code
  code = File.read( './mixgenes.opcodes' )
  code = code.strip   ## note: strip trailing newline
  code
end



def test_mixgenes_level1
  assert_equal mixgenes_code, disassemble( mixgenes_hex )
end

def test_mixgenes_level2
  assert_equal mixgenes_hex,  assemble( mixgenes_code )
end


def test_mixgenes
  assert_equal mixgenes_hex,  assemble( disassemble( mixgenes_hex ))
end

end # class RubyQuizTest
```


Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy opscode hacking and blockchain contract bytecode assembling & disassembling with Ruby.
