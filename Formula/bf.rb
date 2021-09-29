# coding: utf-8
class Bf < Formula
  desc     "A brainfuck interpreter and compiler in Swift."
  homepage "https://github.com/lebidouilleur/bf"


  stable do
    url    "https://github.com/lebidouilleur/bf/archive/refs/tags/v0.1.tar.gz"
    sha256 "4032781248b1bcb3f2ffdf4b1ff351a8d25bd0a8bb3c210763c3ff77e47ae005"
  end

  head do
    url "https://github.com/lebidouilleur/bf.git"
  end



  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    bin.install ".build/release/bf"
    bin.install ".build/release/bfc"
  end
end
