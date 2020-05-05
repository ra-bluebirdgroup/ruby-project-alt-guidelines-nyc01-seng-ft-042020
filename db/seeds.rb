require 'pry'
require 'rest-client'
require 'json'

response = RestClient.get("https://covidtracking.com/api/v1/states/current.json")
data = JSON.parse(response)
binding.pry

#create an instance of state
data.each do |state_hash|
  State.create(name: state_hash["state"], dataQualityGrade: state_hash["dataQualityGrade"], positive: state_hash["positive"], negative: state_hash["negative"], recovered: state_hash["recovered"], lastUpdateEt: state_hash["lastUpdateEt"], death: state_hash["death"], totalTestResults: state_hash["totalTestResults"])
end

binding.pry
