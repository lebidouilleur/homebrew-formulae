class Cbz2pdf < Formula
  desc     "[cbz|cbr] converter to pdf"
  homepage "https://github.com/lebidouilleur/cbz2pdf"



  stable do
    url     "https://github.com/lebidouilleur/cbz2pdf/archive/refs/tags/v1.0.0.tar.gz"
    sha256  "fba4f9dadad4a6532c6ff78ecd43bdaca17cb4d8feface6fd157e41400841151"
    version "1.0.0"

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
