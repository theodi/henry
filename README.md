[![Build Status](http://img.shields.io/travis/theodi/henry.svg)](https://travis-ci.org/theodi/henry)
[![Dependency Status](http://img.shields.io/gemnasium/theodi/henry.svg)](https://gemnasium.com/theodi/henry)
[![Coverage Status](http://img.shields.io/coveralls/theodi/henry.svg)](https://coveralls.io/r/theodi/henry)
[![Code Climate](http://img.shields.io/codeclimate/github/theodi/henry.svg)](https://codeclimate.com/github/theodi/henry)
[![Gem Version](http://img.shields.io/gem/v/henry.svg)](https://rubygems.org/gems/henry)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://theodi.mit-license.org)
[![Badges](http://img.shields.io/:badges-7/7-ff6799.svg)](https://github.com/badges/badgerbadgerbadger)

# Henry

We all like continuous deployment, but when it comes to publishing Ruby gems, crafting a new version can become
a royal pain. Travis's Rubygems integration makes things easier, but you still have to push a new tag and write a
changelog, and who has time for that?

Henry makes things really easy, as per [Github flow](https://guides.github.com/introduction/flow/), master is always considered deployable. As soon as the version number is changed and everything is pushed to Travis, once the tests pass (and they will, won't they?), Henry will push a new tag and an automatically generated Changelog (via the magic of [github-changelog-generator](https://github.com/skywinder/github-changelog-generator)). Assuming you have Travis set up
with Rubygems integration, it will then build the latest tag, and publish it directly to Rubygems. Easy huh?

## Usage

In your project directory, first run `gem install travis` and `travis setup rubygems` and follow the onscreen prompts.

Then run the following:

```
travis encrypt GITHUB_OUATH_TOKEN=SUPER_SECRET_TOKEN --add
```

Where `SUPER_SECRET_TOKEN` is your Github Token, which you can generate [here](https://github.com/settings/tokens/new?description=Henry%20Token)

Then add the following to your `.travis.yml`

```
after_success:
- gem install henry
- henry deploy
```

Then push up your changes, and sit back and relax, safe in the knowledge that you'll never forget to push a
new gem version again.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/theodi/henry. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
