require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

xpath_symbols = page.xpath('//tr[@class="cmc-table-row"]/td[contains(@class,"symbol")]/div')
xpath_prices = page.xpath('//tr[@class="cmc-table-row"]/td[contains(@class,"price")]/a')

crypto_array_symbols = []
crypto_array_prices = []

xpath_symbols.each{|symbol_div| crypto_array_symbols << symbol_div.text}
xpath_prices.each{|prices_a| crypto_array_prices << prices_a.text}


def hash_definition(array1, array2)
  crypto_hash = [array1, array2].transpose.to_h
end

def appropriate_format(hash)
  crypto_currencies_array = []
  hash.each{|key, value| 
    h = Hash.new
    h[key] = value.delete_prefix('$').to_f
    crypto_currencies_array << h
  }
  return crypto_currencies_array
end

def perform(array1, array2)
  appropriate_format(hash_definition(array1, array2))
end

puts perform(crypto_array_symbols, crypto_array_prices)




#first method to convert two arrays in a Hash
#crypto_currencies_hash = Hash.new
#crypto_currencies_hash[crypto_array_symbols.zip(crypto_array_prices)]

#second method to convert two arrays in a Hash (or other)
#crypto_array_symbols.each_with_index do |symbol, index|
#end





