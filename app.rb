# This file contains your application, it requires dependencies and necessary
# parts of the application.
require 'rubygems'
require 'ramaze'
require 'faraday'

# Make sure that Ramaze knows where you are
Ramaze.options.roots = [__DIR__]
Ramaze.options.prefix = '/kzkadvisor' if ENV['RACK_ENV'] == 'production'

require __DIR__('config/database')
require __DIR__('controller/init')
require __DIR__('model/test')
