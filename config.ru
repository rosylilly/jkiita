# -*- coding: utf-8 -*-

require 'bundler'
Bundler.require

require './application'

map '/assets' do
  run Application.sprockets
end
map '/' do
  run Application
end
