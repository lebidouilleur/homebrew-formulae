# coding: utf-8
class Vasm < Formula
  desc     "A stack-based assembly language written in Swift."
  homepage "https://github.com/lebidouilleur/vasm"



  stable do
    url    "https://github.com/lebidouilleur/vasm/archive/refs/tags/v0.1%CE%B2.tar.gz"
    sha256 "17e95be103b3c14f8c2cdb26a68791296a8705fe74fd1841fed0fa9fe2ef0422"
  end

  head do
    url "https://github.com/lebidouilleur/vasm.git"
  end



  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    bin.install ".build/release/vasm"
  end
end
