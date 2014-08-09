#!/usr/bin/env ruby

class Foo
  def bar
    puts "#{self.class}::bar"
  end

  private
  def bar_private
    puts "#{self.class}::bar_private"
  end

  def florp_private
    puts "#{self.class}::florp_private"
  end

  public
  def bar_public
    puts "#{self.class}::bar_public"
  end

  def florp_public
    puts "#{self.class}::florp_public"
  end
end

class Bar < Foo
  def doit
    bar_private
    bar_public
  end
end


class RubyStock
	require 'net/http'
    def RubyStock::getStocks(*symbols)
        Hash[*(symbols.collect{|symbol|[symbol,Hash[\
        *(Net::HTTP.get('quote.yahoo.com','/d?f=nl1&s='+symbol).chop\
        .split(',').unshift("Name").insert(2,"Price"))]];}.flatten)];
    end
end

puts RubyStock::getStocks("MSFT", "IBM", "GOOG").inspect
