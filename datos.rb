require 'httparty'
require 'json'
require 'http'


response = HTTP.get('https://data.mexbt.com/trades/btcusd?since=600')
arr = []
json = JSON.parse(response)
for i in 0...31
	nu = json[i]
	arr[i] = nu['price'].to_f
end
puts (arr[0]+arr[1])