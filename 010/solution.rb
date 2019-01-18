####
# Entry by Frank J. Cameron
#   see https://rubytalk.org/t/re-ruby-quiz-challenge-10-breeding-kitties-mix-genes-using-the-sooper-sekret-formula-in-the-genesciene-cryptokitties-blockchain-contract/74904

module Frank
def mixgenes(mgenes, sgenes)
    # can't resist new toys :slight_smile:
    (0..).step(4).take(12).each do |i|
      3.downto(1) do |j|
        mgenes[i+j],mgenes[i+j-1] = mgenes[i+j-1],mgenes[i+j] if rand<0.25
        sgenes[i+j],sgenes[i+j-1] = sgenes[i+j-1],sgenes[i+j] if rand<0.25
      end
    end

    48.times.map do |i|
      mutation = if i%4 == 0
        [mgenes[i], sgenes[i]].sort.then do |tg|
          if tg[1] - tg[0] == 1 and tg[0].even?
            tg[0] / 2 + 16 if rand < (tg[0] > 23 ? 0.125 : 0.25)
          end
        end
      end

      mutation or rand < 0.5 ? mgenes[i] : sgenes[i]
    end
  end
end  ## module Frank


#############
# Test entry
#   by Gerald Bauer

module TestAnswer
def mixgenes( mgenes, sgenes )  ## returns babygenes
  babygenes = []

  # PARENT GENE SWAPPING
  for i in 0.step(11,1) do ## loop from 0 to 11    # for(i = 0; i < 12; i++)
    index = 4 * i                                  #    index = 4 * i
    for j in 3.step(1,-1) do  ## loop from 3 to 1  #   for (j = 3; j > 0; j--)
      if rand() < 0.25                             #     if random() < 0.25:
        mgenes[index+j-1], mgenes[index+j] =       #       swap(mGenes, index+j, index+j-1)
        mgenes[index+j],   mgenes[index+j-1]
      end
      if rand() < 0.25                             #     if random() < 0.25:
        sgenes[index+j-1], sgenes[index+j] =       #        swap(sGenes, index+j, index+j-1)
        sgenes[index+j],   sgenes[index+j-1]
      end
    end
  end

  # BABY GENES
  for i in 0.step(47,1) do ## loop from 0 to 47    #  for (i = 0; i < 48; i++):
    mutation = nil                                 #    mutation = 0
    # CHECK MUTATION
    if i % 4 == 0                                  #    if i % 4 == 0:
      gene1 = mgenes[i]                            #      gene1 = mGenes[i]
      gene2 = sgenes[i]                            #      gene2 = sGenes[i]
      if gene1 > gene2                             #      if gene1 > gene2:
         gene1, gene2 = gene2, gene1               #        gene1, gene2 = gene2, gene1
      end
      if (gene2 - gene1) == 1 && gene1.even?       #     if (gene2 - gene1) == 1 and iseven(gene1):
        probability = 0.25                         #        probability = 0.25
        if gene1 > 23                              #        if gene1 > 23:
          probability /= 2                         #          probability /= 2
        end
        if rand() < probability                    #        if random() < probability:
          mutation = (gene1 / 2) + 16              #          mutation = (gene1 / 2) + 16
        end
      end
    end
    # GIVE BABY GENES
    if mutation                                    #    if mutation:
      babygenes[i] = mutation                      #      babyGenes[i] = mutation
    else                                           #    else:
      if rand() < 0.5                              #      if random() < 0.5:
        babygenes[i] = mgenes[i]                   #        babyGenes[i] = mGenes[i]
      else                                         #      else:
        babygenes[i] = sgenes[i]                   #        babyGenes[i] = sGenes[i]
      end
    end
  end

  babygenes   # return bagygenes
end # mixgenes
end


