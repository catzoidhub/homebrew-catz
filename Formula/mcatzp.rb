class Mcatzp < Formula
  # MCatzP is not released yet (2026-10-26): this formula waits for its first release. It is a command-line MCP
  # server, so a formula (not a cask). Drafted for the TypeScript / npm route (MCatzP TODO #1); if MCatzP becomes a Go
  # binary instead, switch to the release tarballs on catzoidhub/MCatzP (`depends_on "go" => :build`, `go build`).
  desc "MCP server that lets AI assistants use the Catzoid apps"
  homepage "https://catzoid.com/roadmap"
  # filled in by scripts/bump.sh from the npm registry
  url "https://registry.npmjs.org/mcatzp/-/mcatzp-0.1.0.tgz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "Apache-2.0"

  livecheck do
    url "https://registry.npmjs.org/mcatzp/latest"
    regex(/"version"\s*:\s*"([^"]+)"/i)
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  def caveats
    <<~EOS
      Add MCatzP to your AI assistant, e.g. Claude Code:
        claude mcp add mcatzp -- #{opt_bin}/mcatzp
      Then switch it on per app: Settings → AI → MCatzP in DevCatz, DBCatz or DialCatz.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/mcatzp --version")
  end
end
