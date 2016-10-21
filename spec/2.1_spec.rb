RSpec.describe('2.1 Objects') do
  describe '2.1.1 Object declaration' do
    it 'is enclosed by braces on separate lines'
    it 'declares fields as undefined'
    it 'assigns to fields declared with an initial value'
  end

  describe '2.1.2 Field declaration' do
    it 'requires declarations to be on a single line'
    it 'prohibits nested objects'
    it 'separated fields by commas'
    it 'prohibits trailing commas'
    it 'requires at least one field'
  end

  describe '2.1.3 Field accessor' do
    it 'can be used as a value'
    it 'can be assigned to with a value of the same type'
    it 'cannot assign to an undeclared field'
    it 'accesses fields by dot syntax'
    it 'cannot be redeclared by itself'
    it 'can be redeclared along with the entire object'
  end
end
