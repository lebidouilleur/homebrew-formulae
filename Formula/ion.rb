# coding: utf-8
class Ion < Formula
  desc     "The Ion Shell. Compatible with Redox and Linux."
  homepage "https://gitlab.redox-os.org/redox-os/ion"


  head do
    url "https://gitlab.redox-os.org/redox-os/ion.git"

    depends_on "rust" => :build
  end



  def install
    system "rust build --release"

    bin.install "target/release/ion"
  end
end
