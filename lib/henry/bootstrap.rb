module Henry
  class Bootstrap

    def initialize(shell = Thor.new)
      @shell = shell
    end

    def perform
      create_project
      setup_deployment
      encrypt_api_key
      add_henry
    end

    def create_project
      return if File.exist?('.travis.yml')
      @shell.say("Your project doesn't seem to have a `.travis.yml` - creating one now", :green)
      version = @shell.ask('What version of Ruby do you want to test against? |2.1.4|')
      system "travis init ruby --rvm #{version.empty? ? '2.1.4' : version}"
    end

    def setup_deployment
      if travis['deploy'].nil?
        @shell.say('Setting up deployment with Rubygems', :green)
        system "travis setup rubygems"
      end
    end

    def encrypt_api_key
      github_api_key = @shell.ask("Please enter your Github oauth token - visit https://github.com/settings/tokens/new?description=Henry%20Token to set one up if you haven't already")
      @shell.say('Encrypting your token and adding it to your .travis.yml', :green)
      `travis encrypt GITHUB_OUATH_TOKEN=#{github_api_key} --add`
    end

    def add_henry
      @shell.say('Adding Henry to your .travis.yml', :green)
      t = travis
      t['after_success'] ||= []
      t['after_success'] << 'gem install henry'
      t['after_success'] << 'henry deploy'
      File.open('.travis.yml', 'w+') do |f|
        f.write(t.to_yaml)
      end
    end

    def travis
      YAML.load_file('.travis.yml')
    end

  end
end
