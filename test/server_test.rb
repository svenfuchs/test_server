require 'test/unit'
require File.dirname(__FILE__) + '/test_helper.rb'

class ServerTest < Test::Unit::TestCase
  def test_parse_opts_recognizes_daemon_and_pid_argvs
    argv = ["--daemon", "--pid=1"]
    expected = { :daemon => true, :pid => '1' }
    assert_equal expected, TestServer::Server.new.send(:parse_opts, argv)
  end
  
  # no idea how to test Process.fork, DRb.thread.join and stuff like that :/
end


class RunnerTest < Test::Unit::TestCase
  def setup
    @pattern = File.dirname(__FILE__) + '/resources/test/**/*_test.rb'
    @argv = ["--pattern=#{@pattern}"]
  end
  
  def test_parse_opts_recognizes_pattern
    expected = { :pattern => @pattern }
    assert_equal expected, TestServer::Runner.new.send(:parse_opts, @argv)
  end
  
  def test_run
    filename = File.dirname(__FILE__) + '/resources/test/foo_test.rb'
    Kernel.expects(:load).with filename
    TestServer::Runner.run(@argv)
  end
end