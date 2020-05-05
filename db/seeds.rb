require 'pry'
require 'rest-client'
require 'json'

response = RestClient.get("https://covidtracking.com/api/v1/states/current.json")
data = JSON.parse(response)



#create an instance of state
data.each do |state_hash|
  State.create(name: state_hash["state"], dataQualityGrade: state_hash["dataQualityGrade"], positive: state_hash["positive"], negative: state_hash["negative"], recovered: state_hash["recovered"], lastUpdateEt: state_hash["lastUpdateEt"], death: state_hash["death"], totalTestResults: state_hash["totalTestResults"])
end

response = RestClient.get("https://covidtracking.com/api/v1/us/current.json")
data = JSON.parse(response)


#create an instance of state
data.each do |usa_hash|
  Usa.create(name: "USA", positive: usa_hash["positive"], negative: usa_hash["negative"], pending: usa_hash["pending"], hospitalizedCurrently: usa_hash["hospitalizedCurrently"], hospitalizedCumulative: usa_hash["hospitalizedCumulative"], inIcuCurrently: usa_hash["inIcuCurrently"], inIcuCumulative: usa_hash["inIcuCumulative"], onVentilatorCurrently: usa_hash["onVentilatorCurrently"], onVentilatorCumulative: usa_hash["onVentilatorCumulative"], recovered: usa_hash["recovered"], death: usa_hash["death"], hospitalized: usa_hash["hospitalized"], totalTestResults: usa_hash["totalTestResults"])
 end
