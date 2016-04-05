[![Build Status](http://img.shields.io/travis/theodi/henry.svg)](https://travis-ci.org/theodi/henry)
[![Dependency Status](http://img.shields.io/gemnasium/theodi/henry.svg)](https://gemnasium.com/theodi/henry)
[![Coverage Status](http://img.shields.io/coveralls/theodi/henry.svg)](https://coveralls.io/r/theodi/henry)
[![Code Climate](http://img.shields.io/codeclimate/github/theodi/henry.svg)](https://codeclimate.com/github/theodi/henry)
[![Gem Version](http://img.shields.io/gem/v/henry.svg)](https://rubygems.org/gems/henry)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://theodi.mit-license.org)
[![Badges](http://img.shields.io/:badges-7/7-ff6799.svg)](https://github.com/badges/badgerbadgerbadger)

# Henry

![Henry](henry.jpg)

(Photo by [davidwithacamera](https://www.flickr.com/photos/davidwithacamera/8735762528/in/photolist-eiX4Rj-acUjmF-4bovG5-iY8b5-8rFzHk-8zvhCt-7x3Arr-7x3At8-pwa9MS-gXVmsT-77P3vT-6wmd3u-4yFEiP-de88Zq-9n77JU-9ibgqA-77SWZW-iuDhWd-7hXjpC-Q4L3W-siaKXc-iMUCq-iMUCo-iMpV9-nfdQHV-iMpV7-bv7gRn-iMUCn-4XKeGw-bv7gPa-iMpVa-nuENLQ-ppP12m-iMpV6-76ZeS9-6XkzcH-sfVoQN-71dYXN-8RqpdM-8Rqpgp-fAts7o-b6fFHc-aFjc81-6FECmy-6Xpzku-bd84hV-d3RA1-6BQfCG-7pUwj9-amBpQP))

We all like continuous deployment, but when it comes to publishing Ruby gems, crafting a new version can become
a royal pain. Travis's Rubygems integration makes things easier, but you still have to push a new tag and write a
changelog, and who has time for that?

Henry makes things really easy, as per [Github flow](https://guides.github.com/introduction/flow/), master is always considered deployable. As soon as the version number is changed and everything is pushed to Travis, once the tests pass (and they will, won't they?), Henry will push a new tag and an automatically generated Changelog (via the magic of [github-changelog-generator](https://github.com/skywinder/github-changelog-generator)). Assuming you have Travis set up
with Rubygems integration, it will then build the latest tag, and publish it directly to Rubygems. Easy huh?

## Usage

In your project directory, first run `gem install henry` and `henry bootstrap` and follow the onscreen prompts.

Then push up your changes, and sit back and relax, safe in the knowledge that you'll never forget to push a
new gem version again.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/theodi/henry. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
