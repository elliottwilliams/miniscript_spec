RSpec.describe '1.4 Statements' do
  describe '1.4.1 Document write' do
    it 'should accept a single argument' do
      expect('document.write(a)').to be_valid
    end
    it 'should enclose a parameter list' do
      expect('document.write(a, b, c)').to be_valid
    end
    it 'should not permit whitespace around the parentheses' do
      expect('document.write (a)').to be_invalid
    end

    it 'should print the value given to it' do
      expect('document.write("foo")').to output('foo')
      expect('document.write(1337)').to output('1337')
      expect('var foo = "bar"; document.write(foo)').to output('bar')
    end
    
    it 'concatenates multiple parameters' do
      expect('document.write("to", "get", "her")').to output('together')
      expect('document.write(99, "red balloons")').to output('99red balloons')
    end

    it 'does not print undefined variables' do
      expect('document.write(nope)').to fail_typecheck
    end

    it 'prints field values but not objects' do
      given = %{
      var profs = {
        cs352: "li",
        phil303: "cover"
      }
      document.write(profs.cs352)}

      expect(given).to output('li')
      expect(given + '; document.write(profs)').to fail_typecheck
    end

    describe '1.4.1.1 Line break tag' do
      it 'prints link break tags as newlines' do
        expect('document.write("<br />")').to output("\n")
        expect('document.write("<br/>")').to output('<br/>')
      end
    end
  end

  describe '1.4.2 Assignment' do
    it 'should assign to an identifier' do
      expect('foo = bar').to be_valid
    end
    it 'should assign to an expression' do
      expect('foo = 1 + 2').to be_valid
    end
    it 'only assigns to identifiers' do
      expect('1+2 = 2').to be_invalid
      expect('"bar" = foo').to be_invalid
    end
    it 'should not assign to multiple identifiers' do
      expect('a = b = 0').to be_invalid
    end

    it 'replaces LHS value with RHS value' do
      expect(%{
             var a = "foo"
             var b = "bar"
             a = b
             document.write(a, b)}).to output('barbar')
    end

    it 'performs a shallow copy' do
      expect(%{
             var a = "foo"
             var b = "bar"
             a = b
             b = "baz"
             document.write(a, b)}).to output('barbaz')
    end

    it 'assigns to undefined variables' do
      expect('var a = 1; var b = "a"; var c = 3;').to typecheck
    end

    it 'assigns to defined variables of the same type' do
      expect('var a = 1; var b = 2; a = b;').to typecheck
    end

    it 'assigns to object properties' do
      expect(%{
             var o = {
             city: "West Lafayette"
             }; o.city = "San Francisco"
             document.write(o.city)}).to output('San Francisco')
    end

    it 'does not assign to conflicting types' do
      expect('var n = 420; n = "blaze"').to fail_typecheck
    end

    it 'does not assign to undeclared variables' do
      expect('i_am = "not here"').to fail_typecheck
    end
  end

  describe '1.4.3 Declarations' do
    it 'should declare without assignment' do
      expect('var foo').to be_valid
      expect('var bar;').to be_valid
    end

    it 'supports declarative assignment' do
      expect('var foo = "foo"').to be_valid
    end
  end

    describe '1.4.4 Compound statement' do
      it 'is enclosed by braces on separate lines' do
        expect(%{
               var a
               { 
                 var b
               }
               }).to be_valid
      end

      it 'contains at least one statement' do
        expect(%{{
                 var a
               }}).to be_valid
        expect(%{{
               }}).to be_invalid
      end

      it 'accesses variables in outer scopes' do
        expect(%{
               var outer = "foo"
               {
                 var inner = "bar"
                 document.write(outer)
               }}).to output('foo')
      end
      
      it 'does not overwrite variables in outer scopes' do
        expect(%{
               var outer = "foo"
               {
                 var inner = "bar"
                 var outer = "baz"
                 document.write(outer)
               }; document.write(outer)}).to output('bazfoo')
      end

      it 'does not leak variables into parent scope' do
        expect(%{
               var outer = "foo"
               {
                 var inner = "bar"
                 var outer = "baz"
               }; document.write(inner)}).to fail_typecheck

        expect(%{
               var outer = "foo"
               {
                 var inner = "bar"
                 var outer = "baz"
               }; {
                 document.write(inner)
               }}).to fail_typecheck
      end
    end 
end
