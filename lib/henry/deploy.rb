module Henry
  class Deploy

    def initialize(path)
      @user, @repo, @commit = ENV['TRAVIS_REPO_SLUG'].split('/')[0], ENV['TRAVIS_REPO_SLUG'].split('/')[1], ENV['TRAVIS_COMMIT']
      @path = path
      @github = Github.new oauth_token: ENV['GITHUB_OUATH_TOKEN']
    end

    def version
      @version ||= Gem::Specification.load(Dir["#{@path}/*.gemspec"].first).version.to_s
    end

    def perform
      if deployable? && push_tags === true
        generate_changelog
        push_changelog
      end
    end

    def push_tags
      begin
        @github.git_data.references.create(@user, @repo, ref: "refs/tags/#{version}", sha: @commit).success?
      rescue Github::Error::UnprocessableEntity
        false
      end
    end

    def delete_tags
      @github.git_data.references.delete(@user, @repo, "tags/#{version}")
    end

    def changelog_content
      generator = GitHubChangelogGenerator::Generator.new(user: @user, project: @repo, token: ENV['GITHUB_OUATH_TOKEN'], base: @path, date_format: '%Y-%m-%d')
      generator.compound_changelog
    end

    def generate_changelog
      File.open(File.join(@path, 'CHANGELOG.md'), "w") { |file| file.write(changelog_content) }
    end

    def push_changelog
      filename = 'CHANGELOG.md'
      file_path = File.join(@path, filename)
      blob_sha = blob(File.open(file_path).read)
      tree_sha = tree(filename, blob_sha)
      commit_sha = commit(tree_sha, filename)

      @github.git_data.references.update @user, @repo, "heads/master", "sha" => commit_sha
    end

    def blob(content)
      blob = @github.git_data.blobs.create @user, @repo, "content" => content, "encoding" => "utf-8"
      blob['sha']
    end

    def tree(filename, blob_sha)
      tree = @github.git_data.trees.get @user, @repo, 'master'
      new_tree = @github.git_data.trees.create @user, @repo, "base_tree" => tree['sha'], "tree" => [
        "path" => filename,
        "mode" => "100644",
        "type" => "blob",
        "sha" => blob_sha
      ]
      new_tree['sha']
    end

    def commit(tree_sha, filename)
      branch_data = @github.repos.branch @user, @repo, 'master'
      latest_commit = branch_data['commit']['sha']
      commit = @github.git_data.commits.create @user, @repo, "message" => "Updated #{filename} [ci skip]",
              "parents" => [latest_commit],
              "tree" => tree_sha
      commit['sha']
    end

    def deployable?
      ENV['TRAVIS_BRANCH'] == 'master' && ENV['TRAVIS_PULL_REQUEST'] == "false"
    end

  end
end
