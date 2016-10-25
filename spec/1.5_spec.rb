RSpec.describe '1.5 Expressions' do
  describe '1.5.1 Arithmetic expression' do
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

    describe '1.5.1.1 Operator overloads' do
      it 'adds numbers' do
        expect('4 + 20').to evaluate_to '24'
      end

      it 'subtracts numbers' do
        expect('4 - 20').to evaluate_to '-16'
      end

      it 'multiplies numbers' do
        expect('56*9').to evaluate_to '504'
      end

      it 'divides numbers' do
        expect('18/3').to evaluate_to '6'
        expect('22/7').to evaluate_to '3'
      end

      it 'concatenates strings with +' do
        expect('"har" + "ambe"').to evaluate_to 'harambe'
      end

      it 'rejects -, *, / on strings' do
        expect('"har" - "ambe"').to fail_evaluation
        expect('"har" * "ambe"').to fail_evaluation
        expect('"har" / "ambe"').to fail_evaluation
      end

      it 'cannot operate on a string and a number together' do
        expect('99 + "red balloons"').to fail_evaluation
      end
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
    it 'can be an identifier' do
      expect('var foo = id').to be_valid
    end
    it 'can be a number literal' do
      expect('var bar = 1234').to be_valid
    end
    it 'can be a string' do
      expect('var baz = "hello!"').to be_valid
    end

    it 'resolves to a string literal' do
      expect('"foo"').to evaluate_to 'foo'
    end
    it 'resolves to a number literal' do
      expect('123').to evaluate_to '123'
    end

    it 'resolves to a scalar variable' do
      expect(%{
             var n = 538;
             document.write(n)}).to output('538')
    end

    it 'resolves to an object field' do
      expect(%{
             var o = {
               n: 538
             }
             document.write(o.n)}).to output('538')
    end

    it 'cannot be an object variable' do
      expect(%{
             var o = {
               n: 538
             }
             document.write(o)}).to fail_typecheck
    end

    it 'cannot be an undefined variable' do
      expect('whoami').to fail_evaluation
    end
  end
end
