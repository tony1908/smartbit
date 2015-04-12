require 'httparty'
require 'json'
require 'http'


response2 = HTTP.get('https://data.mexbt.com/trades/btcusd?since=600')
arr = []
json = JSON.parse(response)
for i in 0...31
	price = json[i]
	arr[i] = price['price'].to_f
end
puts (arr[0]+arr[31])