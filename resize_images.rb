#!/usr/bin/env ruby

require 'dragonfly'
originals = Dir['original/*']

app = Dragonfly[:images].configure_with(:imagemagick)
path = File.expand_path(File.dirname(__FILE__))
###### Install smusher gem and optimize the folders by hand.


# Dir.mkdir('thumbs') unless File.exists?('thumbs')
# originals.each do |f|
#   file_name = File.basename(f)
#   img = app.fetch_file("#{path}/#{f}")
#   img.thumb('100x100').encode(:jpg, '-quality 80').to_file("thumbs/#{file_name}")
# end
#
# Dir.mkdir('middle') unless File.exists?('middle')
# originals.each do |f|
#   file_name = File.basename(f)
#   img = app.fetch_file("#{path}/#{f}")
#   img.thumb('450x450').encode(:jpg, '-quality 80').to_file("middle/#{file_name}")
# end
#
# Dir.mkdir('big') unless File.exists?('big')
# originals.each do |f|
#   file_name = File.basename(f)
#   img = app.fetch_file("#{path}/#{f}")
#   img.thumb('800x800').encode(:jpg, '-quality 80').to_file("big/#{file_name}")
# end
#
