cask "devcatz" do
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "0.1.0"
  sha256 arm:   "0000000000000000000000000000000000000000000000000000000000000000",
         intel: "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/catzoidhub/DevCatz/releases/download/v#{version}/DevCatz-#{version}-#{arch}.dmg",
      verified: "github.com/catzoidhub/DevCatz/"
  name "DevCatz"
  desc "Local development environment for sites, runtimes and databases"
  homepage "https://catzoid.com/devcatz"

  livecheck do
    url :url
    strategy :github_latest
  end

  # the app updates itself (Check for Updates under Settings → About)
  auto_updates true
  depends_on macos: ">= :ventura"

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
