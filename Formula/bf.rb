# coding: utf-8
class Bf < Formula
  desc     "A brainfuck interpreter and compiler in Swift."
  homepage "https://github.com/lebidouilleur/bf"


  stable do
    url    "https://github.com/lebidouilleur/bf/archive/refs/tags/v0.1.tar.gz"
    sha256 "7ffca09a2a1b6a75d710a98defd264d735491769cf790f4bcdcbd2582a600313"
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
