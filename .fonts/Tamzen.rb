#-----------------------------------------------------------------------------
# specification
#-----------------------------------------------------------------------------

BACKPORTS = [
  # backport the given CHARACTER at the given WEIGHT from the given VERSIONS
  # (try them all, one by one, until one of them has the specified character)
  #{character: 'S',  weight: //,       versions: ['v1.6-derived', 'v1.6']},
  {character: 'U',  weight: /Medium/, versions: ['v1.6-derived', 'v1.6']},
  #{character: 'f',  weight: //,       versions: ['v1.6-derived', 'v1.6']},
  {character: 'g',  weight: /Bold/,   versions: ['v1.6-derived', 'v1.6']},
  {character: 'g',  weight: /Medium/, versions: ['v1.6-derived', 'v1.6']},
  {character: 'h',  weight: /Medium/, versions: ['v1.6-derived', 'v1.6']},
  {character: 'm',  weight: /Medium/, versions: ['v1.6-derived', 'v1.6']},
  {character: 'l',  weight: //,       versions: ['v1.6-derived', 'v1.6']},
  {character: 'w',  weight: //,       versions: ['v1.6-derived', 'v1.6']},
  {character: 'y',  weight: //,       versions: ['v1.6-derived', 'v1.6']},
]

#-----------------------------------------------------------------------------
# implementation
#-----------------------------------------------------------------------------

class Font < Struct.new(:file, :props, :chars)
  def initialize file, contents
    head, *body, @tail = contents.split(/(?=\nSTARTCHAR|\nENDFONT)/)
    props = Hash[head.lines.map {|s| s.chomp.split(' ', 2) }.reject(&:empty?)]
    chars = Hash[body.map {|s| [Integer(s[/ENCODING (\d+)/, 1]), s] }]
    super file, props, chars

    # delete empty glyphs except space (32) and non-breaking space (160)
    chars.each do |code, char|
      if char =~ /BITMAP\n(?:00\n)+ENDCHAR/ && code != 32 && code != 160
        chars.delete code
      end
    end
  end

  def to_s
    props['CHARS'] = chars.length
    [
      props.map {|*a| a.join(' ') }.join(?\n), ?\n,
      chars.values,
      @tail, ?\n
    ].join
  end
end

require 'git'
git = Git.open('.')
git.gtree('v1.9').blobs.each do |file, blob|
  if file.end_with? '.bdf'
    font = Font.new(file, blob.contents)

    # backport characters from older versions of the font
    BACKPORTS.each do |backport|
      code = backport[:character].ord
      if font.props['WEIGHT_NAME'] =~ backport[:weight]
        backport[:versions].any? do |version|
          if old_blob = git.gtree(version).blobs[font.file]
            old_font = Font.new(font.file, old_blob.contents)
            if old_char = old_font.chars[code]
              font.chars[code] = old_char
              true
            end
          end
        end or warn "#{$0}: could not backport #{backport} into #{font.file}"
      end
    end

    # output the modified font under a different name
    rename = ['Tamsyn', 'Tamzen']
    File.write font.file.sub(*rename), font.to_s.gsub(*rename)
  end
end
