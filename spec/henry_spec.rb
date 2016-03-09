require 'spec_helper'

ENV['TRAVIS_REPO_SLUG'] = 'theodi/useless-gem'
ENV['TRAVIS_BRANCH'] = 'master'
ENV['TRAVIS_PULL_REQUEST'] = 'false'
ENV['TRAVIS_COMMIT'] = '5c0f9870359e7a290ced48836ec4edde3c536490'

module Henry
  describe Deploy, :vcr do
    before(:each) do
      @tmpdir = Dir.mktmpdir
      Git.clone "https://github.com/theodi/useless-gem.git", @tmpdir
      @deploy = described_class.new(@tmpdir.to_s)
    end

    after(:each) do
      FileUtils.remove_entry_secure @tmpdir
    end

    after(:each, :tags) do
      @deploy.delete_tags
    end

    it 'should return true for deployable' do
      expect(@deploy.deployable?).to eq(true)
    end

    it 'should get the gem version' do
      expect(@deploy.version).to eq('9.1.7')
    end

    it 'should push tags', :tags do
      tags = @deploy.push_tags
      expect(tags).to eq(true)
    end

    it 'should return false if tag already exists', :tags do
      @deploy.push_tags
      tags = @deploy.push_tags
      expect(tags).to eq(false)
    end

    it 'should generate a changelog', :tags do
      @deploy.push_tags
      @deploy.generate_changelog
      expect(File).to exist(File.join @tmpdir, 'CHANGELOG.md')
    end

    it 'should push the changelog', :tags do
      @deploy.perform

      expect(open('https://raw.githubusercontent.com/theodi/useless-gem/master/CHANGELOG.md').read).to eq(@deploy.changelog_content)
    end

  end
end
