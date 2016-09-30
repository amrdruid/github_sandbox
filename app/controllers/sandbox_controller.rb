class SandboxController < ApplicationController
  def login(username, password)
    client = Octokit::Client.new(:login => username, :password => password)
    begin
      user = client.user
			puts "Welcome, #{user.name}"
			user
		rescue => error
      puts "Failed, either username or password are incorrect"
      return
    end
  end

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
			data.sort_by{|_key, value| value}
			unless data.first.nil?
				key, value = data.first
				puts "#{user.name} can highly be #{key} as he used it in #{value} repos"
			else
				puts "#{user.name} has no repos"
			end
		rescue => error
			puts "Failed, username is incorrect"
		end
	end
end
