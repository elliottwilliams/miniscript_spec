RSpec.describe '1.6 Parameter Lists' do
  it 'accepts a parameter' do
    expect('document.write("When in the course of human events...")').to be_valid
  end

  it 'accepts zero parameters' do 
    expect('document.write()').to be_valid
  end

  it 'accepts multiple parameters' do
    expect('document.write(blinky,pinky,inky,clyde)').to be_valid
  end

  it 'rejects missing commas' do
    expect('document.write(i write a lot of coffeescript)').to be_invalid
  end

  it 'rejects commas at the front or end of the list' do
    expect('document.write(,trip)').to be_invalid
    expect('document.write(pedantic,pomeranian,)').to be_invalid
  end
  
  it 'rejects multiple commas' do
    expect('document(foo,,bar)').to be_invalid
  end
  
  describe '1.6.1 Parameter types' do
    it 'recognizes expressions' do
      expect('document.write(1+2+3)').to be_valid
      expect('document.write("foo", "bar", "baz")').to be_valid
      expect('document.write(an_id)').to be_valid
    end
  end
end
