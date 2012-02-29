#!/usr/bin/env ruby

require 'dragonfly'
originals = Dir['portfolio/*/**']

app = Dragonfly[:images].configure_with(:imagemagick)
path = File.expand_path(File.dirname(__FILE__))



folder_name = 'resized'
Dir.mkdir(folder_name) unless File.exists?(folder_name)
originals.each do |f|
  file_name_part = f.split('/')[1..-1].join('/') # only the last to path parts
  img = app.fetch_file(File.expand_path(f))
  img.thumb('1024x640').to_file("#{folder_name}/#{file_name_part}")
end

# .encode(:jpg, '-quality 80')

###### Install smusher gem and optimize the folders by hand.


# Dir.mkdir('my_thumbs') unless File.exists?('my_thumbs')
# originals.each do |f|
#   file_name = File.basename(f)
#   img = app.fetch_file("#{path}/#{f}")
#   img.thumb('100x100').encode(:jpg, '-quality 80').to_file("my_thumbs/#{file_name}")
# end
#
# Dir.mkdir('my_middle') unless File.exists?('my_middle')
# originals.each do |f|
#   file_name = File.basename(f)
#   img = app.fetch_file("#{path}/#{f}")
#   img.thumb('450x450').encode(:jpg, '-quality 80').to_file("my_middle/#{file_name}")
# end
#
