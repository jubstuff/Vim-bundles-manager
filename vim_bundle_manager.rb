# vim_bundle_manager
require 'fileutils'


class VimBundleManager

  def initialize(vim_home_path="")
    user = ENV["USER"]
    vim_home = vim_home_path.empty? ? "/home/#{user}/vimtest" : vim_home_path

    @git_bundles = create_bundle_hash

    @bundles_dir = File.join(vim_home, "bundle")
    FileUtils.cd(@bundles_dir)
  end

  def install( bundle_to_install )
    if bundle_to_install == :all
      @git_bundles.values.each do |url|
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

  def list_bundles( which=:enabled )
    all = @git_bundles.keys
    enabled = Dir["*"]
    disabled = all - enabled
    case which
    when :all
      list( "Enabled plugins", enabled )
      list( "Disabled plugins", disabled )
    when :enabled
      list( "Enabled plugins", enabled )
    when :disabled
      list( "Disabled plugins", disabled )
    end
  end

  private
    def list( msg, plugin_list )
      puts "==#{msg}=="
      plugin_list.each do |plugin|
        puts plugin
      end
    end

    def create_bundle_hash
      @git_bundles = {}
      File.open("git_bundles") do |f|
        while git_repo = f.gets
          git_repo.chomp!
          name = get_bundle_name(git_repo)
          @git_bundles[name] = git_repo
        end
      end
      @git_bundles
    end

    ##
    # Extract plugin name from git url
    #
    # Example
    # "git://github.com/godlygeek/tabular.git" -> tabular
    # 
    def get_bundle_name(url)
      url.split('/').last.sub(/\.git$/, '')
    end

    ##
    # Clone plugin from git repository
    #
    def clone_bundle(url)
      dir = get_bundle_name(url)
      puts "unpacking #{url} into #{dir}"
      `git clone #{url} #{dir}`
      FileUtils.rm_rf(File.join(dir, ".git"))
    end
end
