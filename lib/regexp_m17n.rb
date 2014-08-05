module RegexpM17N
  def self.non_empty?(str)
    unless str.encoding.dummy?
      return Regexp.new('^.+$'.encode(str.encoding),Regexp::FIXEDENCODING) =~ str
    end
     converted_string = irb_convert(str.encoding,str)
     Regexp.new('^.+$'.encode(converted_string.encoding),Regexp::FIXEDENCODING) =~ converted_string
  end

private

def self.irb_convert(dum, str)
        shell_output = ''
        IO.popen('irb', 'r+') do |pipe|
         pipe.puts ( str.inspect + ".force_encoding(\'" + dum.name + "\').force_encoding(\'" + Encoding::UTF_8.name + "\')")
          pipe.close_write
          shell_output = pipe.read
        end
       shell_output.split("\n").last
  end
end
