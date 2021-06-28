class Cbz2pdf < Formula
  desc     "[cbz|cbr] converter to pdf"
  homepage "https://github.com/lebidouilleur/cbz2pdf"



  stable do
    url     "https://github.com/lebidouilleur/cbz2pdf/archive/refs/tags/0.1.tar.gz"
    sha256  "55f95e0738d534974cf89163470867d8c7df2291c77d4ade6e28e43811e51979"
    version "0.1"

    depends_on "unrar" => :recommended
  end



  head do
    url "https://github.com/lebidouilleur/cbz2pdf"

    depends_on "unrar" => :recommended
  end



  def install
    libexec.install Dir["*"]
    bin.write_exec_script (libexec/"cbz2pdf")
  end
end
