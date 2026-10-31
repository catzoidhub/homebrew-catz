cask "devcatz" do
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "1.0.1"
  sha256 arm:   "3df65a98837a9680be45bb0efd233d198c67ff778d3f534bdfed08ebb5e3e948",
         intel: "b4ae16cf248a66de2468ba163b99642d70cc6693c135e98f2fdb1ee7802a7a63"

  url "https://github.com/catzoidhub/DevCatz/releases/download/v#{version}/DevCatz-#{version}-#{arch}.dmg"
  name "DevCatz"
  desc "Local development environment for sites, runtimes and databases"
  homepage "https://catzoid.com/devcatz"

  livecheck do
    url :url
    strategy :github_latest
  end

  # the app updates itself (Check for Updates under Settings → About)
  auto_updates true
  depends_on macos: :ventura

  app "DevCatz.app"

  uninstall quit: "com.mrcatz.devcatz"

  # exactly what DevCatz → Settings → Uninstall DevCatz removes from ~/Library (Catzoid TODO #55)
  zap trash: [
    "~/Library/Application Support/DevCatz",
    "~/Library/Caches/DevCatz",
    "~/Library/Caches/com.mrcatz.devcatz",
    "~/Library/Caches/com.mrcatz.devcatz.ShipIt",
    "~/Library/Logs/DevCatz",
    "~/Library/Preferences/com.mrcatz.devcatz.plist",
    "~/Library/Saved Application State/com.mrcatz.devcatz.savedState",
  ]
  caveats <<~EOS
    DevCatz also changes things outside your home folder: the clean-URL services,
    its /etc/resolver entries and a local certificate authority in your keychain.
    Before `brew uninstall`, remove them with DevCatz → Settings → Uninstall DevCatz.
  EOS
end
