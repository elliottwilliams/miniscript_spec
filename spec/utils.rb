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

module RSpec
  Matchers.define :accept do
    match do |code|
      parser_accepts? code
    end
  end
  Matchers.alias_matcher :accepted, :accept
  Matchers.define_negated_matcher :reject, :accept
  Matchers.alias_matcher :rejected, :reject

  Matchers.define :be_a_statement do
    match do |code|
      parser_accepts? <<-EOS
    <script type="text/JavaScript">
      #{code}
    </script>
      EOS
    end
  end
  Matchers.alias_matcher :be_valid, :be_a_statement
  Matchers.define_negated_matcher :be_invalid, :be_valid
  Matchers.alias_matcher :recognize, :be_valid
end
