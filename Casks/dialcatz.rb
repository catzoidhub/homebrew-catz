cask "dialcatz" do
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "1.0.2"
  sha256 arm:   "ebf21999c823cadd8c9279f711918af8f814d745e7afd5589dc37bdb2a5211f9",
         intel: "cf1833efc48b999d9923cbc88f9276b927e5179cce38acf9c8d9752cad39cf09"

  url "https://github.com/catzoidhub/DialCatz/releases/download/v#{version}/DialCatz-#{version}-#{arch}.dmg"
  name "DialCatz"
  desc "API client for REST, GraphQL and WebSocket requests"
  homepage "https://catzoid.com/dialcatz"

  livecheck do
    url :url
    strategy :github_latest
  end

  # the app updates itself (Check for Updates under Settings → About)
  auto_updates true
  depends_on macos: :ventura

  app "DialCatz.app"

  uninstall quit: "com.mrcatz.dialcatz"

  # exactly what DialCatz → Settings → Uninstall DialCatz removes from ~/Library (Catzoid TODO #55)
  zap trash: [
    "~/Library/Application Support/DialCatz",
    "~/Library/Caches/com.mrcatz.dialcatz",
    "~/Library/Caches/com.mrcatz.dialcatz.ShipIt",
    "~/Library/Caches/DialCatz-updater",
    "~/Library/Caches/dialcatz-updater",
    "~/Library/Logs/DialCatz",
    "~/Library/Preferences/com.mrcatz.dialcatz.plist",
    "~/Library/Saved Application State/com.mrcatz.dialcatz.savedState",
  ]
end
