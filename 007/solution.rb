

###
# Entry using parslet
#  by  Frank J. Cameron
#    see https://rubytalk.org/t/ruby-quiz-challenge-7-type-inference-convert-strings-to-null-number-not-a-number-nan-date-more/74858/2

module Frank

 require 'parslet'       ## gem 'parslet', '~> 1.8.2'

 Parser = Class.new(Parslet::Parser) do
    rule(:dte) {
                 (
                   match('[0-9]').repeat(4)>>(
                     match('[.]')>>match('[0-9]').repeat(2)
                   ).repeat(2)
                 ).as(:dte)
               }
    rule(:flt) {
                 (
                   match('[0-9]').repeat>>match('\.')>>match('[0-9]').repeat
                 ).as(:flt)
               }
    rule(:int) {
                 match('[0-9]').repeat.as(:int)
               }
    rule(:nan) {
                 (
                   match('N')>>match('a')>>match('N')
                 ).as(:nan)
               }
    rule(:nul) {
                 (
                   match('N')>>match('i')>>match('l') |
                   match('N')>>match('u')>>match('l')>>match('l')
                 ).as(:nul)
               }
    rule(:str) {
                 match('.').repeat.as(:str)
               }
    rule(:foo) { nul | nan | dte | flt | int | str }
    root(:foo)
  end.new

  Transf = Class.new(Parslet::Transform) do
    rule(:dte => simple(:dte)) { Date.strptime(dte, '%Y.%m.%d') }
    rule(:flt => simple(:flt)) { flt.to_f }
    rule(:int => simple(:int)) { int.to_i }
    rule(:nan => simple(:nan)) { Float::NAN }
    rule(:nul => simple(:nan)) { nil }
    rule(:str => simple(:str)) { str.to_s }
  end.new

  def convert(values)
    values.map{ |v|
      Transf.apply( Parser.parse(v) )
    }
  end
end  ## module Frank


###
# Entry using regex
#  by Oleynikov 
#    see https://rubytalk.org/t/re-ruby-quiz-challenge-7-type-inference-convert-strings-to-null-number-not-a-number-nan-date-more/74865

module Oleynikov 

PATTERNS = {
  nan:   /\ANaN\z/,
  null:  /\An[iu]ll?\z/i,
  date:  /\A\d{4}\.\d{2}\.\d{2}\z/,
  float: /\A\d+\.\d+\z/,
  int:   /\A\d+\z/
}

def convert(values)
  values.map do |v|
    case v
    when PATTERNS[:nan]   then Float::NAN
    when PATTERNS[:null]  then nil
    when PATTERNS[:date]  then Date.strptime(v, '%Y.%m.%d')
    when PATTERNS[:float] then v.to_f
    when PATTERNS[:int]   then v.to_i
    else                       v.to_s
    end
  end
end

end  ## module Oleynikov 

