module RegexpM17N
  def self.non_empty?(str)
    unless str.encoding.dummy?
      return Regexp.new('^.+$'.encode(str.encoding),Regexp::FIXEDENCODING) =~ str
    end
     converted_string = irb_convert(str.encoding,str)
     Regexp.new('^.+$'.encode(converted_string.encoding),Regexp::FIXEDENCODING) =~ converted_string
  end
