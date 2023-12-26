# frozen_string_literal: true

require 'httparty'
require 'jsonpath'

When(/^client sends a (GET|POST|PUT|DELETE) request to "([^"]*)"$/) do |method, path|
  send_request(method, replace_path_parameters(path))
end

When(/^client sends a (GET|POST|PUT|DELETE) request to "([^"]*)" with body:$/) do |method, path, body|
  send_request(method, replace_path_parameters(path), body)
end

Then(/^response status should be "([^"]*)"$/) do |expected_status|
  expected_status_code = expected_status.to_i
  expect(@response.code).to eq(expected_status_code)
end

When(/^client collects "([^"]+)" as "([^"]+)"$/) do |json_path, var_name|
  if @response.body.nil? || @response.body.empty?
    raise 'No response returned or response body is empty!'
  end

  value = JsonPath.on(@response.parsed_response, json_path)
  if value.empty?
    raise "No value found for JSON path #{json_path}"
  end

  instance_variable_set("@#{var_name}", value.first)
end

Then(/^show me the response$/) do
  puts "Response Code: #{@response.code}"
  puts "Response Headers: #{@response.headers}"
  puts "Response Body: #{@response.body}"
end

And(/^the response should contain a list of activities$/) do
  expect(@response.parsed_response).to be_an_instance_of(Array)
end
