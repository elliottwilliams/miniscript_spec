require 'open3'
class UnknownOutputError < RuntimeError
end

def accepts input
  output, _ = Open3.capture2e '../parser', stdin_data: input
  if output.lines.first.chomp == 'Syntax errors' 
    false
  elsif output == '' 
    true
  else
    raise UnknownOutputError.new "#{status}:\n#{output}"
  end
end
