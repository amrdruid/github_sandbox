module Sandbox
	def favorite_language(username)
		user = Octokit.user username
		data = {}
		begin
			repos = user.rels[:repos].get.data
			repos.each do |repo|
				if data[repo.language].nil?
					data[repo.language] = 1
				else
					data[repo.language] += 1
				end
			end

    data = data.sort_by {|k,v| v}.reverse
    unless data.first.nil?
				key, value = data.first
				return "#{user.name} can highly be master in #{key} as he used it in #{value} repos"
			else
				return "#{user.name} has no repos"
			end
		rescue => error
			puts "Failed, username is incorrect"
		end
	end
end
