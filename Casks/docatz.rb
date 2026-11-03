cask "docatz" do
  # DoCatz 1.0.0 is its first release (2026-11-03). Its zap list follows DoCatz TODO #33 (what Uninstall DoCatz
  # removes).
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "1.0.1"
  sha256 arm:   "a6ff6a90dd067bf1533f30a0bb3ff7a4c23d92c8cebc2c79dc91eeca671c9a92",
         intel: "bdcd6e4ffba3ebf743c4ddb8a29d4fe90f0769c9c0a6c24cd4d8dbe02a27fac8"

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
