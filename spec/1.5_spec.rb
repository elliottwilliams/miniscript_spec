RSpec.describe '1.5 Expressions' do
  describe '1.5.1 Arithmetic expression' do
    it 'can be an identifier' do
      expect('var foo = id').to be_valid
    end
    it 'can be a number literal' do
      expect('var bar = 1234').to be_valid
    end
    it 'can be a string' do
      expect('var baz = "hello!"').to be_valid
    end

    it 'supports basic operators' do
      ['e = 4 + 3',
       'e = 3 - 2',
       'e = 2 * 1',
       'e = 1 / 0'].each { |x| expect(x).to be_valid }
    end

    it 'doesn\'t mind strings' do
      expect('e = "foo" + "bar"').to be_valid
    end

    it 'supports a ridiculous expression' do
      expect('var yuuuuuuge_math_problem = ((((((((a*b+c-d)+e))+f+k)+g)+h))+i)-1000').to be_valid
    end
  end

  describe '1.5.2 Grouping' do
    it 'allows left-associated compounding' do
      expect('e = 1 + 2 + 3 + 4 * "tell me that you love me more"').to be_valid
    end

    it 'supports superfluous parentheses' do
      expect('e = (4 + 3)').to be_valid
    end


    it 'nests parenthesized expressions' do
      expect('e = ( 2*3) + 4 - (1/2)').to be_valid
    end

    it 'rejects unbalanced parentheses' do
      expect('e = (1*2) + (3/(4/5)').to be_invalid
      expect('e = ":-")').to be_invalid
    end
  end

  describe '1.5.3 Value resolution' do
    it 'resolves to a string literal'
    it 'resolves to a number literal'
    it 'resolves to a scalar variable'
    it 'resolves to an object field'
    it 'cannot be an object variable'
    it 'cannot be an undefined variable'
  end
end
