module RegexpM17N
  def self.non_empty?(str)
    unless str.encoding.dummy?
      return Regexp.new('^.+$'.encode(str.encoding),Regexp::FIXEDENCODING) =~ str
    end
    ''.encode(str.encoding) != str
  end
end
