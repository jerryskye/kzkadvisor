class AdvisorController < Controller
  def index
    @title = "Welcome, #{user.login}!"
  end

  def autocomplete
    response = Mechanize.new.get('https://rj.kzkgop.com.pl/api/v1/geo_location/', {query: request.params['term']})
    body = JSON.parse(response.body)['results'].map {|hsh| {label: hsh['name'], value: hsh['name'], coords: hsh['coordinates']}} unless response.body['results'].nil?
    respond(JSON.dump(body), response.code, {'Content-Type' => 'application/json'})
  end

  def get_lines
    @title = 'Your search results'
    time_now = Time.now + 60
    response = Mechanize.new.post('https://rj.kzkgop.com.pl/plan/', {
      "csrfmiddlewaretoken" => "5sATx5gvsGE7g2mkJhKLSQUGYRLAE2pn1t8i7DKcR1ehxYjxQ5VwwZlPdtmfOMap",
      "min_transfer_time" => "180",
      "time_type_id" => "depart",
      "travel_by_id" => "all",
      "trip_date" => time_now.strftime('%d.%m.%Y'),
      "trip_time" => time_now.strftime('%H:%M'),
    }.merge(request.params))
    @lines = response.css('td span a')
    @lines.each {|line| line['href'] = line['href'].prepend 'https://rj.kzkgop.com.pl'}
  end
end
