$:.unshift 'vendor/adva/plugins/rspec/lib' # For rspec installed as plugin
require 'spec'

module TestServer
  module Runner
    class Specs
      class << self
        def run(argv = ARGV, stderr = STDERR, stdout = STDOUT)
          $stdout = stdout
          $stderr = stderr

          argv << "--color"
          opts = ::Spec::Runner::OptionParser.parse(argv, $stderr, $stdout)
          
          ::Spec::Runner::CommandLine.run opts
        end
      end
    end
  end
end

