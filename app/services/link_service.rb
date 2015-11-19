class LinkService
  attr_reader :client
  def initialize
    @client = Hurley::Client.new
  end

  def fetch_url_data(url)
    resp = client.get(url).body.split("\n")
    ary = []
    resp.each do |line|
      ary << line if line.include?("<title>")
    end
    ary.first
  end

  private

  def parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end
