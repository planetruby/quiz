# Ruby Quiz - Challenge #10 - Breeding Kitties - Mix Genes Using the Sooper-Sekret Formula in the GeneSciene CryptoKitties Blockchain Contract


CryptoKitties lets you breed new kitties. Pick a matron and a sire and a new bun is in the oven.

Now how does the "magic" mixing of genes work? What genes do new (offspring) kitties inherit from parents? What about mewtations, that is, new traits not present in a matron or sire?

The bad news is all CryptoKitties contracts are open source
EXCEPT the "magic" sooper-sekret gene mixing operation formula in the GeneSciene contract.
You can find the byte code in the contract at
[`etherscan.io/address/0xf97e0a5b616dffc913e72455fde9ea8bbe946a2b#code`](https://etherscan.io/address/0xf97e0a5b616dffc913e72455fde9ea8bbe946a2b#code).
If you click on "Switch to Opcode" you will see
almost endless to-the-metal stack machine byte code
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

Now the good news -
thanks to Sean Soria's reverse engineering work - see the article "[CryptoKitties mixGenes Function](https://medium.com/@sean.soria/cryptokitties-mixgenes-function-69207883fc80)" -
the code is now "cracked" and an open book.
Let's look at the `mixGenes` function in pseudocode:

```
def mixGenes(mGenes[48], sGenes[48], babyGenes[48]):
  # PARENT GENE SWAPPING
  for (i = 0; i < 12; i++):
    index = 4 * i
    for (j = 3; j > 0; j--):
      if random() < 0.25:
        swap(mGenes, index+j, index+j-1)
      if random() < 0.25:
        swap(sGenes, index+j, index+j-1)

  # BABY GENES
  for (i = 0; i < 48; i++):
    mutation = 0
    # CHECK MUTATION
    if i % 4 == 0:
      gene1 = mGene[i]
      gene2 = sGene[i]
      if gene1 > gene2:
        gene1, gene2 = gene2, gene1
      if (gene2 - gene1) == 1 and iseven(gene1):
        probability = 0.25
        if gene1 > 23:
          probability /= 2
        if random() < probability:
          mutation = (gene1 / 2) + 16

    # GIVE BABY GENES
    if mutation:
      baby[i] = mutation
    else:
      if random() < 0.5:
        babyGenes[i] = mGene[i]
      else:
        babyGenes[i] = sGene[i]
```

Yes, that's better (but not quite ruby-esque).
The challenge:
Code a `mixgenes` method that passes the RubyQuizTest :-),
that is, turn the pseudocode
into working code that you can run at your very own computer off the (block)chain
with a vanilla scripting language, that is, ruby.
Note: The `mixgenes` methods gets passed in `mgenes` - the matron's 48 genes (as an array of integers)
and `sgenes` - the sire's 48 genes (as an array of integers)
and returns `babygenes` - the new baby's 48 genes (as an array of integer):

``` ruby
def mixgenes( mgenes, sgenes )  ## returns babygenes
  babygenes = []
  # ...
  babygenes
end
```


Start from scratch or, yes, use any library / gem you can find.

To qualify for solving the code challenge / puzzle you must pass the test.

Note: To get always the same rand(om) numbers for testing ,
the RubyQuizTest sets a "deterministic" seed for the `rand()`
method, that is, `srand( 123 )`. Now if you call
`rand() #=> 0.6964691855978616`,
`rand() #=> 0.28613933495037946`,
`rand() #=> 0.2268514535642031`
you always get the same rand(om) numbers.



``` ruby
require 'minitest/autorun'

class RubyQuizTest < MiniTest::Test

  def test_mixgenes
    mgenes     = [12, 11, 12, 14, 15, 8, 9, 9, 2, 3, 1, 1, 19, 5, 3, 7, 16, 4, 6, 0, 9, 13, 13, 9, 19, 4, 2, 4, 0, 0, 12, 3, 23, 8, 3, 8, 6, 14, 3, 9, 19, 7, 6, 4, 9, 11, 12, 12]
    sgenes     = [9, 9, 11, 14, 23, 15, 8, 14, 3, 7, 6, 5, 3, 19, 6, 6, 4, 6, 3, 5, 6, 6, 14, 8, 2, 4, 7, 2, 0, 0, 12, 0, 15, 15, 8, 10, 6, 14, 14, 6, 5, 4, 4, 5, 20, 9, 8, 11]

    babygenes1 = [9, 9, 11, 14, 23, 8, 9, 14, 3, 3, 5, 1, 3, 19, 3, 7, 16, 4, 6, 5, 9, 6, 14, 8, 19, 4, 2, 4, 0, 0, 12, 3, 23, 15, 8, 10, 6, 14, 3, 9, 19, 5, 6, 5, 20, 9, 11, 8]
    babygenes2 = [12, 9, 11, 11, 15, 23, 9, 9, 5, 2, 3, 6, 3, 19, 5, 6, 4, 4, 3, 5, 9, 6, 13, 9, 19, 4, 7, 4, 0, 0, 12, 12, 15, 3, 8, 10, 6, 3, 14, 9, 19, 5, 5, 4, 9, 9, 11, 8]
    babygenes3 = [12, 12, 14, 11, 15, 23, 8, 14, 3, 1, 3, 1, 19, 3, 7, 6, 16, 5, 6, 3, 6, 6, 13, 9, 19, 4, 2, 4, 0, 0, 0, 12, 23, 3, 8, 8, 6, 6, 14, 14, 4, 19, 6, 7, 9, 12, 9, 11]

    srand( 123 )
    assert_equal babygenes1, mixgenes( mgenes, sgenes )
    assert_equal babygenes2, mixgenes( mgenes, sgenes )
    assert_equal babygenes3, mixgenes( mgenes, sgenes )
  end

end # class RubyQuizTest
```


Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy data wrangling and genome genetics bits & bytes slicing with Ruby.
