# coding: utf-8
class Bf < Formula
  desc     "A brainfuck interpreter and compiler in Swift."
  homepage "https://github.com/lebidouilleur/bf"



  head do
    url "https://github.com/lebidouilleur/bf.git"
  end



  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    bin.install ".build/release/bf"
    bin.install ".build/release/bfc"
  end
end
