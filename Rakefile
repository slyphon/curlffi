namespace :dev do
  task :ctags do
    vers = `ctags --version`
    unless $?.success?
      $stderr.puts "could not find 'ctags' executable in path"
      exit 1
    end

    unless vers.split($/).first =~ /^Exuberant Ctags/
      $stderr.puts "ctags executable is not 'Exuberant Ctags'"
      exit 1
    end

    require 'rubygems'
    src_dirs = FileList["#{Gem.dir}/gems/ffi-0.3.5"]

    dirs = %w[lib]
    dirs += %w[src] if File.exists?('src')

    sh "ctags -R #{dirs.join(' ')} #{src_dirs.join(' ')} >/dev/null 2>&1"
  end
end


