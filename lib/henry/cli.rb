module Henry
  class CLI < Thor
    desc "deploy", "Push tags and changelog to Github"
    def deploy
      Henry::Deploy.new(Dir.pwd).perform
    end

    desc "bootstrap", "set up your .travis.yml for deployment with Henry"
    def bootstrap
      Bootstrap.new(self).perform
    end
  end
end
