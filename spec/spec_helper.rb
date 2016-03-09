require 'coveralls'
Coveralls.wear!

require 'git'
require 'dotenv'
require 'open-uri'
require 'helpers/vcr'

Dotenv.load

# This is needed to supress the Github Changelog generator outputs
module SpecHelper
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'henry'
