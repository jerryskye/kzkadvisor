# Default url mappings are:
# 
# * a controller called Main is mapped on the root of the site: /
# * a controller called Something is mapped on: /something
# 
# If you want to override this, add a line like this inside the class:
#
#  map '/otherurl'
#
# this will force the controller to be mounted on: /otherurl.
class MainController < Controller
  # the index action is called automatically when no other action is specified
  def index
    @title = 'Welcome to Ramaze!'
    @test = Test.find(id: 1)
  end

  # the string returned at the end of the function is used as the html body
  # if there is no template for the action. if there is a template, the string
  # is silently ignored
  def notemplate
    @title = 'Welcome to Ramaze!'
    
    return 'There is no \'notemplate.xhtml\' associated with this action.'
  end

  def autocomplete
    conn = Faraday.new(url: 'https://rj.kzkgop.com.pl') do |faraday|
      faraday.request :url_encoded
      faraday.response :json, :content_type => 'application/json'
      faraday.adapter Faraday.default_adapter
    end
    response = conn.get('/api/v1/geo_location/', {query: request.params['term']})
    body = response.body['results'].map {|hsh| {label: hsh['name'], value: hsh['name'], coords: hsh['coordinates']}} unless response.body['results'].nil?
    respond(JSON.dump(body), response.status, {'Content-Type' => 'application/json'})
  end

  def get_lines
    time_now = Time.now + 60
    response = Faraday.post('https://rj.kzkgop.com.pl/plan/', {
      "csrfmiddlewaretoken" => "grBi3YxxXMGsE6iuwAPvLvA8bMHTQo4FjhBWye5jrbp06WIsZvWooqnZHHwh5zc7",
      "min_transfer_time" => "180",
      "time_type_id" => "depart",
      "travel_by_id" => "all",
      "trip_date" => time_now.strftime('%d.%m.%Y'),
      "trip_time" => time_now.strftime('%H:%M'),
    }.merge(request.params))
    @lines = Nokogiri::HTML(response.body).css('td span a')
    @lines.each {|line| line['href'] = line['href'].prepend 'https://rj.kzkgop.com.pl'}
  end
end
