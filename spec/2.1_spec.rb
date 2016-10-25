RSpec.describe('2.1 Objects') do
  describe '2.1.1 Object declaration' do
    it 'is enclosed by braces on separate lines' do
      expect(%{
             var o = {
              field
             }}).to be_valid
      expect(%{ var o = { field }}).to be_invalid
    end

    it 'declares fields as undefined' do
      expect(%{
             var o = {
               field
             }
             o.field = "was_undefined"}).to typecheck
      expect(%{
             var o = {
               field
             }
             document.write(o.field)}).to fail_typecheck
    end

    it 'assigns to fields declared with an initial value' do
      expect(%{
             var o = {
               field: "initialized"
             }; document.write(o.field)}).to output('initialized')
    end
  end

  describe '2.1.2 Field declaration' do
    it 'requires declarations to be on a single line' do
      expect(%{
             var o = {
               field: "initialized"
             }}).to be_valid
      expect(%{
             var o = {
               field: 
               "initialized"
             }}).to be_invalid
    end

    it 'prohibits nested objects' do
      expect(%{
             var x = {
               s: "woah",
               y: {
                 t: "wooah"
               }
             }}).to be_invalid
      expect(%{
             var x = {
               s: "yo"
             }
             var y = {
               t
             }
             y.t = x}).to fail_typecheck
      expect(%{
             var x = {
               s: "yo"
             }
             var y = {
               t: x
             }}).to fail_typecheck
    end

    it 'separated fields by commas' do
      expect(%{
             var x = {
               a, b, c
             }}).to typecheck
      expect(%{
             var x = {
               a b c no
             }}).to be_invalid
    end

    it 'prohibits trailing commas' do
      expect(%{
             var x = {
               a, b, c, 
             }}).to be_invalid
    end

    it 'requires at least one field' do
      expect(%{var x = {
             }}).to be_invalid
    end
  end

  describe '2.1.3 Field accessor' do
    it 'can be used as a value' do
      expect(%{
             var a = {
               x: 1,
               y: 2
             }
             var x = a.x
             document.write(x)}).to output('1')
    end

    it 'can be assigned to with a value of the same type' do
      expect(%{
             var a = {
               x: 1,
               y: 2
             }; var b = {
               x: 3,
               y: 4
             }
             a.x = b.x
             b.y = a.y
             }).to typecheck
    end

    it 'cannot assign to an undeclared field' do
      expect(%{
             var a = {
               f: "foo"
             }
             a.nope = "bar"
             }).to fail_typecheck
    end

    it 'accesses fields by dot syntax' do
      expect(%{
             var a = {
               f: "foo"
             }
             document.write(a.f)
             }).to output('foo')
    end

    it 'cannot be redeclared by itself' do
      expect(%{
             var a = {
               f: "foo"
             }
             var a.f = 123
             }).to be_invalid
    end

    it 'can be redeclared along with the entire object' do
      expect(%{
             var a = {
               f: "foo"
             }
             var a = {
               f
             }
             var a.f = 123
             }).to typecheck
    end

  end
end
