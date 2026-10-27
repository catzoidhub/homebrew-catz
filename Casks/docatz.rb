cask "docatz" do
  # DoCatz is not released yet (2026-10-26): this cask waits for its first public release on catzoidhub/DoCatz.
  # Its zap list follows DoCatz TODO #33 (what Uninstall DoCatz removes) — check it against the real app before
  # the first push.
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "0.1.0"
  sha256 arm:   "0000000000000000000000000000000000000000000000000000000000000000",
         intel: "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/catzoidhub/DoCatz/releases/download/v#{version}/DoCatz-#{version}-#{arch}.dmg"
  name "DoCatz"
  desc "Light container engine and desktop with a Linux VM"
  homepage "https://catzoid.com/docatz"

  livecheck do
    url :url
    strategy :github_latest
  end

  # the app updates itself (Check for Updates under Settings → About)
  auto_updates true
  depends_on macos: :ventura

  app "DoCatz.app"

  uninstall quit: "com.mrcatz.docatz"

  # what DoCatz → Settings → Uninstall DoCatz removes from your home folder (DoCatz TODO #33); the VM disk image
  # lives in its data folder, bind-mounted project folders are never touched
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
