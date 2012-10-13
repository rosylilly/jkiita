# -*- coding: utf-8 -*-

$:.unshift "#{File.dirname(__FILE__)}/lib"

class Application < Sinatra::Base

  set :haml, format: :html5, escape_html: true, attr_wrapper: '"', ugly: production?

  set :sprockets, Sprockets::Environment.new

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
    haml :index
  end

  get '/*.html' do |path|
    pass unless File.exist?(File.join(options.views.to_s, "#{path}.haml"))
    haml path.to_sym
  end

  get '/*' do |path|
    pass unless File.exist?(File.join(options.views.to_s, "#{path}.haml"))
    haml path.to_sym
  end

end
