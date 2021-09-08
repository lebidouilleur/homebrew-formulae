# coding: utf-8
class Vasm < Formula
  desc     "A stack-based assembly language written in Swift."
  homepage "https://github.com/lebidouilleur/vasm"



  stable do
    url    "https://github.com/lebidouilleur/vasm/archive/refs/tags/v0.1%CE%B3.tar.gz"
    sha256 "e366fafd133429e91fe512e518a130fbc1c0c552bfc56191a616ecceb18df4ab"
  end

  head do
    url "https://github.com/lebidouilleur/vasm.git"
  end



  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    bin.install ".build/release/vasm"
  end
end
