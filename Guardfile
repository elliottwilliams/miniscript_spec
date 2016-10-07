directories %w(..)

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{spec/.+_spec\.rb$})
  watch('../parser') { 'spec' }
  watch('spec/utils.rb') { 'spec' }
end
