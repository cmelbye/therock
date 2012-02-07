redis_config = YAML.load(File.open(Rails.root + 'config/redis.yml'))[Rails.env]

if redis_config
	REDIS = Redis.new(:host => redis_config['host'], :port => redis_config['port'], :password => redis_config['password'])
end
