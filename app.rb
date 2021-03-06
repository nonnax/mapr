#!/usr/bin/env ruby
# Id$ nonnax 2022-04-25 22:40:25 +0800
require_relative 'lib/mapr'

# Mapa.settings[:views]='views'

$sum = 0

Thread.new do # trivial example work thread
  loop do
     sleep 0.12
     $sum += 1
  end
end

App = Mapr do
  #
  # path test first
  #
  on '/thread' do
    res.write "Testing background work thread: sum is #{$sum}"
  end

  on '/tv' do |params|
    get do
      session[:name]='mapa'
      erb 'watch:tv:', title: 'tv time'
    end
  end

  # get do
    on '/login/:name' do |name, params|
      get do
        session[:name]=name
        erb 'welcome:'+session[:name]+String(params), title: 'welcome'
      end
    end
  # end
  #
  # method test first
  #
  get do
    on '/:any' do |any, param|
      erb 'watch:' + String(session[:name] || 'movie')+String(param), title: 'movie time'
    end
  end

  on '/' do
    res.redirect '/thread'
  end

  not_found do
    erb 'notto foundo'
  end

end
