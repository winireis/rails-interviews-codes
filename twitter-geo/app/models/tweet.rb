class Tweet < ActiveRecord::Base
  validates :tweet_id, uniqueness: true

  def transform_load(tweet, city, country)
    self.tweet_id = tweet.id
    self.nickname = tweet.user.screen_name
    self.content = tweet.text
    self.char_length = tweet.text.length
    self.word_length = tweet.text.split.size
    self.city = city
    self.country = country
    self.created_at = tweet.created_at
  end

  def top3
    top_list  = []
    top_hash = {}
    self.content.downcase.split(" ").each do |word|
      if top_hash.has_key?(word)
        top_hash[word] += 1
      else
        top_hash[word] = 1
      end
    end
    3.times do
      word, count = top_hash.each_pair.max
      top_list.push(word)
      top_hash.delete(word)
    end
    return top_list.join(" - ")
  end
end
