$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'dotenv/load'
require 'phrases'

run Phrases::Web.new
