require 'yaml'
Dir.chdir 'source/images/work/big'

dirs = Dir["**"]
res  = {}
dirs.each do |d|
  images = Dir["#{d}/**"].map do |img|
    {:title => "title", :file => img}
  end
  res[d] = images
end

puts res.to_yaml


# ##### renamed to standard
# Dir["*/**"].map{|source|
#   file = File.basename(source)
#   file = file.gsub(/^(\d*)(_*)/, '\1_' ).gsub('_.', '.').downcase
#   target = File.join(File.dirname(source), file)
#   `mv #{source} #{target}`
#   target
# }

