# coding: utf-8
class Vasm < Formula
  desc     "A stack-based assembly language written in Swift."
  homepage "https://github.com/lebidouilleur/vasm"



  stable do
    url    "https://github.com/lebidouilleur/vasm/archive/refs/tags/v0.2%CE%B1.tar.gz"
    sha256 "5bb79d60864c838783d1823499f3d9164e02d05bec127f4ae3ca7e68c7bca895"
  end

  head do
    url "https://github.com/lebidouilleur/vasm.git"
  end



  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    bin.install ".build/release/vasm"
  end
end
