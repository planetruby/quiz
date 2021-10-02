Ruby Quiz - Challenge #19 

# ~Punk~ Pixel Art Programming Challenge #1  - Random Circles / Generative Dotty Spotty Modern Art

For background see [**Punk Art Programming Challenge #1 - 10 000 Dotty Spotty "Currency" Punks Inspired by Damin Hirst's "The Currency"**](https://rubytalk.org/t/ruby-pixel-art-punk-art-programming-challenge-1-10-000-dotty-spotty-currency-punks-inspired-by-damin-hirsts-the-currency/75575).



Frank J. Cameron writes:

I played with circles from hashes.
Some example images seeded with the same, but random, hash:

     $ ruby -r./circule.rb -e Circule.demo

1. Given an input hash
2. Slice the hash into 16-bit (possibly overlapping) slices
3. Subslice each slice to define a circle (x, y, r)
4. Color each pixel based on the number of circles it is inside



Code - [`0x0.st/-gAt.rb`](https://0x0.st/-gAt.rb)

``` ruby
require 'uri'
require 'net/http'
require 'chunky_png'
require 'securerandom'

class Circule
  def initialize(
    hash: nil, btc_block: nil,
    bit0: 0, step: 16, bitn: 255,
    canvas: 24, ox: 0, oy: ox
  ) @_hash     = hash.to_i(16) if hash
    @btc_block = btc_block
    @bit0      = bit0
    @step      = step
    @bitn      = bitn
    @canvas    = canvas
    @ox        = ox
    @oy        = oy
  end

  def hash
    @_hash ||=
      if @btc_block
        Net::HTTP
        .get_response(
          URI("https://live.blockcypher.com/btc/block/#{@btc_block}/"))
        .header['location']
        .split('/')[-1]
      else
        SecureRandom.hex(32)
      end
      .to_i(16)
  end

  def slices
    @_slices ||=
      @bit0
      .step(@bitn, @step)
      .map { |n| hash[n, 16] }
  end

  def circles
    @_circles ||=
      slices
      .map { |s| [ s[0, 5], s[5, 5], s[10, 6] ] }
  end

  def image
    @_image ||=
      ChunkyPNG::Image
      .new(@canvas, @canvas)
      .tap do |img|
        @canvas.times do |a|
          @canvas.times do |b|
            img[a, b] = ChunkyPNG::Color.html_color(
              ChunkyPNG::Color::PREDEFINED_COLORS.keys[
                circles
                .select { |x, y, r| (a+@ox-x)**2 + (b+@oy-y)**2 < r**2 }
                .size
              ]
            )
          end
        end
      end
  end

  class <<self
    def demo
      h = SecureRandom.hex(32)
      4.step(32) do |s|
        24.step(96, 24) do |c|
          Circule.new(hash: h, step: s, canvas: c).image.save(
            "/tmp/circ%02x%02x.png" % [s, c]
          )
        end
      end
    end
  end
end

eval DATA.read if __FILE__ == $0

__END__
require 'glimmer-dsl-libui'
include Glimmer
menu('Circule') { quit_menu_item { on_clicked { Kernel.exit } } }

@hash   = SecureRandom.hex(32)
@bit0   = 0
@step   = 16
@bitn   = 255
@canvas = 24
@ox     = 0
@oy     = 0

@update = lambda do
  p [@bit0, @step, @bitn, @canvas, @ox, @oy]
  @image = Circule.new(
    hash:   @hash,
    bit0:   @bit0,
    step:   @step,
    bitn:   @bitn,
    canvas: @canvas,
    ox:     @ox,
    oy:     @oy,
  ).image.tap { |i| i.save('/tmp/circule.png') }
  sleep 0.0078125
end.tap { |p| p.call }

window { |w|
  vertical_box {
    form {
      horizontal_box {
        label('hash')
        entry.tap { |e|
          e.read_only = true
          e.text = @hash
        }
      }
      horizontal_box {
        label('bit0')
        slider(0, 255) {
          on_changed { |s| @bit0 = s.value; @update.call }
        }.value = @bit0
      }
      horizontal_box {
        label('step')
        slider(4, 128) {
          on_changed { |s| @step = s.value; @update.call }
        }.value = @step
      }
      horizontal_box {
        label('bitn')
        slider(0, 255) {
          on_changed { |s| @bitn = s.value; @update.call }
        }.value = @bitn
      }
      horizontal_box {
        label('canvas')
        slider(24, 120) {
          on_changed { |s| @canvas = s.value; @update.call }
        }.value = @canvas
      }
      horizontal_box {
        label('ox')
        slider(-120, 120) {
          on_changed { |s| @ox = s.value; @update.call }
        }.value = @ox
      }
      horizontal_box {
        label('oy')
        slider(-120, 120) {
          on_changed { |s| @oy = s.value; @update.call }
        }.value = @oy
      }
    }

    vertical_box {
    }
  }
}.show
```


Join us. Yes, you can.
Start from scratch or, yes, use any library / gem you can find.

Post your code snippets on the "official" Ruby Quiz Channel,
that is, the [ruby-talk mailing list](https://rubytalk.org).
