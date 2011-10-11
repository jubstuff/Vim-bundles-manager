
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
    # "git://github.com/tpope/vim-surround.git",
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

  def initialize(vim_home_dir="")
    # TODO come trovare la HOME di vim?
    vim_home = vim_home_dir.empty? ? '/home/justb/vimtest' : vim_home_dir 

    @bundles_dir = File.join(vim_home, "bundle")
    FileUtils.cd(@bundles_dir)

  end

  def update( bundle_to_update )
    puts "I'm working in #{@bundles_dir}"
    gets
    if bundle_to_update == :all
      GIT_BUNDLES.each do |url|
        dir = get_bundle_name
        puts "unpacking #{url} into #{dir}"
        `git clone #{url} #{dir}`
        FileUtils.rm_rf(File.join(dir, ".git"))
      end
    end
  end

  private

    def get_bundle_name(url)
      url.split('/').last.sub(/\.git$/, '')
    end
end
