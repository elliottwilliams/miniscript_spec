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
    raise UnknownOutputError.new "#{status}:\n#{output}"
  end
end

RSpec::Matchers.define :accept do
  match do |code|
    parser_accepts? code
  end
end

RSpec::Matchers.define :be_a_statement do
  match do |code|
    parser_accepts? <<-EOS
    <script type="text/JavaScript">
    #{code}
    </script>
    EOS
  end
end
