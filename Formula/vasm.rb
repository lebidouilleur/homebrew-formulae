# coding: utf-8
class Vasm < Formula
  desc     "A stack-based assembly language written in Swift."
  homepage "https://github.com/lebidouilleur/vasm"



  stable do
    url    "https://github.com/lebidouilleur/vasm/archive/refs/tags/v0.1.tar.gz"
    sha256 "b83487931478d394493451a0caa131ead6499fd212b0ce2d737823f433eb2303"
  end

  head do
    url "https://github.com/lebidouilleur/vasm.git"
  end



  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    bin.install ".build/release/vasm"
  end
end
