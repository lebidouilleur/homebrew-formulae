# coding: utf-8
class Ion < Formula
  desc     "The Ion Shell. Compatible with Redox and Linux."
  homepage "https://gitlab.redox-os.org/redox-os/ion"


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
        echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells
        chsh -s /usr/local/bin/ion $USER
    EOS
  end

end
