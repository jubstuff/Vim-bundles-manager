# vim_bundle_manager
require 'fileutils'


class VimBundleManager

  # CONSTANTS
  
  GIT_BUNDLES = [ 
    # "git://github.com/astashov/vim-ruby-debugger.git",
    # "git://github.com/ervandew/supertab.git",
    "git://github.com/godlygeek/tabular.git",
    # "git://github.com/hallison/vim-rdoc.git",
    # "git://github.com/msanders/snipmate.vim.git",
    # "git://github.com/pangloss/vim-javascript.git",
    # "git://github.com/scrooloose/nerdtree.git",
    # "git://github.com/timcharper/textile.vim.git",
    # "git://github.com/tpope/vim-cucumber.git",
    # "git://github.com/tpope/vim-fugitive.git",
    # "git://github.com/tpope/vim-git.git",
    # "git://github.com/tpope/vim-haml.git",
    # "git://github.com/tpope/vim-markdown.git",
    # "git://github.com/tpope/vim-rails.git",
    # "git://github.com/tpope/vim-repeat.git",
    "git://github.com/tpope/vim-surround.git",
    # "git://github.com/tpope/vim-vividchalk.git",
    # "git://github.com/tsaleh/taskpaper.vim.git",
    # "git://github.com/tsaleh/vim-matchit.git",
    # "git://github.com/tsaleh/vim-shoulda.git",
    # "git://github.com/tsaleh/vim-tcomment.git",
    # "git://github.com/tsaleh/vim-tmux.git",
    # "git://github.com/vim-ruby/vim-ruby.git",
    # "git://github.com/vim-scripts/Gist.vim.git",
    # "git://github.com/joestelmach/javaScriptLint.vim.git",
  ]

  def initialize(vim_home_path="")
    user = ENV["USER"]
    vim_home = vim_home_path.empty? ? "/home/#{user}/vimtest" : vim_home_path

    @bundles_dir = File.join(vim_home, "bundle")
    FileUtils.cd(@bundles_dir)
  end

  def install( bundle_to_install )
    if bundle_to_install == :all
      GIT_BUNDLES.each do |url|
        clone_bundle(url)
      end
    end
  end

  def update( bundle_to_update )
    if bundle_to_update == :all
      puts "These directory are going to be deleted:"
      Dir["*"].each { |d| puts d }

      puts "Continue? (Y/N)"
      response = gets
      if response.split("").first.capitalize == 'Y'
        Dir["*"].each { |d| FileUtils.rm_rf d }
        install(:all)
      end
    end
  end

  private

    def get_bundle_name(url)
      url.split('/').last.sub(/\.git$/, '')
    end

    def clone_bundle(url)
      dir = get_bundle_name(url)
      puts "unpacking #{url} into #{dir}"
      `git clone #{url} #{dir}`
      FileUtils.rm_rf(File.join(dir, ".git"))
    end
end
