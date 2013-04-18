module Fiveapps
  class Ctags
    def self.generate_bundler_tags
      runtime = ::Bundler::Runtime.new Dir.pwd, ::Bundler.definition
      paths = runtime.specs.map(&:full_gem_path)
      generate_tags(paths, "gems.tags")
    end

    def self.generate_tags(paths, tag_file)
      paths = paths.join(' ').strip
      cmd = "find #{paths} -type f -name \\*.rb | ctags -f #{tag_file} -L -"
      system cmd
    end
  end
end

namespace :ctags do
  desc 'generate bundle tags'
  task :bundle do
    Fiveapps::Ctags.generate_bundler_tags
  end
end
