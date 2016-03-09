module Henry
  class CLI < Thor
    desc "deploy", "Push tags and changelog to Github"
    def deploy
      Henry::Deploy.new(Dir.pwd).perform
    end
  end
end
