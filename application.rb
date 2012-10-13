# -*- coding: utf-8 -*-

require 'rubygems'
$:.unshift "#{File.dirname(__FILE__)}/lib"

class Application < Sinatra::Base

  set :sprockets, Sprockets::Environment.new
  set :views, 'views'

  configure do
    set :site_title, ENV['SITE_TITLE']

    Sprockets::Helpers.configure do |config|
      config.environment = sprockets
      config.prefix = '/assets'
      config.digest = true
    end
    sprockets.append_path 'assets/javascripts'
    sprockets.append_path 'assets/stylesheets'
    sprockets.append_path 'assets/images'

    if production?
      sprockets.js_compressor = YUI::JavaScriptCompressor.new(munge: true, optimize: true)
      sprockets.css_compressor = YUI::CssCompressor.new
    end
  end

  helpers Sprockets::Helpers

  get '/' do
    slim :index
  end

  get %r{/?(.+)(\.html)?$} do |path, ext|
    pass unless File.exist?(File.join(options.views.to_s, "#{path}.slim"))
    slim path.to_sym
  end

end
