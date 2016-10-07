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
end
