require 'git'

module Grundstein
  module Generator
    # Manages the generator repository. Implemented as a singleton (see `instance` method).
    # It uses git to keep the repository up to date.
    # It will check the repo out to '~/.grundstein'.
    # It also creates a file in this directory named 'last_update' where the timestamp of the last update is kept.
    # If this time stamp is too long ago, it will update the repo.
    #
    # Use this class by using the instance method: `Generator::Repository.instance`
    class Repository
      OUTDATED_THRESHOLD = 1 # day(s)
      REPO_URL = 'https://github.com/motine/grundstein.git'
      
      def self.use_gem_repo!
        @use_gem_repo = true
        raise "Can not change repo path after the first call of instance."unless @instance.nil?
      end

      def self.instance
        @instance ||= Repository.new
        return @instance
      end

      # Iteratates through all generators and yields the block with the |name, desc|.
      def generators
        result = []
        Dir.foreach(generators_path) do |dir|
          next if dir.start_with?('.', '#')
          result << dir
        end
        return result
      end

      def generators_path
        return File.join(@path, 'generators')
      end

      def generator_path(name)
        return File.join(generators_path, name)
      end

      protected

      # The constructor will check if the repository is there and create it if necessary.
      # If the repo is outdated, it will update it.
      def initialize
        unless ENV['USE_GEM_REPO'].nil?
          @path = File.expand_path('../../../../', __FILE__)
          return
        end
        @path = File.expand_path("~/.grundstein")
        @git = Git.open(@path)# , :log => Logger.new(STDOUT))
        update if outdated?
      rescue ArgumentError => _
        setup
        retry
      end

      def outdated?
        return DateTime.parse(File.read(last_update_file_path)) < (DateTime.now - OUTDATED_THRESHOLD)
      rescue => _
        return true
      end

      def update
        puts "Updating generator repository..."
        @git.pull
        File.write(last_update_file_path, DateTime.now.to_s)
      end

      def setup
        puts "Initializing generator repository...".c_warning
        @git = Git.init(@path)
        @git.add_remote('origin', REPO_URL)

        # TODO: make sure git > 1.7
        # let's only checkout the generators
        @git.config('core.sparsecheckout', true)
        File.write(File.join(@git.repo.path, 'info', 'sparse-checkout'), 'generators')
        update
      end

      def last_update_file_path
        return File.join(@path, 'last_update')
      end
    end
  end
end
