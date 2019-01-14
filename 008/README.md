# Ruby Quiz - Challenge #8 - Base32 Alphabet - Convert the Super "Sekretoooo" 256-Bit CryptoKitties Genome to Kai Notation - Annipurrsary!


Annipurrsary! Let's celebrate one year of CryptoKitties -
yes, more than one million cute little cartoon cats on the blockchain.

Let's convert the super "sekretoooo" kitty genome - that is, a 256-bit integer number
where every 5-bit block is a gene - into the base32 (2^5=32) kai notation.


Q: What's base32 kai notation?

Kai notation (named to honor [Kai Turner](https://medium.com/@kaigani/the-cryptokitties-genome-project-on-dominance-inheritance-and-mutation-b73059dcd0a4) who deciphered the kitties genome)
is a base58 variant / subset for decoding the 256-bit integer into 5-bit blocks.
Each 5-bit block is a gene with 32 possible traits.
The 240-bit genome breaks down into 12 groups of 4 (x 5-bit) genes
(that is, 12 x 4 x 5-bit = 240 bits) with the remaining leading 16 bits "unused" and zeroed-out (e.g. `0x0000`).
Example:

|Kai    |Binary |Num|Kai    |Binary |Num|Kai    |Binary |Num|Kai    |Binary |Num|
|-------|-------|---|-------|-------|---|-------|-------|---|-------|-------|---|
| **1** | 00000 | 0 | **9** | 01000 | 8 | **h** | 10000 |16 | **q** | 11000 |24 |
| **2** | 00001 | 1 | **a** | 01001 | 9 | **i** | 10001 |17 | **r** | 11001 |25 |
| **3** | 00010 | 2 | **b** | 01010 | 10 | **j** | 10010 |18 | **s** | 11010 |26 |
| **4** | 00011 | 3 | **c** | 01011 | 11 | **k** | 10011 |19 | **t** | 11011 |27 |
| **5** | 00100 | 4 | **d** | 01100 | 12 | **m** | 10100 |20 | **u** | 11100 |28 |
| **6** | 00101 | 5 | **e** | 01101 | 13 | **n** | 10101 |21 | **v** | 11101 |29 |
| **7** | 00110 | 6 | **f** | 01110 | 14 | **o** | 10110 |22 | **w** | 11110 |30 |
| **8** | 00111 | 7 | **g** | 01111 | 15 | **p** | 10111 |23 | **x** | 11111 |31 |

Note: The digit-0 and the letter-l are NOT used in kai.

> Base58 is a group of binary-to-text encoding schemes used to represent large integers as alphanumeric text.
> It is similar to Base64 but has been modified to avoid both non-alphanumeric characters
> and letters which might look ambiguous when printed [e.g. 1 and l, 0 and o].
> It is therefore designed for human users who manually enter the data,
> copying from some visual source, but also allows easy copy
> and paste because a double-click will usually select the whole string.
>
> [-- Base58 @ Wikipedia](https://en.wikipedia.org/wiki/Base58)


Let's get coding, for an example:

``` ruby

# A 256-bit super "sekretoooo" integer genome

# hexadecimal (base 16)
genome = 0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce
# decimal (base 10)
genome = 512955438081049600613224346938352058409509756310147795204209859701881294
# binary (base 2)
genome = 0b010010100101001010010011000111001110010000001000010111000001010010111101110011100000000101001010000000110001100010000100\
           011010100000110010000000100011000110000000101001010010100110001100010100101000110100101000010010100101011011100111001110
```


Let's convert from decimal (base 10) to hexadecimal (base 16 - 2^4) and binary (base 2 that is, 0 and 1):


``` ruby
p genome    # printed as decimal (base 10) by default
# => 512955438081049600613224346938352058409509756310147795204209859701881294

p genome.to_s(16)
# => "4a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce"

p genome.to_s(2)
# => "10010100101001010010011000111001110010000001000010111000001010010111101110011100000000101001010000000110001100010000100\
#     011010100000110010000000100011000110000000101001010010100110001100010100101000110100101000010010100101011011100111001110"
```

And finally:

``` ruby
kai = kai_encode( genome )   ## number to base32 kai notation
p kai
# => "aaaa788522f2agff16617755e979244166677664a9aacfff"
```



The challenge: Code a `kai_encode` method that passes the RubyQuizTest :-).

``` ruby
def kai_encode( num )
  # ...
end
```

For the starter level 1 turn
super "sekretoooo" kitty genome 240-bit integer numbers
into base 32 (2^5) kai notation.

For the bonus level 2 pretty print and format
the base 32 (2^5) kai notation in groups of four e.g.
turn:

``` ruby
"aaaa788522f2agff16617755e979244166677664a9aacfff"
```

into

``` ruby
"aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff"
```


``` ruby
def kai_fmt( kai )
  # ...
end
```


Start from scratch or, yes, use any library / gem you can find.

To qualify for solving the code challenge / puzzle you must pass the test:

``` ruby
require 'minitest/autorun'

class RubyQuizTest < MiniTest::Test

  ################################
  # test data
  def genomes
   [
[0x00005ad2b318e6724ce4b9290146531884721ad18c63298a5308a55ad6b6b58d,
"ccac 7787 fa7f afaa 1646 7755 f9ee 4444 6766 7366 cccc eede"], ## kitty #1
[0x00004ad083188630c264a1280146021884618c818c6331ca728c425ad6b5b18e,
"ac99 7757 7427 a9a9 1641 5755 d779 4444 7868 6433 cccc cddf"], ## kitty #100
[0x00004a52931ce4085c14bdce014a0318846a0c808c60294a6314a34a1295b9ce,
"aaaa 7885 22f2 agff 1661 7755 e979 2441 6667 7664 a9aa cfff"], ## kitty #1001
[0x000042d28390864842e7b9c900c6321086438c6098ca298c728867425cf6b1ac,
"9ca9 8557 a22f gffa 1444 5557 9f77 277b 6778 6348 9afg eded"], ## kitty #1111
[0x00007918c42de87a96b49c8712d687bc6310cc223d6c081ee6a1ac50d8c3184f,
"g5dd 9cg9 gbcc a858 3cc9 gg44 3473 5gcd 21gf e9ed b4dd 773g"], ## kitty #1000001 
   ]
  end

  #############
  # tests
  def test_kai_encode
    genomes.each do |pair|
      num       = pair[0]
      exp_value = pair[1].gsub(' ','')   # note: remove spaces

      assert_equal exp_value, kai_encode( num )
    end
  end # method test_kai_encode

  def test_kai_fmt
    genomes.each do |pair|
      kai       = pair[1].gsub(' ','') # remove spaces
      exp_value = pair[1]

      assert_equal exp_value, kai_fmt( kai )
    end
  end # method test_kai_fmt

end # class RubyQuizTest
```


Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).

Happy data wrangling and genome genetics bits & bytes slicing with Ruby.



PS: Using a genes / traits chart
you can now decipher the genome:

Fur (0-3) • Pattern (4-7) • Eye Color (8-11) • Eye Shape (12-15) • Base Color (16-19) • Highlight Color (20-23) • Accent Color (24-27) • Wild (28-31) • Mouth (32-35) • Environment (36-39) • Secret Y Gene (40-43) • Purrstige (44-47)

## Fur (FU) - Genes 0-3

|Kai|Code|Cattribute   |Kai|Code|Cattribute  |
|--:|---:|-------------|--:|---:|------------|
| 1 | FU00 | **[savannah](https://www.cryptokitties.co/search?include=sale,sire,other&search=savannah)**  | h | FU16 | **[norwegianforest](https://www.cryptokitties.co/search?include=sale,sire,other&search=norwegianforest)** I |
| 2 | FU01 | **[selkirk](https://www.cryptokitties.co/search?include=sale,sire,other&search=selkirk)**  | i | FU17 | **[mekong](https://www.cryptokitties.co/search?include=sale,sire,other&search=mekong)** I |
| 3 | FU02 | **[chantilly](https://www.cryptokitties.co/search?include=sale,sire,other&search=chantilly)**  | j | FU18 | **[highlander](https://www.cryptokitties.co/search?include=sale,sire,other&search=highlander)** I |
| 4 | FU03 | **[birman](https://www.cryptokitties.co/search?include=sale,sire,other&search=birman)**  | k | FU19 | **[balinese](https://www.cryptokitties.co/search?include=sale,sire,other&search=balinese)** I |
| 5 | FU04 | **[koladiviya](https://www.cryptokitties.co/search?include=sale,sire,other&search=koladiviya)**  | m | FU20 | **[lynx](https://www.cryptokitties.co/search?include=sale,sire,other&search=lynx)** I |
| 6 | FU05 | **[bobtail](https://www.cryptokitties.co/search?include=sale,sire,other&search=bobtail)**  | n | FU21 | **[mainecoon](https://www.cryptokitties.co/search?include=sale,sire,other&search=mainecoon)** I |
| 7 | FU06 | **[manul](https://www.cryptokitties.co/search?include=sale,sire,other&search=manul)**  | o | FU22 | **[laperm](https://www.cryptokitties.co/search?include=sale,sire,other&search=laperm)** I |
| 8 | FU07 | **[pixiebob](https://www.cryptokitties.co/search?include=sale,sire,other&search=pixiebob)**  | p | FU23 | **[persian](https://www.cryptokitties.co/search?include=sale,sire,other&search=persian)** I |
| 9 | FU08 | **[siberian](https://www.cryptokitties.co/search?include=sale,sire,other&search=siberian)**  | q | FU24 | **[fox](https://www.cryptokitties.co/search?include=sale,sire,other&search=fox)** II |
| a | FU09 | **[cymric](https://www.cryptokitties.co/search?include=sale,sire,other&search=cymric)**  | r | FU25 | **[kurilian](https://www.cryptokitties.co/search?include=sale,sire,other&search=kurilian)** II |
| b | FU10 | **[chartreux](https://www.cryptokitties.co/search?include=sale,sire,other&search=chartreux)**  | s | FU26 | **[toyger](https://www.cryptokitties.co/search?include=sale,sire,other&search=toyger)** II |
| c | FU11 | **[himalayan](https://www.cryptokitties.co/search?include=sale,sire,other&search=himalayan)**  | t | FU27 | **[manx](https://www.cryptokitties.co/search?include=sale,sire,other&search=manx)** II |
| d | FU12 | **[munchkin](https://www.cryptokitties.co/search?include=sale,sire,other&search=munchkin)**  | u | FU28 | **[lykoi](https://www.cryptokitties.co/search?include=sale,sire,other&search=lykoi)** III |
| e | FU13 | **[sphynx](https://www.cryptokitties.co/search?include=sale,sire,other&search=sphynx)**  | v | FU29 | **[burmilla](https://www.cryptokitties.co/search?include=sale,sire,other&search=burmilla)** III |
| f | FU14 | **[ragamuffin](https://www.cryptokitties.co/search?include=sale,sire,other&search=ragamuffin)**  | w | FU30 | **[liger](https://www.cryptokitties.co/search?include=sale,sire,other&search=liger)** IIII |
| g | FU15 | **[ragdoll](https://www.cryptokitties.co/search?include=sale,sire,other&search=ragdoll)**  | x | FU31 | ? |


## Pattern (PA) - Genes 4-7

|Kai|Code|Cattribute   |Kai|Code|Cattribute  |
|--:|---:|-------------|--:|---:|------------|
| 1 | PA00 | **[vigilante](https://www.cryptokitties.co/search?include=sale,sire,other&search=vigilante)**  | h | PA16 | **[splat](https://www.cryptokitties.co/search?include=sale,sire,other&search=splat)** I |
| 2 | PA01 | **[tiger](https://www.cryptokitties.co/search?include=sale,sire,other&search=tiger)**  | i | PA17 | **[thunderstruck](https://www.cryptokitties.co/search?include=sale,sire,other&search=thunderstruck)** I |
| 3 | PA02 | **[rascal](https://www.cryptokitties.co/search?include=sale,sire,other&search=rascal)**  | j | PA18 | **[dippedcone](https://www.cryptokitties.co/search?include=sale,sire,other&search=dippedcone)** I |
| 4 | PA03 | **[ganado](https://www.cryptokitties.co/search?include=sale,sire,other&search=ganado)**  | k | PA19 | **[highsociety](https://www.cryptokitties.co/search?include=sale,sire,other&search=highsociety)** I |
| 5 | PA04 | **[leopard](https://www.cryptokitties.co/search?include=sale,sire,other&search=leopard)**  | m | PA20 | **[tigerpunk](https://www.cryptokitties.co/search?include=sale,sire,other&search=tigerpunk)** I |
| 6 | PA05 | **[camo](https://www.cryptokitties.co/search?include=sale,sire,other&search=camo)**  | n | PA21 | **[henna](https://www.cryptokitties.co/search?include=sale,sire,other&search=henna)** I |
| 7 | PA06 | **[rorschach](https://www.cryptokitties.co/search?include=sale,sire,other&search=rorschach)**  | o | PA22 | **[arcreactor](https://www.cryptokitties.co/search?include=sale,sire,other&search=arcreactor)** I |
| 8 | PA07 | **[spangled](https://www.cryptokitties.co/search?include=sale,sire,other&search=spangled)**  | p | PA23 | **[totesbasic](https://www.cryptokitties.co/search?include=sale,sire,other&search=totesbasic)** I |
| 9 | PA08 | **[calicool](https://www.cryptokitties.co/search?include=sale,sire,other&search=calicool)**  | q | PA24 | **[scorpius](https://www.cryptokitties.co/search?include=sale,sire,other&search=scorpius)** II |
| a | PA09 | **[luckystripe](https://www.cryptokitties.co/search?include=sale,sire,other&search=luckystripe)**  | r | PA25 | **[razzledazzle](https://www.cryptokitties.co/search?include=sale,sire,other&search=razzledazzle)** II |
| b | PA10 | **[amur](https://www.cryptokitties.co/search?include=sale,sire,other&search=amur)**  | s | PA26 | **[hotrod](https://www.cryptokitties.co/search?include=sale,sire,other&search=hotrod)** II |
| c | PA11 | **[jaguar](https://www.cryptokitties.co/search?include=sale,sire,other&search=jaguar)**  | t | PA27 | **[allyouneed](https://www.cryptokitties.co/search?include=sale,sire,other&search=allyouneed)** II |
| d | PA12 | **[spock](https://www.cryptokitties.co/search?include=sale,sire,other&search=spock)**  | u | PA28 | **[avatar](https://www.cryptokitties.co/search?include=sale,sire,other&search=avatar)** III |
| e | PA13 | **[mittens](https://www.cryptokitties.co/search?include=sale,sire,other&search=mittens)**  | v | PA29 | **[gyre](https://www.cryptokitties.co/search?include=sale,sire,other&search=gyre)** III |
| f | PA14 | **[totesbasic](https://www.cryptokitties.co/search?include=sale,sire,other&search=totesbasic)**  | w | PA30 | **[moonrise](https://www.cryptokitties.co/search?include=sale,sire,other&search=moonrise)** IIII |
| g | PA15 | **[totesbasic](https://www.cryptokitties.co/search?include=sale,sire,other&search=totesbasic)**  | x | PA31 | ? |


## Eye Color (EC) - Genes 8-11

|Kai|Code|Cattribute   |Kai|Code|Cattribute  |
|--:|---:|-------------|--:|---:|------------|
| 1 | EC00 | **[thundergrey](https://www.cryptokitties.co/search?include=sale,sire,other&search=thundergrey)**  | h | EC16 | **[pumpkin](https://www.cryptokitties.co/search?include=sale,sire,other&search=pumpkin)** I |
| 2 | EC01 | **[gold](https://www.cryptokitties.co/search?include=sale,sire,other&search=gold)**  | i | EC17 | **[limegreen](https://www.cryptokitties.co/search?include=sale,sire,other&search=limegreen)** I |
| 3 | EC02 | **[topaz](https://www.cryptokitties.co/search?include=sale,sire,other&search=topaz)**  | j | EC18 | **[bridesmaid](https://www.cryptokitties.co/search?include=sale,sire,other&search=bridesmaid)** I |
| 4 | EC03 | **[mintgreen](https://www.cryptokitties.co/search?include=sale,sire,other&search=mintgreen)**  | k | EC19 | **[bubblegum](https://www.cryptokitties.co/search?include=sale,sire,other&search=bubblegum)** I |
| 5 | EC04 | **[isotope](https://www.cryptokitties.co/search?include=sale,sire,other&search=isotope)**  | m | EC20 | **[twilightsparkle](https://www.cryptokitties.co/search?include=sale,sire,other&search=twilightsparkle)** I |
| 6 | EC05 | **[sizzurp](https://www.cryptokitties.co/search?include=sale,sire,other&search=sizzurp)**  | n | EC21 | **[palejade](https://www.cryptokitties.co/search?include=sale,sire,other&search=palejade)** I |
| 7 | EC06 | **[chestnut](https://www.cryptokitties.co/search?include=sale,sire,other&search=chestnut)**  | o | EC22 | **[pinefresh](https://www.cryptokitties.co/search?include=sale,sire,other&search=pinefresh)** I |
| 8 | EC07 | **[strawberry](https://www.cryptokitties.co/search?include=sale,sire,other&search=strawberry)**  | p | EC23 | **[eclipse](https://www.cryptokitties.co/search?include=sale,sire,other&search=eclipse)** I |
| 9 | EC08 | **[sapphire](https://www.cryptokitties.co/search?include=sale,sire,other&search=sapphire)**  | q | EC24 | **[babypuke](https://www.cryptokitties.co/search?include=sale,sire,other&search=babypuke)** II |
| a | EC09 | **[forgetmenot](https://www.cryptokitties.co/search?include=sale,sire,other&search=forgetmenot)**  | r | EC25 | **[downbythebay](https://www.cryptokitties.co/search?include=sale,sire,other&search=downbythebay)** II |
| b | EC10 | **[dahlia](https://www.cryptokitties.co/search?include=sale,sire,other&search=dahlia)**  | s | EC26 | **[autumnmoon](https://www.cryptokitties.co/search?include=sale,sire,other&search=autumnmoon)** II |
| c | EC11 | **[coralsunrise](https://www.cryptokitties.co/search?include=sale,sire,other&search=coralsunrise)**  | t | EC27 | **[oasis](https://www.cryptokitties.co/search?include=sale,sire,other&search=oasis)** II |
| d | EC12 | **[olive](https://www.cryptokitties.co/search?include=sale,sire,other&search=olive)**  | u | EC28 | **[gemini](https://www.cryptokitties.co/search?include=sale,sire,other&search=gemini)** III |
| e | EC13 | **[doridnudibranch](https://www.cryptokitties.co/search?include=sale,sire,other&search=doridnudibranch)**  | v | EC29 | **[dioscuri](https://www.cryptokitties.co/search?include=sale,sire,other&search=dioscuri)** III |
| f | EC14 | **[parakeet](https://www.cryptokitties.co/search?include=sale,sire,other&search=parakeet)**  | w | EC30 | **[kaleidoscope](https://www.cryptokitties.co/search?include=sale,sire,other&search=kaleidoscope)** IIII |
| g | EC15 | **[cyan](https://www.cryptokitties.co/search?include=sale,sire,other&search=cyan)**  | x | EC31 | ? |


## Eye Shape (ES) - Genes 12-15

|Kai|Code|Cattribute   |Kai|Code|Cattribute  |
|--:|---:|-------------|--:|---:|------------|
| 1 | ES00 | **[swarley](https://www.cryptokitties.co/search?include=sale,sire,other&search=swarley)**  | h | ES16 | **[chameleon](https://www.cryptokitties.co/search?include=sale,sire,other&search=chameleon)** I |
| 2 | ES01 | **[wonky](https://www.cryptokitties.co/search?include=sale,sire,other&search=wonky)**  | i | ES17 | **[alien](https://www.cryptokitties.co/search?include=sale,sire,other&search=alien)** I |
| 3 | ES02 | **[serpent](https://www.cryptokitties.co/search?include=sale,sire,other&search=serpent)**  | j | ES18 | **[fabulous](https://www.cryptokitties.co/search?include=sale,sire,other&search=fabulous)** I |
| 4 | ES03 | **[googly](https://www.cryptokitties.co/search?include=sale,sire,other&search=googly)**  | k | ES19 | **[raisedbrow](https://www.cryptokitties.co/search?include=sale,sire,other&search=raisedbrow)** I |
| 5 | ES04 | **[otaku](https://www.cryptokitties.co/search?include=sale,sire,other&search=otaku)**  | m | ES20 | **[tendertears](https://www.cryptokitties.co/search?include=sale,sire,other&search=tendertears)** I |
| 6 | ES05 | **[simple](https://www.cryptokitties.co/search?include=sale,sire,other&search=simple)**  | n | ES21 | **[hacker](https://www.cryptokitties.co/search?include=sale,sire,other&search=hacker)** I |
| 7 | ES06 | **[crazy](https://www.cryptokitties.co/search?include=sale,sire,other&search=crazy)**  | o | ES22 | **[sass](https://www.cryptokitties.co/search?include=sale,sire,other&search=sass)** I |
| 8 | ES07 | **[thicccbrowz](https://www.cryptokitties.co/search?include=sale,sire,other&search=thicccbrowz)**  | p | ES23 | **[sweetmeloncakes](https://www.cryptokitties.co/search?include=sale,sire,other&search=sweetmeloncakes)** I |
| 9 | ES08 | **[caffeine](https://www.cryptokitties.co/search?include=sale,sire,other&search=caffeine)**  | q | ES24 | **[oceanid](https://www.cryptokitties.co/search?include=sale,sire,other&search=oceanid)** II |
| a | ES09 | **[wowza](https://www.cryptokitties.co/search?include=sale,sire,other&search=wowza)**  | r | ES25 | **[wingtips](https://www.cryptokitties.co/search?include=sale,sire,other&search=wingtips)** II |
| b | ES10 | **[baddate](https://www.cryptokitties.co/search?include=sale,sire,other&search=baddate)**  | s | ES26 | **[firedup](https://www.cryptokitties.co/search?include=sale,sire,other&search=firedup)** II |
| c | ES11 | **[asif](https://www.cryptokitties.co/search?include=sale,sire,other&search=asif)**  | t | ES27 | **[buzzed](https://www.cryptokitties.co/search?include=sale,sire,other&search=buzzed)** II |
| d | ES12 | **[chronic](https://www.cryptokitties.co/search?include=sale,sire,other&search=chronic)**  | u | ES28 | **[bornwithit](https://www.cryptokitties.co/search?include=sale,sire,other&search=bornwithit)** III |
| e | ES13 | **[slyboots](https://www.cryptokitties.co/search?include=sale,sire,other&search=slyboots)**  | v | ES29 | **[candyshoppe](https://www.cryptokitties.co/search?include=sale,sire,other&search=candyshoppe)** III |
| f | ES14 | **[wiley](https://www.cryptokitties.co/search?include=sale,sire,other&search=wiley)**  | w | ES30 | **[drama](https://www.cryptokitties.co/search?include=sale,sire,other&search=drama)** IIII |
| g | ES15 | **[stunned](https://www.cryptokitties.co/search?include=sale,sire,other&search=stunned)**  | x | ES31 | ? |


## Base Color (BC) - Genes 16-19

|Kai|Code|Cattribute   |Kai|Code|Cattribute  |
|--:|---:|-------------|--:|---:|------------|
| 1 | BC00 | **[shadowgrey](https://www.cryptokitties.co/search?include=sale,sire,other&search=shadowgrey)**  | h | BC16 | **[cloudwhite](https://www.cryptokitties.co/search?include=sale,sire,other&search=cloudwhite)** I |
| 2 | BC01 | **[salmon](https://www.cryptokitties.co/search?include=sale,sire,other&search=salmon)**  | i | BC17 | **[cornflower](https://www.cryptokitties.co/search?include=sale,sire,other&search=cornflower)** I |
| 3 | BC02 | **[meowgarine](https://www.cryptokitties.co/search?include=sale,sire,other&search=meowgarine)**  | j | BC18 | **[oldlace](https://www.cryptokitties.co/search?include=sale,sire,other&search=oldlace)** I |
| 4 | BC03 | **[orangesoda](https://www.cryptokitties.co/search?include=sale,sire,other&search=orangesoda)**  | k | BC19 | **[koala](https://www.cryptokitties.co/search?include=sale,sire,other&search=koala)** I |
| 5 | BC04 | **[cottoncandy](https://www.cryptokitties.co/search?include=sale,sire,other&search=cottoncandy)**  | m | BC20 | **[lavender](https://www.cryptokitties.co/search?include=sale,sire,other&search=lavender)** I |
| 6 | BC05 | **[mauveover](https://www.cryptokitties.co/search?include=sale,sire,other&search=mauveover)**  | n | BC21 | **[glacier](https://www.cryptokitties.co/search?include=sale,sire,other&search=glacier)** I |
| 7 | BC06 | **[aquamarine](https://www.cryptokitties.co/search?include=sale,sire,other&search=aquamarine)**  | o | BC22 | **[redvelvet](https://www.cryptokitties.co/search?include=sale,sire,other&search=redvelvet)** I |
| 8 | BC07 | **[nachocheez](https://www.cryptokitties.co/search?include=sale,sire,other&search=nachocheez)**  | p | BC23 | **[verdigris](https://www.cryptokitties.co/search?include=sale,sire,other&search=verdigris)** I |
| 9 | BC08 | **[harbourfog](https://www.cryptokitties.co/search?include=sale,sire,other&search=harbourfog)**  | q | BC24 | **[icicle](https://www.cryptokitties.co/search?include=sale,sire,other&search=icicle)** II |
| a | BC09 | **[cinderella](https://www.cryptokitties.co/search?include=sale,sire,other&search=cinderella)**  | r | BC25 | **[onyx](https://www.cryptokitties.co/search?include=sale,sire,other&search=onyx)** II |
| b | BC10 | **[greymatter](https://www.cryptokitties.co/search?include=sale,sire,other&search=greymatter)**  | s | BC26 | **[hyacinth](https://www.cryptokitties.co/search?include=sale,sire,other&search=hyacinth)** II |
| c | BC11 | **[tundra](https://www.cryptokitties.co/search?include=sale,sire,other&search=tundra)**  | t | BC27 | **[martian](https://www.cryptokitties.co/search?include=sale,sire,other&search=martian)** II |
| d | BC12 | **[brownies](https://www.cryptokitties.co/search?include=sale,sire,other&search=brownies)**  | u | BC28 | **[hotcocoa](https://www.cryptokitties.co/search?include=sale,sire,other&search=hotcocoa)** III |
| e | BC13 | **[dragonfruit](https://www.cryptokitties.co/search?include=sale,sire,other&search=dragonfruit)**  | v | BC29 | **[shamrock](https://www.cryptokitties.co/search?include=sale,sire,other&search=shamrock)** III |
| f | BC14 | **[hintomint](https://www.cryptokitties.co/search?include=sale,sire,other&search=hintomint)**  | w | BC30 | **[firstblush](https://www.cryptokitties.co/search?include=sale,sire,other&search=firstblush)** IIII |
| g | BC15 | **[bananacream](https://www.cryptokitties.co/search?include=sale,sire,other&search=bananacream)**  | x | BC31 | ? |


## Highlight Color (HC) - Genes 20-23

|Kai|Code|Cattribute   |Kai|Code|Cattribute  |
|--:|---:|-------------|--:|---:|------------|
| 1 | HC00 | **[cyborg](https://www.cryptokitties.co/search?include=sale,sire,other&search=cyborg)**  | h | HC16 | **[ooze](https://www.cryptokitties.co/search?include=sale,sire,other&search=ooze)** I |
| 2 | HC01 | **[springcrocus](https://www.cryptokitties.co/search?include=sale,sire,other&search=springcrocus)**  | i | HC17 | **[safetyvest](https://www.cryptokitties.co/search?include=sale,sire,other&search=safetyvest)** I |
| 3 | HC02 | **[egyptiankohl](https://www.cryptokitties.co/search?include=sale,sire,other&search=egyptiankohl)**  | j | HC18 | **[turtleback](https://www.cryptokitties.co/search?include=sale,sire,other&search=turtleback)** I |
| 4 | HC03 | **[poisonberry](https://www.cryptokitties.co/search?include=sale,sire,other&search=poisonberry)**  | k | HC19 | **[rosequartz](https://www.cryptokitties.co/search?include=sale,sire,other&search=rosequartz)** I |
| 5 | HC04 | **[lilac](https://www.cryptokitties.co/search?include=sale,sire,other&search=lilac)**  | m | HC20 | **[wolfgrey](https://www.cryptokitties.co/search?include=sale,sire,other&search=wolfgrey)** I |
| 6 | HC05 | **[apricot](https://www.cryptokitties.co/search?include=sale,sire,other&search=apricot)**  | n | HC21 | **[cerulian](https://www.cryptokitties.co/search?include=sale,sire,other&search=cerulian)** I |
| 7 | HC06 | **[royalpurple](https://www.cryptokitties.co/search?include=sale,sire,other&search=royalpurple)**  | o | HC22 | **[skyblue](https://www.cryptokitties.co/search?include=sale,sire,other&search=skyblue)** I |
| 8 | HC07 | **[padparadscha](https://www.cryptokitties.co/search?include=sale,sire,other&search=padparadscha)**  | p | HC23 | **[garnet](https://www.cryptokitties.co/search?include=sale,sire,other&search=garnet)** I |
| 9 | HC08 | **[swampgreen](https://www.cryptokitties.co/search?include=sale,sire,other&search=swampgreen)**  | q | HC24 | **[peppermint](https://www.cryptokitties.co/search?include=sale,sire,other&search=peppermint)** II |
| a | HC09 | **[violet](https://www.cryptokitties.co/search?include=sale,sire,other&search=violet)**  | r | HC25 | **[universe](https://www.cryptokitties.co/search?include=sale,sire,other&search=universe)** II |
| b | HC10 | **[scarlet](https://www.cryptokitties.co/search?include=sale,sire,other&search=scarlet)**  | s | HC26 | **[royalblue](https://www.cryptokitties.co/search?include=sale,sire,other&search=royalblue)** II |
| c | HC11 | **[barkbrown](https://www.cryptokitties.co/search?include=sale,sire,other&search=barkbrown)**  | t | HC27 | **[mertail](https://www.cryptokitties.co/search?include=sale,sire,other&search=mertail)** II |
| d | HC12 | **[coffee](https://www.cryptokitties.co/search?include=sale,sire,other&search=coffee)**  | u | HC28 | **[inflatablepool](https://www.cryptokitties.co/search?include=sale,sire,other&search=inflatablepool)** III |
| e | HC13 | **[lemonade](https://www.cryptokitties.co/search?include=sale,sire,other&search=lemonade)**  | v | HC29 | **[pearl](https://www.cryptokitties.co/search?include=sale,sire,other&search=pearl)** III |
| f | HC14 | **[chocolate](https://www.cryptokitties.co/search?include=sale,sire,other&search=chocolate)**  | w | HC30 | **[prairierose](https://www.cryptokitties.co/search?include=sale,sire,other&search=prairierose)** IIII |
| g | HC15 | **[butterscotch](https://www.cryptokitties.co/search?include=sale,sire,other&search=butterscotch)**  | x | HC31 | ? |


## Accent Color (AC) - Genes 24-27

|Kai|Code|Cattribute   |Kai|Code|Cattribute  |
|--:|---:|-------------|--:|---:|------------|
| 1 | AC00 | **[belleblue](https://www.cryptokitties.co/search?include=sale,sire,other&search=belleblue)**  | h | AC16 | **[daffodil](https://www.cryptokitties.co/search?include=sale,sire,other&search=daffodil)** I |
| 2 | AC01 | **[sandalwood](https://www.cryptokitties.co/search?include=sale,sire,other&search=sandalwood)**  | i | AC17 | **[flamingo](https://www.cryptokitties.co/search?include=sale,sire,other&search=flamingo)** I |
| 3 | AC02 | **[peach](https://www.cryptokitties.co/search?include=sale,sire,other&search=peach)**  | j | AC18 | **[buttercup](https://www.cryptokitties.co/search?include=sale,sire,other&search=buttercup)** I |
| 4 | AC03 | **[icy](https://www.cryptokitties.co/search?include=sale,sire,other&search=icy)**  | k | AC19 | **[bloodred](https://www.cryptokitties.co/search?include=sale,sire,other&search=bloodred)** I |
| 5 | AC04 | **[granitegrey](https://www.cryptokitties.co/search?include=sale,sire,other&search=granitegrey)**  | m | AC20 | **[atlantis](https://www.cryptokitties.co/search?include=sale,sire,other&search=atlantis)** I |
| 6 | AC05 | **[cashewmilk](https://www.cryptokitties.co/search?include=sale,sire,other&search=cashewmilk)**  | n | AC21 | **[summerbonnet](https://www.cryptokitties.co/search?include=sale,sire,other&search=summerbonnet)** I |
| 7 | AC06 | **[kittencream](https://www.cryptokitties.co/search?include=sale,sire,other&search=kittencream)**  | o | AC22 | **[periwinkle](https://www.cryptokitties.co/search?include=sale,sire,other&search=periwinkle)** I |
| 8 | AC07 | **[emeraldgreen](https://www.cryptokitties.co/search?include=sale,sire,other&search=emeraldgreen)**  | p | AC23 | **[patrickstarfish](https://www.cryptokitties.co/search?include=sale,sire,other&search=patrickstarfish)** I |
| 9 | AC08 | **[kalahari](https://www.cryptokitties.co/search?include=sale,sire,other&search=kalahari)**  | q | AC24 | **[seafoam](https://www.cryptokitties.co/search?include=sale,sire,other&search=seafoam)** II |
| a | AC09 | **[shale](https://www.cryptokitties.co/search?include=sale,sire,other&search=shale)**  | r | AC25 | **[cobalt](https://www.cryptokitties.co/search?include=sale,sire,other&search=cobalt)** II |
| b | AC10 | **[purplehaze](https://www.cryptokitties.co/search?include=sale,sire,other&search=purplehaze)**  | s | AC26 | **[mallowflower](https://www.cryptokitties.co/search?include=sale,sire,other&search=mallowflower)** II |
| c | AC11 | **[hanauma](https://www.cryptokitties.co/search?include=sale,sire,other&search=hanauma)**  | t | AC27 | **[mintmacaron](https://www.cryptokitties.co/search?include=sale,sire,other&search=mintmacaron)** II |
| d | AC12 | **[azaleablush](https://www.cryptokitties.co/search?include=sale,sire,other&search=azaleablush)**  | u | AC28 | **[sully](https://www.cryptokitties.co/search?include=sale,sire,other&search=sully)** III |
| e | AC13 | **[missmuffett](https://www.cryptokitties.co/search?include=sale,sire,other&search=missmuffett)**  | v | AC29 | **[fallspice](https://www.cryptokitties.co/search?include=sale,sire,other&search=fallspice)** III |
| f | AC14 | **[morningglory](https://www.cryptokitties.co/search?include=sale,sire,other&search=morningglory)**  | w | AC30 | **[dreamboat](https://www.cryptokitties.co/search?include=sale,sire,other&search=dreamboat)** IIII |
| g | AC15 | **[frosting](https://www.cryptokitties.co/search?include=sale,sire,other&search=frosting)**  | x | AC31 | ? |


## Wild (WE) - Genes 28-31

|Kai|Code|Cattribute   |Kai|Code|Cattribute  |
|--:|---:|-------------|--:|---:|------------|
| 1 | WE00 | ? | h | WE16 | **[littlefoot](https://www.cryptokitties.co/search?include=sale,sire,other&search=littlefoot)** I |
| 2 | WE01 | ? | i | WE17 | **[elk](https://www.cryptokitties.co/search?include=sale,sire,other&search=elk)** I |
| 3 | WE02 | ? | j | WE18 | **[ducky](https://www.cryptokitties.co/search?include=sale,sire,other&search=ducky)** I |
| 4 | WE03 | ? | k | WE19 | **[trioculus](https://www.cryptokitties.co/search?include=sale,sire,other&search=trioculus)** I |
| 5 | WE04 | ? | m | WE20 | **[daemonwings](https://www.cryptokitties.co/search?include=sale,sire,other&search=daemonwings)** I |
| 6 | WE05 | ? | n | WE21 | **[featherbrain](https://www.cryptokitties.co/search?include=sale,sire,other&search=featherbrain)** I |
| 7 | WE06 | ? | o | WE22 | **[flapflap](https://www.cryptokitties.co/search?include=sale,sire,other&search=flapflap)** I |
| 8 | WE07 | ? | p | WE23 | **[daemonhorns](https://www.cryptokitties.co/search?include=sale,sire,other&search=daemonhorns)** I |
| 9 | WE08 | ? | q | WE24 | **[dragontail](https://www.cryptokitties.co/search?include=sale,sire,other&search=dragontail)** II |
| a | WE09 | ? | r | WE25 | **[aflutter](https://www.cryptokitties.co/search?include=sale,sire,other&search=aflutter)** II |
| b | WE10 | ? | s | WE26 | **[foghornpawhorn](https://www.cryptokitties.co/search?include=sale,sire,other&search=foghornpawhorn)** II |
| c | WE11 | ? | t | WE27 | **[unicorn](https://www.cryptokitties.co/search?include=sale,sire,other&search=unicorn)** II |
| d | WE12 | ? | u | WE28 | **[dragonwings](https://www.cryptokitties.co/search?include=sale,sire,other&search=dragonwings)** III |
| e | WE13 | ? | v | WE29 | **[alicorn](https://www.cryptokitties.co/search?include=sale,sire,other&search=alicorn)** III |
| f | WE14 | ? | w | WE30 | **[wyrm](https://www.cryptokitties.co/search?include=sale,sire,other&search=wyrm)** IIII |
| g | WE15 | ? | x | WE31 | ? |


## Mouth (MO) - Genes 32-35

|Kai|Code|Cattribute   |Kai|Code|Cattribute  |
|--:|---:|-------------|--:|---:|------------|
| 1 | MO00 | **[whixtensions](https://www.cryptokitties.co/search?include=sale,sire,other&search=whixtensions)**  | h | MO16 | **[cheeky](https://www.cryptokitties.co/search?include=sale,sire,other&search=cheeky)** I |
| 2 | MO01 | **[wasntme](https://www.cryptokitties.co/search?include=sale,sire,other&search=wasntme)**  | i | MO17 | **[starstruck](https://www.cryptokitties.co/search?include=sale,sire,other&search=starstruck)** I |
| 3 | MO02 | **[wuvme](https://www.cryptokitties.co/search?include=sale,sire,other&search=wuvme)**  | j | MO18 | **[samwise](https://www.cryptokitties.co/search?include=sale,sire,other&search=samwise)** I |
| 4 | MO03 | **[gerbil](https://www.cryptokitties.co/search?include=sale,sire,other&search=gerbil)**  | k | MO19 | **[ruhroh](https://www.cryptokitties.co/search?include=sale,sire,other&search=ruhroh)** I |
| 5 | MO04 | **[confuzzled](https://www.cryptokitties.co/search?include=sale,sire,other&search=confuzzled)**  | m | MO20 | **[dali](https://www.cryptokitties.co/search?include=sale,sire,other&search=dali)** I |
| 6 | MO05 | **[impish](https://www.cryptokitties.co/search?include=sale,sire,other&search=impish)**  | n | MO21 | **[grimace](https://www.cryptokitties.co/search?include=sale,sire,other&search=grimace)** I |
| 7 | MO06 | **[belch](https://www.cryptokitties.co/search?include=sale,sire,other&search=belch)**  | o | MO22 | **[majestic](https://www.cryptokitties.co/search?include=sale,sire,other&search=majestic)** I |
| 8 | MO07 | **[rollercoaster](https://www.cryptokitties.co/search?include=sale,sire,other&search=rollercoaster)**  | p | MO23 | **[tongue](https://www.cryptokitties.co/search?include=sale,sire,other&search=tongue)** I |
| 9 | MO08 | **[beard](https://www.cryptokitties.co/search?include=sale,sire,other&search=beard)**  | q | MO24 | **[yokel](https://www.cryptokitties.co/search?include=sale,sire,other&search=yokel)** II |
| a | MO09 | **[pouty](https://www.cryptokitties.co/search?include=sale,sire,other&search=pouty)**  | r | MO25 | **[topoftheworld](https://www.cryptokitties.co/search?include=sale,sire,other&search=topoftheworld)** II |
| b | MO10 | **[saycheese](https://www.cryptokitties.co/search?include=sale,sire,other&search=saycheese)**  | s | MO26 | **[neckbeard](https://www.cryptokitties.co/search?include=sale,sire,other&search=neckbeard)** II |
| c | MO11 | **[grim](https://www.cryptokitties.co/search?include=sale,sire,other&search=grim)**  | t | MO27 | **[satiated](https://www.cryptokitties.co/search?include=sale,sire,other&search=satiated)** II |
| d | MO12 | **[fangtastic](https://www.cryptokitties.co/search?include=sale,sire,other&search=fangtastic)**  | u | MO28 | **[walrus](https://www.cryptokitties.co/search?include=sale,sire,other&search=walrus)** III |
| e | MO13 | **[moue](https://www.cryptokitties.co/search?include=sale,sire,other&search=moue)**  | v | MO29 | **[struck](https://www.cryptokitties.co/search?include=sale,sire,other&search=struck)** III |
| f | MO14 | **[happygokitty](https://www.cryptokitties.co/search?include=sale,sire,other&search=happygokitty)**  | w | MO30 | **[delite](https://www.cryptokitties.co/search?include=sale,sire,other&search=delite)** IIII |
| g | MO15 | **[soserious](https://www.cryptokitties.co/search?include=sale,sire,other&search=soserious)**  | x | MO31 | ? |


## Environment (EN) - Genes 36-39

|Kai|Code|Cattribute   |Kai|Code|Cattribute  |
|--:|---:|-------------|--:|---:|------------|
| 1 | EN00 | ? | h | EN16 | **[salty](https://www.cryptokitties.co/search?include=sale,sire,other&search=salty)** I |
| 2 | EN01 | ? | i | EN17 | **[dune](https://www.cryptokitties.co/search?include=sale,sire,other&search=dune)** I |
| 3 | EN02 | ? | j | EN18 | **[juju](https://www.cryptokitties.co/search?include=sale,sire,other&search=juju)** I |
| 4 | EN03 | ? | k | EN19 | **[tinybox](https://www.cryptokitties.co/search?include=sale,sire,other&search=tinybox)** I |
| 5 | EN04 | ? | m | EN20 | **[myparade](https://www.cryptokitties.co/search?include=sale,sire,other&search=myparade)** I |
| 6 | EN05 | ? | n | EN21 | **[finalfrontier](https://www.cryptokitties.co/search?include=sale,sire,other&search=finalfrontier)** I |
| 7 | EN06 | ? | o | EN22 | **[metime](https://www.cryptokitties.co/search?include=sale,sire,other&search=metime)** I |
| 8 | EN07 | ? | p | EN23 | **[drift](https://www.cryptokitties.co/search?include=sale,sire,other&search=drift)** I |
| 9 | EN08 | ? | q | EN24 | **[secretgarden](https://www.cryptokitties.co/search?include=sale,sire,other&search=secretgarden)** II |
| a | EN09 | ? | r | EN25 | **[frozen](https://www.cryptokitties.co/search?include=sale,sire,other&search=frozen)** II |
| b | EN10 | ? | s | EN26 | **[roadtogold](https://www.cryptokitties.co/search?include=sale,sire,other&search=roadtogold)** II |
| c | EN11 | ? | t | EN27 | **[jacked](https://www.cryptokitties.co/search?include=sale,sire,other&search=jacked)** II |
| d | EN12 | ? | u | EN28 | **[floorislava](https://www.cryptokitties.co/search?include=sale,sire,other&search=floorislava)** III |
| e | EN13 | ? | v | EN29 | **[prism](https://www.cryptokitties.co/search?include=sale,sire,other&search=prism)** III |
| f | EN14 | ? | w | EN30 | **[junglebook](https://www.cryptokitties.co/search?include=sale,sire,other&search=junglebook)** IIII |
| g | EN15 | ? | x | EN31 | ? |


## Secret Y Gene (SE) - Genes 40-43

|Kai|Code|Cattribute   |Kai|Code|Cattribute  |
|--:|---:|-------------|--:|---:|------------|
| 1 | SE00 | ? | h | SE16 | ? |
| 2 | SE01 | ? | i | SE17 | ? |
| 3 | SE02 | ? | j | SE18 | ? |
| 4 | SE03 | ? | k | SE19 | ? |
| 5 | SE04 | ? | m | SE20 | ? |
| 6 | SE05 | ? | n | SE21 | ? |
| 7 | SE06 | ? | o | SE22 | ? |
| 8 | SE07 | ? | p | SE23 | ? |
| 9 | SE08 | ? | q | SE24 | ? |
| a | SE09 | ? | r | SE25 | ? |
| b | SE10 | ? | s | SE26 | ? |
| c | SE11 | ? | t | SE27 | ? |
| d | SE12 | ? | u | SE28 | ? |
| e | SE13 | ? | v | SE29 | ? |
| f | SE14 | ? | w | SE30 | ? |
| g | SE15 | ? | x | SE31 | ? |


## Purrstige (PU) - Genes 44-47

|Kai|Code|Cattribute   |Kai|Code|Cattribute  |
|--:|---:|-------------|--:|---:|------------|
| 1 | PU00 | ? | h | PU16 | ? |
| 2 | PU01 | ? | i | PU17 | ? |
| 3 | PU02 | ? | j | PU18 | ? |
| 4 | PU03 | ? | k | PU19 | ? |
| 5 | PU04 | ? | m | PU20 | ? |
| 6 | PU05 | ? | n | PU21 | ? |
| 7 | PU06 | ? | o | PU22 | ? |
| 8 | PU07 | ? | p | PU23 | ? |
| 9 | PU08 | ? | q | PU24 | ? |
| a | PU09 | ? | r | PU25 | ? |
| b | PU10 | ? | s | PU26 | ? |
| c | PU11 | ? | t | PU27 | ? |
| d | PU12 | ? | u | PU28 | ? |
| e | PU13 | ? | v | PU29 | ? |
| f | PU14 | ? | w | PU30 | ? |
| g | PU15 | ? | x | PU31 | ? |
