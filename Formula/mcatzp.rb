class Mcatzp < Formula
  # A command-line MCP server, so a formula, not a cask: the signed, notarized binary for this Mac, no Node needed. It
  # downloads through catzoid.com's counted redirect like the casks (Catzoid #86, #87); scripts/bump.sh fills in the
  # version and sums.
  desc "MCP server that lets AI assistants use the Catzoid apps"
  homepage "https://catzoid.com/mcatzp"
  version "1.0.3"
  license "Apache-2.0"

  on_arm do
    url "https://catzoid.com/download/mcatzp/mac-arm64?v=#{version}"
    sha256 "1a0b4dfed9129ca26244d397b31a8388dc286c3c71183385f2f3c756ca71709c"
  end
  on_intel do
    url "https://catzoid.com/download/mcatzp/mac-x64?v=#{version}"
    sha256 "0602e2436b2087b11c84ea44903fbeb4f26194a850a0772a7fb5e64e4d4efefe"
  end

  livecheck do
    url "https://github.com/catzoidhub/MCatzP"
    strategy :github_latest
  end

  depends_on :macos

  def install
    bin.install "mcatzp"
  end

  def caveats
    <<~EOS
      Add MCatzP to your AI assistant, e.g. Claude Code:
        claude mcp add mcatzp -- #{opt_bin}/mcatzp
      Then switch it on per app: Settings → MCatzP in DevCatz, DBCatz, DialCatz or DoCatz.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mcatzp --version").strip
  end
end
