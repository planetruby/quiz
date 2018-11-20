

## 
# An high-speed (with inline c-code/extension) entry by Frank J. Cameron  
#  see https://rubytalk.org/t/ruby-quiz-challenge-5-crypto-mining-find-the-winning-lucky-number-nonce-number-used-once-for-the-proof-of-work-pow-hash-sha-256/74836/2
#
#  more about (ruby) inline @ https://github.com/seattlerb/rubyinline

module Frank
  def compute_nonce(data)
    0.upto(Float::INFINITY) do |nonce|
      break nonce if sha256("#{nonce}#{data}", 2)==0
    end
  end

  require 'inline'

  inline do |builder|
    builder.include '<string.h>'
    builder.include '<openssl/sha.h>'
    builder.c <<-END
      int sha256(char * s, int difficulty) {
        unsigned char * d = SHA256((unsigned char *)s, strlen(s), 0);
        for(int i=0; i<difficulty; i++) if (d[i] != 0) return -1;
        return 0;
      }
    END
  end
end
