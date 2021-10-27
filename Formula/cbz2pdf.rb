class Cbz2pdf < Formula
  desc     "[cbz|cbr] converter to pdf"
  homepage "https://github.com/lebidouilleur/cbz2pdf"



  stable do
    url     "https://github.com/lebidouilleur/cbz2pdf/archive/refs/tags/v1.0.0.tar.gz"
    sha256  "631c1728cfbebed80d181961a853de8bd89afe2e67e6b6e1cbc5b67dda6d2abb"
    version "1.0.0"

    depends_on "libarchive" => :recommended
  end



  head do
    url "https://github.com/lebidouilleur/cbz2pdf"

    depends_on "libarchive" => :recommended
  end



  def install
    libexec.install Dir["*"]
    bin.write_exec_script (libexec/"cbz2pdf")
  end
end
