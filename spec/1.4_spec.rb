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

    xit 'should print the value given to it' do
      expect('document.write("foo")').to output('foo')
      expect('document.write(1337)').to output('1337')
      expect('var foo = "bar"; document.write(foo)').to output('bar')
    end
    
    it 'concatenates multiple parameters'
    it 'does not print undefined variables'
    it 'does not print object variables'

    describe '1.4.1.1 Line break tag' do
      it 'prints link break tags as newlines'
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

    it 'assigns an expression to a variable of the same type'
    it 'does not assign to conflicting types'
    it 'assigns to object properties'
    it 'does not assign to undeclared variables'
  end

  describe '1.4.3 Declarations' do
    describe '1.4.3.1 Variable declaration' do
      it 'should declare without assignment' do
        expect('var foo').to be_valid
        expect('var bar;').to be_valid
      end
      it 'supports declarative assignment' do
        expect('var foo = "foo"').to be_valid
      end
    end

    describe '1.4.3.2 Object declaration' do
      # TODO: these cases may duplicate tests in 2.1.1
      it 'declares objects with undefined fields'
      it 'declares objects with defined fields'
      it 'declares partially defined objects'
  end

    describe '1.4.4 Compound statement' do
      it 'is enclosed by braces'
      it 'accepts braces on separate lines'
      it 'contains at least one statement'
      it 'inherits a new variable scope'
    end 
end
