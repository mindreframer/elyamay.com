## To start:

install rvm
install ruby 1.9.3
install bundler
> bundle install
> middleman server (to develop the site on localhost:4567)
> middleman build (to genereate the site into build-folder)
> rake publish



## fixes for middleman > 3.2.1
# in lib/middleman-core/cli/build.rb (BuildAction.execute!)

    @app.sitemap.resources.select do |resource|
      # only full css-files and not the partials
      resource.ext == ".css" && File.basename(resource.path)[0] != '_'
    end.each do |resource|
      @rack.get(URI.escape(resource.destination_path))
    end
