require "../caesar_cipher"

describe "#caesar_cipher" do

  let(:numeric) { "123456" }
  let(:sym) { "Hello, brave new world!" }
  let(:word) {"word"}

  it "returns same word if shift is 0" do
    expect(caesar_cipher(word, 0)).to eql(word)
    expect(caesar_cipher(sym, 0)).to eql(sym)
    expect(caesar_cipher(numeric, 0)).to eql(numeric)
  end

  it "works for positive shift <= 26" do
    expect(caesar_cipher(numeric, 10)).to eql(numeric)
    expect(caesar_cipher(sym, 10)).to eql("Rovvy, lbkfo xog gybvn!")
    expect(caesar_cipher(word, 10)).to eql("gybn")
  end

  it "works for negative shift >= -26" do
    expect(caesar_cipher(numeric, -10)).to eql(numeric)
    expect(caesar_cipher(sym, -10)).to eql("Xubbe, rhqlu dum mehbt!")
    expect(caesar_cipher(word, -10)).to eql("meht")
  end

  it "works when shift > 26" do
    expect(caesar_cipher(numeric, 57)).to eql(numeric)
    expect(caesar_cipher(sym, 57)).to eql("Mjqqt, gwfaj sjb btwqi!")
    expect(caesar_cipher(word, 57)).to eql("btwi")
  end

  it "works when shift < -26" do
    expect(caesar_cipher(sym, -1)).to eql("Gdkkn, aqzud mdv vnqkc!")
    expect(caesar_cipher(numeric, -38)).to eql(numeric)
    expect(caesar_cipher(sym, -38)).to eql("Vszzc, pfojs bsk kcfzr!")
    expect(caesar_cipher(word, -38)).to eql("kcfr")
  end

  it "deals with invalid input" do
    expect { caesar_cipher(word, "red") }.
      to raise_error(ArgumentError, "Argument is invalid")
    expect { caesar_cipher(5, 10) }.
      to raise_error(ArgumentError, "Argument is invalid")
  end

end
