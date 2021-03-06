#! /usr/bin/ruby

require_relative 'helper'

# Test the option parser
class GitbotOptionTest < Minitest::Test
  def set_option(hash, s)
    opp = OptParser.new
    opp.options = hash
    ex = assert_raises OptionParser::MissingArgument do
      opp.gitbot_options
    end
    assert_equal("missing argument: #{s}", ex.message)
  end

  def test_partial_import
    hash =  { repo: 'gino/gitbot' }
    hash1 = { repo: 'gino/gitbot', context: 'python-t',
              description: 'functional', test: 'gino.sh' }
    set_option(hash, 'context')
    set_option(hash1, 'file_type')
  end

  def test_full_option_import
    opp2 = OptParser.new
    full_hash = { repo: 'gino/gitbot', context: 'python-t',
                  description: 'functional', test_file: 'gino.sh',
                  file_type: '.sh', git_dir: 'gitty' }
    opp2.options = full_hash
    options = opp2.gitbot_options
    option_ass(options)
  end

  def option_ass(options)
    assert_equal('gino/gitbot', options[:repo])
    assert_equal('python-t', options[:context])
    assert_equal('functional', options[:description])
    assert_equal('gino.sh', options[:test_file])
    assert_equal('.sh', options[:file_type])
    assert_equal('gitty', options[:git_dir])
  end
end
