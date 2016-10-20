require 'open3'

class UnknownOutputError < RuntimeError
end

def parser_accepts? code
  output, _ = Open3.capture2e '../parser', stdin_data: code
  if output == '' 
    true
  elsif output.lines.first&.chomp == 'Syntax errors' 
    false
  else
    raise UnknownOutputError.new output
  end
end

def parser_outputs? expected, given:
  output, _ = Open3.capture2e '../parser', stdin_data: given
  output == expected
end

def parser_typechecks? code
  output, _ = Open3.capture2e '../parser', stdin_data: code
  if /type violation$/ =~ output.lines.first
    false
  else
    true
  end
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
    match { |code| parser_outputs? expected, given: enclose_statements(code) }
  end

  Matchers.define :typecheck do
    match { |code| parser_typechecks? enclose_statements(code) }
  end
  Matchers.define_negated_matcher :fail_typecheck, :typecheck

end
