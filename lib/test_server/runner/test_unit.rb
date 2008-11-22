require 'test_server/runner/redgreen'
Test::Unit.run = true

module TestServer
  module Runner
    class TestUnit
      class << self
        def run(argv = ARGV, stderr = STDERR, stdout = STDOUT)
          $stdout = stdout
          $stderr = stderr
          
          options = parse_opts(argv)
          pattern = options[:pattern] || 'test/**/*_test.rb'

          Dir[pattern].each { |file| Kernel.load file }
          Test::Unit::AutoRunner.run
        end
        
        protected
    
          def parse_opts(argv)
            options = Hash.new
            opts = OptionParser.new
            opts.on("-p", "--pattern [PATTERN]") { |p| options[:pattern] = p }
            opts.parse!(argv)
            options
          end
      end
    end
  end
end