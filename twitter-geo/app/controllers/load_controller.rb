class LoadController < ApplicationController
  def new

  end

  def create
    latitude = params[:latitude]
    longitude = params[:longitude]
    geodata = Geocoder.search("#{latitude},#{longitude}").first
    query = "geocode:#{latitude},#{longitude},1km"
    oldest = "#{1.week.ago.strftime("%Y-%m-%d")}"

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    tweets = client.search(query, result_type: "recent", since:"#{oldest}" )
    tweets.collect do |current_tweet|
      tweet = Tweet.new
      tweet.transform_load(current_tweet, geodata.city, geodata.country)
      tweet.save
    end
    redirect_to :root
  end

end
