RSpec.describe '1.3 Structure' do
  it 'should allow zero statement lines' do
    %{<script type="text/JavaScript">
      </script>
    }.should accept
  end

  describe '1.3.1 White space' do
    it 'should be ignored by parsing' do
      'var foo;'.should be_a_statement
      'var     foo;'.should be_a_statement
      'document.write(bar)'.should be_a_statement
      'document.write ( bar )'.should be_a_statement
    end

    it 'should delimit identifiers and reserved words' do
      'var foo;'.should be_a_statement
      'varfoo;'.should_not be_a_statement
    end
  end

  describe '1.3.2.1 Opening tag' do
    it 'should be the first line of the script' do
      %{<script type="text/JavaScript">
        </script>
      }.should accept
    end

    it 'should not be valid elsewhere' do
      %{var foo;
        document.write("Hello")
        <script type="text/JavaScript">
        var bar = 1
      }.should_not accept
    end

    it 'should only be followed by a newline' do
      %{<script type="text/JavaScript">;
        var foo;
        </script>
      }.should_not accept
    end
  end

  describe '1.3.2.2 Closing tag' do
    it 'should be the final statement of the script' do
      %{<script type="text/JavaScript">
        </script>
      }.should accept

      %{<script type="text/JavaScript">
        </script>
        var foo;
      }.should_not accept

      %{<script type="text/JavaScript">
        var foo; </script>
      }.should accept
    end
    
    it 'should permit newlines following' do
      %{<script type="text/JavaScript">
        </script>


      }.should accept
    end
  end
end

