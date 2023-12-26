def replace_path_parameters(path)
  path.gsub('{id}', instance_variable_get('@id').to_s)
end

def send_request(method, path, body = nil)
  base_url = ENV['BASE_URL'] || 'https://fakerestapi.azurewebsites.net'
  url = "#{base_url}#{path}"

  headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
  options = { headers: headers }

  unless body.nil? || body.strip.empty?
    parsed_body = JSON.parse(body.strip)
    options[:body] = parsed_body.to_json
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
      puts "Response Body: #{@response.body}"
end
