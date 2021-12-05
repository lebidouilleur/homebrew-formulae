# coding: utf-8
class Ion < Formula
  desc     "The Ion Shell. Compatible with Redox and Linux."
  homepage "https://gitlab.redox-os.org/redox-os/ion"



  stable do
    url "https://gitlab.redox-os.org/redox-os/ion/-/archive/1.0.5/ion-1.0.5.tar.gz"
    sha256 "7c7f696060a82669cb9c73cf0ec1d07d4ffefbfd54fc60acad0179ca3f46716d"

    depends_on "rust" => :build
  end


  head do
    url "https://gitlab.redox-os.org/redox-os/ion.git"

    depends_on "rust" => :build
  end



  def install
    system "cargo", "install", *std_cargo_args
  end



  def caveats
    <<-EOS
      Redox's Ion was installed to:
          #{prefix}

      To make Redox's Ion your default shell:
        echo '/usr/local/bin/ion' | sudo tee -a /etc/shells
        chsh -s /usr/local/bin/ion $USER
    EOS
  end
end
