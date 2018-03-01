class ReportController < ApplicationController
  def index
    query = "sum(char_length) as char_length, sum(word_length) as word_length, count(nickname) as tweet_id, string_agg(content, ' ') as content"
    if params[:start_date] && params[:end_date]
      @start_date = Date.parse(params[:start_date])
      @end_date = Date.parse(params[:end_date])
      @all = Tweet.where(:created_at => @start_date.beginning_of_day..@end_date.end_of_day)
      @by_user = @all.select("nickname, #{query}").group(:nickname)
      @by_city = @all.select("city, #{query}").group(:city)
      @by_country = @all.select("country, #{query}").group(:country)
      @by_data = @all.select("DATE(created_at) as created_at, #{query}").group("DATE(created_at)")
    else
      @by_user = Tweet.select("nickname, #{query}").group(:nickname)
      @by_city = Tweet.select("city, #{query}").group(:city)
      @by_country = Tweet.select("country, #{query}").group(:country)
      @by_data = Tweet.select("DATE(created_at) as created_at, #{query}").group("DATE(created_at)")
    end
  end
end
