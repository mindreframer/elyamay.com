require 'fileutils'

# master <-> gh-pages for normal repos
# source <-> master   for github user/organization repos

REMOTE        = ENV["REMOTE"] ||'origin'
REPO_URL      = `git config --get remote.#{REMOTE}.url`.strip
GH_PAGES_NAME = REPO_URL.match("\\.github.com") ? "master" : "gh-pages"
SOURCE_NAME   = REPO_URL.match("\\.github.com") ? "source" : "master"


PROJECT_ROOT = `git rev-parse --show-toplevel`.strip
BUILD_DIR    = File.join(PROJECT_ROOT, "build")
GH_PAGES_REF = File.join(BUILD_DIR, ".git/refs/remotes/#{REMOTE}/#{GH_PAGES_NAME}")



directory BUILD_DIR

file GH_PAGES_REF => BUILD_DIR do
  cd BUILD_DIR do
    sh "git init"
    begin
      sh "git remote add #{REMOTE} #{REPO_URL}"
    rescue
    end
    sh "git fetch #{REMOTE}"

    if `git branch -r` =~ %r[#{GH_PAGES_NAME}]
      sh "git checkout #{GH_PAGES_NAME}"
    else
      sh "git checkout --orphan #{GH_PAGES_NAME}"
      sh "touch index.html"
      sh "git add ."
      sh "git commit -m 'initial gh-pages commit'"
      sh "git push #{REMOTE} #{GH_PAGES_NAME}"
    end
  end
end

# Alias to something meaningful
task :prepare_git_remote_in_build_dir => GH_PAGES_REF

# Fetch upstream changes on gh-pages branch
task :sync do
  cd BUILD_DIR do
    sh "git fetch #{REMOTE}"
    sh "git reset --hard #{REMOTE}/#{GH_PAGES_NAME}"
  end
end

# Prevent accidental publishing before committing changes
task :not_dirty do
  puts "***#{ENV['ALLOW_DIRTY']}***"
  unless ENV['ALLOW_DIRTY']
    fail "Directory not clean" if /nothing to commit/ !~ `git status`
  end
end

desc "Compile all files into the build directory"
task :build do
  cd PROJECT_ROOT do
    sh "bundle exec middleman build"
    sh "cp CNAME #{BUILD_DIR}/CNAME"
  end
end

desc "Build and publish to Github Pages"
task :push_to_github do
    message = nil

  cd PROJECT_ROOT do
    head = `git log --pretty="%h" -n1`.strip
    message = "Site updated to #{head}"
  end

  cd BUILD_DIR do
    sh 'git add --all'
    if /nothing to commit/ =~ `git status`
      puts "No changes to commit."
    else
      sh "git commit -m \"#{message}\""
    end
    sh "git push -f #{REMOTE} #{GH_PAGES_NAME}"
  end
end

desc "does everything and cleanes up for local mode"
task :publish => [:not_dirty, :prepare_git_remote_in_build_dir, :sync, :build, :push_to_github]

