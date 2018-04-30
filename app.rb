# This file contains your application, it requires dependencies and necessary
# parts of the application.
require 'rubygems'
require 'ramaze'
require 'mechanize'
require 'json'
require 'digest'
require 'pdfkit'

# Make sure that Ramaze knows where you are
Ramaze.options.roots = [__DIR__]
Ramaze.options.prefix = ENV['RACK_ENV'] == 'production'? '/kzkadvisor' : ''

require __DIR__('config/database')
require __DIR__('controller/init')
require __DIR__('model/user')
require __DIR__('model/login')
