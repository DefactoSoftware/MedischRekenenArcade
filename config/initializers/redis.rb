if Rails.env.production?
  uri = URI.parse("redis://rediscloud:DSjrYnODoUIu2JUP@pub-redis-16280.eu-west-1-1.2.ec2.garantiadata.com:16280")
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end
