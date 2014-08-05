# encoding: utf-8

#


require 'minitest/autorun'
require_relative '../lib/regexp_m17n'

class RegexpTest < MiniTest::Unit::TestCase
  def test_non_empty_string
    Encoding.list.each do |enc|
      begin
        assert(RegexpM17N.non_empty?('.'.encode(enc)),"#{enc} failed the assertion")
      rescue Encoding::ConverterNotFoundError
        enc_name = enc.name
        shell_output = ''
        IO.popen('irb', 'r+') do |pipe|
          pipe.puts("'.'.force_encoding(\'" + enc_name +"\')")
          pipe.close_write
          shell_output = pipe.read
        end
        assert(shell_output.include? '\x2E')
      end
    end
  end

  def test_empty_string
    Encoding.list.each do |enc|
      begin
        refute(RegexpM17N.non_empty?(''.encode(enc)),"#{enc} failed the assertion")
      rescue Encoding::ConverterNotFoundError
        enc_name = enc.name
        shell_output = ''
        IO.popen('irb', 'r+') do |pipe|
          pipe.puts("''.force_encoding(\'" + enc_name +"\')")
          pipe.close_write
          shell_output = pipe.read
        end
        refute(shell_output.include? '\x2E')
      end
    end
  end
end
