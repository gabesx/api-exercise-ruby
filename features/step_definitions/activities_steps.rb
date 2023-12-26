# frozen_string_literal: true

require 'httparty'
require 'jsonpath'

When(/^client send a GET request to "([^"]*)"$/) do |path|
  path_with_id = path.gsub('{id}', instance_variable_get('@id').to_s)
  @response = HTTParty.get("https://fakerestapi.azurewebsites.net#{path_with_id}")
end

Then(/^response status should be "([^"]*)"$/) do |expected_status|
  expected_status_code = expected_status.to_i
  expect(@response.code).to eq(expected_status_code)
end

When(/^client collects "([^"]+)" as "([^"]+)"$/) do |json_path, var_name|
  raise 'No response returned!' if @response.nil? || @response.body.nil? || @response.body.empty?

  value = JsonPath.on(@response.parsed_response, json_path)
  raise "No value found for JSON path #{json_path}" if value.empty?

  instance_variable_set("@#{var_name}", value.first.to_s)
end

Then(/^show me the response$/) do
  puts @response
end

And(/^the response should contain a list of activities$/) do
  expect(@response.parsed_response).to be_an_instance_of(Array)
end

