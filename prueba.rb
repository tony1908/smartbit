require 'statsample-timeseries'
require 'linefit'
require 'twilio-ruby'
require 'httparty'
require 'json'
require 'http'
ts = [234.6,234.07,232.5,241.67,243.13,249.08,250,256.26,250.13,250.75,249,243.19,241.06,245.28,240.01,249.75,
	244.93,245,246.77,245.44,263.36,266.36,257.69,257,256.4,251.5,282.14,286.72,281.9,276.92,282.68].to_ts
y = [234.6,234.07,232.5,241.67,243.13,249.08,250,256.26,250.13,250.75,249,243.19,241.06,245.28,240.01,249.75,
	244.93,245,246.77,245.44,263.36,266.36,257.69,257,256.4,251.5,282.14,286.72,281.9,276.92,282.68]	

include Statsample::TimeSeries

account_sid = 'AC4be349f804e4ae042e9fc9d5c4a3ae98'
auth_token = 'd50daebd8632358fd0b52be9fea16f14'

# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token

# alternatively, you can preconfigure the client like so
Twilio.configure do |config|
  config.account_sid = account_sid
  config.auth_token = auth_token
end

# and then you can create a new client without parameters
@client = Twilio::REST::Client.new


lineFit = LineFit.new




x = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]

lineFit.setData(x,y)

intercept, slope = lineFit.coefficients

rSquared = lineFit.rSquared

meanSquaredError = lineFit.meanSqError
durbinWatson = lineFit.durbinWatson
sigma = lineFit.sigma
tStatIntercept, tStatSlope = lineFit.tStatistics
predictedYs = lineFit.predictedYs
residuals = lineFit.residuals
varianceIntercept, varianceSlope = lineFit.varianceOfEstimates

newX = 35
newY = lineFit.forecast(newX)

i =0
j = 0
#generate kalman filter object for ARIMA(2, 0, 1)


while ts.acf[i] > ts.ar[1] || ts.acf[i] < -ts.ar[1] do
	i = i+1
end
while ts.pacf[i] > ts.ar[1] || ts.pacf[i] < -ts.ar[1] do
	j = j+1
end


#puts (ts.acf)
response = HTTP.get('https://smartbit.herokuapp.com/welcome/comprar.json')

json = JSON.parse(response)
nu = json[0]
nu['user_id']
pa = 0

# Get the partial autocorrelation of the series .04
#puts (ts.pacf)
kf = ARIMA.ks(ts, i+3, 1, j+1)
ra = Random.rand()-Random.rand()
esti = 282.68*(0.25+kf.ar[0])+276.92*(0.25+kf.ar[1])+281.8*(0.25+kf.ar[2])+ra*kf.ma[0]

while pa == 0
	json = JSON.parse(response)
	nu = json[0]
	if nu['user_id'] == '1' && esti - newY > 0
		puts('alza')
		@client.messages.create(
		  from: '+18482202575',
		  to: '+52 0445585491123',
		  body: 'Espera un tiempo, la tendecia del bitcoin está a la alza. El precio de mañana se encuentra
		  alreedor de 279.9304391007197'
		  )
		  pa = 1
	else
	puts('baja')
	end
	
end


#if esti - newY > 0
#	puts('alza')
#	@client.messages.create(
#	  from: '+18482202575',
#	  to: '+52 0445585491123',
#	  body: 'Espera un tiempo, la tendecia del bitcoin está a la alza. El precio de mañana se encuentra
#	  alreedor de 279.9304391007197'
#)
#else
#	puts('baja')
#end
puts(esti)


#puts (kf)
#AR Coeffs:
#puts (kf.ar)
#puts (kf.ma)
