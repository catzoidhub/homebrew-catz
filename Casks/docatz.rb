cask "docatz" do
  # DoCatz 1.0.0 is its first release (2026-11-03). Its zap list follows DoCatz TODO #33 (what Uninstall DoCatz
  # removes).
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "1.2.3"
  sha256 arm:   "61b7b587f7fdf3bdb6d207c8b962c6aa40ac0f5c4bf81a2f5eee4926cbbcfdce",
         intel: "a0f7c5c6301382283b0f85594cec8f7eccef1b70376516fc86dc90c337d6fd02"

  # through catzoid.com's counted redirect (Catzoid admin → Downloads → Homebrew): it answers with a 302 to this
  # version's DMG on the GitHub release, and Homebrew checks the sha256 above on what it gets
  url "https://catzoid.com/download/docatz/mac-#{arch}?v=#{version}"
  name "DoCatz"
  desc "Light container engine and desktop with a Linux VM"
  homepage "https://catzoid.com/docatz"

  livecheck do
    url "https://github.com/catzoidhub/DoCatz"
    strategy :github_latest
  end

  # the app updates itself (Check for Updates under Settings → About)
  auto_updates true
  depends_on macos: :ventura

  app "DoCatz.app"

  uninstall quit: "com.mrcatz.docatz"

  # what DoCatz → Settings → Uninstall DoCatz removes from your home folder (DoCatz TODO #33); the VM disk image
  # lives in ~/.docatz/vm, bind-mounted project folders are never touched
  zap trash: [
    "~/.docatz",
    "~/Library/Application Support/DoCatz",
    "~/Library/Caches/com.mrcatz.docatz",
    "~/Library/Caches/com.mrcatz.docatz.ShipIt",
    "~/Library/Caches/docatz-updater",
    "~/Library/Logs/DoCatz",
    "~/Library/Preferences/com.mrcatz.docatz.plist",
    "~/Library/Saved Application State/com.mrcatz.docatz.savedState",
  ]

  caveats <<~EOS
    DoCatz runs your containers in a small Linux VM and may add a docker context and
    *.docatz.localhost names. Before `brew uninstall`, stop and remove them with
    DoCatz → Settings → Uninstall DoCatz.
  EOS
end
