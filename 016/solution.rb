
## entry by Frank J. Cameron
##   see https://rubytalk.org/t/re-ruby-quiz-challenge-16-build-the-manuscripts-book-manifest-for-documents-in-markdown/75174

## Reprising the tree-based solution from Challenge #6:

module Frank
  require 'tree'

  def build(txt)
    _d(_f(_h(txt))).to_yaml    #tap{|y| puts y}
  end

  def _d(r)
    r.children.map do |c|
      (g = _d(c)).size > 0                      \
      ? {'title' => c.name[1], 'sections' => g} \
      : {'title' => c.name[1]}
    end
  end

  def _f(h, n = Tree::TreeNode.new([0, nil]))
    return n.root unless h[0]

    c = Tree::TreeNode.new(h[0])

    case h[0][0] <=> n.name[0]
    when 1
      n << c
    when 0
      n.parent << c
    else
      n.parent.parent << c
    end

    _f(h[1..-1], c)
  end

  def _h(txt)
    txt
    .lines
    .reject{|line| line =~ /^```/ ... line =~ /^```/ ? true : nil}
    .grep(/^#/)
    .map{|l| l.match(/^(#+)\s+(.*)\s*$/); [$1.length, $2.delete(?")]}
  end
end  # module Frank
