class User
  include HTTParty

  def self.find(username)
    url = 'https://api.github.com/search/users'
    response = HTTParty.get(url, query: { q: username })['items']
    response.map { |user| user['login'] }
  end

  def repos(username)
    url = 'https://api.github.com/users/' + username + '/repos'
    HTTParty.get(url)
  end
end
