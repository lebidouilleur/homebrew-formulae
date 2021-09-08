# coding: utf-8
class Vasm < Formula
  desc     "A stack-based assembly language written in Swift."
  homepage "https://github.com/lebidouilleur/vasm"



  stable do
    url    "https://github.com/lebidouilleur/vasm/archive/refs/tags/v0.1%CE%B3.tar.gz"
    sha256 "2e11350e5dda33009d8c3beb74f2b60fb0f69291beb7056c357ddc4101c1a4c4"
  end

  head do
    url "https://github.com/lebidouilleur/vasm.git"
  end



  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    bin.install ".build/release/vasm"
  end
end
