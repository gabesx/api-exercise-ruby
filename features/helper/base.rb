def replace_path_parameters(path)
  path.gsub('{id}', instance_variable_get('@id').to_s)
end

def send_request(method, path, body = nil)
  base_url = ENV['BASE_URL'] || 'https://fakerestapi.azurewebsites.net'
  url = "#{base_url}#{path}"

  options = { headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' } }

  unless body.nil? || body.strip.empty?
    # Ensure the body is a JSON string
    options[:body] = body.strip.to_json
  end

  @response = case method.upcase
              when 'GET'
                HTTParty.get(url, options)
              when 'POST'
                HTTParty.post(url, options)
              when 'PUT'
                HTTParty.put(url, options)
              when 'DELETE'
                HTTParty.delete(url, options)
              else
                raise "Unsupported HTTP method: #{method}"
              end
end

And(/^response header should have "([^"]*)" containing "([^"]*)"$/) do |header_name, expected_value|
  actual_value = @response.headers[header_name.downcase]
  expect(actual_value).to include(expected_value)
end
