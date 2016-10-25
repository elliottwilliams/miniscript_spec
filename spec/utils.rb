require 'open3'
require 'pry'

class UnknownOutputError < RuntimeError
end

def parser_accepts? code
  not parse(code, syntax_only: true).include? 'Syntax errors'
end

def parser_typechecks? code
  not parse(code).include? 'type violation'
end

def parse code, syntax_only: false
  cmd = syntax_only ? '../parser_syntax' : '../parser'
  output, _ = Open3.capture2e cmd, stdin_data: code
  output
end

def enclose_statements code
  <<-EOS
  <script type="text/JavaScript">
  #{code}
  </script>
  EOS
end

module RSpec
  Matchers.define :accept do
    match { |code| parser_accepts? code }
  end
  Matchers.alias_matcher :accepted, :accept
  Matchers.define_negated_matcher :reject, :accept
  Matchers.alias_matcher :rejected, :reject

  Matchers.define :be_a_statement do
    match { |code| parser_accepts? enclose_statements(code) }
  end
  Matchers.alias_matcher :be_valid, :be_a_statement
  Matchers.define_negated_matcher :be_invalid, :be_valid
  Matchers.alias_matcher :recognize, :be_valid

  Matchers.define :output do |expected|
    match do |code| 
      @actual = parse enclose_statements(code)
      values_match? @actual, expected
    end
    failure_message do |actual|
      %{expected output of to be "#{expected}", but it was instead "#{actual}"}
    end
    diffable
  end

  Matchers.define :typecheck do
    match { |code| parser_typechecks? enclose_statements(code) }
  end
  Matchers.define_negated_matcher :fail_typecheck, :typecheck
  Matchers.alias_matcher :not_typecheck, :fail_typecheck

  Matchers.define :evaluate_to do |result|
    match do |expression|
      expect("document.write(#{expression})").to output(result)
    end
  end

  Matchers.define :fail_evaluation do
    match do |expression|
      expect("document.write(#{expression})").to fail_typecheck
    end
  end

end
