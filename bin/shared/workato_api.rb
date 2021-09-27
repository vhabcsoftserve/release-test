require 'net/http'
require 'json'

class WorkatoAPI
  HOST = 'https://www.workato.com'.freeze

  def initialize(email, api_key)
    @email = email
    @api_key = api_key
  end

  def folders(parent_id = nil)
    uri = URI("#{HOST}/api/folders")
    uri.query = URI.encode_www_form(parent_id: parent_id) if parent_id

    @response ||= Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri, 'Content-Type': 'application/json',
                                        'x-user-email': @email,
                                        'x-user-token': @api_key)
      http.request(request)
    end

    JSON.parse(@response.body)
  end

  def jobs(recipe_id)
    uri = URI("#{HOST}/api/recipes/#{recipe_id}/jobs")

    @response ||= Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri, 'Content-Type': 'application/json',
                                        'x-user-email': @email,
                                        'x-user-token': @api_key)
      http.request(request)
    end

    JSON.parse(@response.body)
  end

  def toplevel_folder_id
    folders.first['parent_id'].to_s
  end
end
