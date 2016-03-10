require 'spec_helper'

module Henry
  describe Bootstrap do

    let (:shell) { Thor.new }
    let (:bootstrap) { described_class.new(shell) }

    context 'create_project' do

      context 'when a .travis.yml does not exist' do

        before(:each) do
          allow(File).to receive(:exist?).with('.travis.yml') { false }
          expect(shell).to receive(:say).with("Your project doesn't seem to have a `.travis.yml` - creating one now", :green)
        end

        it 'creates with a specified version' do
          expect(shell).to receive(:ask).with("What version of Ruby do you want to test against? |2.1.4|") { '1.9.2' }
          expect(bootstrap).to receive(:system).with("travis init ruby --rvm 1.9.2")
          bootstrap.create_project
        end

        it 'creates with the default version' do
          expect(shell).to receive(:ask).with("What version of Ruby do you want to test against? |2.1.4|") { '' }
          expect(bootstrap).to receive(:system).with("travis init ruby --rvm 2.1.4")
          bootstrap.create_project
        end

      end

      it 'does nothing when a .travis.yml file does exist' do
        allow(File).to receive(:exist?).with('.travis.yml') { true }
        expect(shell).to_not receive(:say).with("Your project doesn't seem to have a `.travis.yml` - creating one now", :green)
        bootstrap.create_project
      end

    end

    context 'setup_deployment' do

      it 'sets up deployment if it has not already been done' do
        allow(bootstrap).to receive(:travis) { Hash.new }
        expect(shell).to receive(:say).with("Setting up deployment with Rubygems", :green)
        expect(bootstrap).to receive(:system).with("travis setup rubygems")
        bootstrap.setup_deployment
      end

      it 'does not set up deployment if it has already been done' do
        allow(bootstrap).to receive(:travis) { Hash.new('deploy' => {}) }
        expect(shell).to_not receive(:say).with("Setting up deployment with Rubygems", :green)
        expect(bootstrap).to_not receive(:system).with("travis setup rubygems")
        bootstrap.setup_deployment
      end

    end

    context 'encrypt_api_key' do

      it 'takes the user\'s API key and encrypts it' do
        expect(shell).to receive(:say).with('Encrypting your token and adding it to your .travis.yml', :green)
        expect(shell).to receive(:ask).with("Please enter your Github oauth token - visit https://github.com/settings/tokens/new?description=Henry%20Token to set one up if you haven't already") { 'foobarbaz' }
        expect(bootstrap).to receive(:`).with("travis encrypt GITHUB_OUATH_TOKEN=foobarbaz --add")
        bootstrap.encrypt_api_key
      end

    end

    context 'add_henry' do

      it 'adds henry installation and running to the .travis.yml' do
        expect(shell).to receive(:say).with('Adding Henry to your .travis.yml', :green)
        expect(bootstrap).to receive(:travis) { Hash.new }

        file = double('file')
        allow(File).to receive(:open).with('.travis.yml', 'w+').and_yield(file)
        expect(file).to receive(:write).with("---\nafter_success:\n- gem install henry\n- henry deploy\n")

        bootstrap.add_henry
      end

    end

    context 'perform' do

      it 'runs all the things' do
        expect(bootstrap).to receive(:create_project)
        expect(bootstrap).to receive(:setup_deployment)
        expect(bootstrap).to receive(:encrypt_api_key)
        expect(bootstrap).to receive(:add_henry)

        bootstrap.perform
      end

    end


  end
end
