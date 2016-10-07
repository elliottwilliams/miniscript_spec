RSpec.describe '1.3 Structure' do
  it 'should allow zero statement lines' do
    expect(accepts <<-EOS
           <script type="text/JavaScript">
           </script>
           EOS
          ).to be true
  end

  describe '1.3.1 White space' do
    it 'should not influence parsing' 
    it 'should be captured in strings' 
  end

  describe '1.3.2.1 Opening tag' do
    it 'should be the first line of the script' do
      expect(accepts <<-EOS
             <script type="text/JavaScript">
             </script>
             EOS
            ).to be true
    end
    it 'should not be valid elsewhere'
    it 'should only be followed by a newline'
  end

  describe '1.3.2.2 Closing tag' do
    it 'should be the last line of the script'
    it 'should not have other statements on the line'
    it 'should be valid as the final token'
    it 'should permit newlines following'
  end
end

