namespace :focus do
	desc "Perform MobWrite migrations"
	task :mobwrite_migrate => :environment do
		puts "-----> MobWrite migrations"
		puts "-----> Migrating documents..."

		documents = Document.all

		documents.each do |document|
			contribs = 0
			REDIS.set(document.body_redis_key, document.read_attribute(:body))

			document.document_contributors.order("id ASC").each do |dc|
				contribs += 1
				unless REDIS.zscore(document.contributors_redis_key, dc.contributor_id)
					REDIS.zadd(document.contributors_redis_key, dc.created_at.to_i, dc.contributor_id)
				end
			end

			puts "       Document #{document.id} body and #{contribs.to_s} contributors migrated"
		end

		puts "-----> All migrations completed successfully."
	end
end