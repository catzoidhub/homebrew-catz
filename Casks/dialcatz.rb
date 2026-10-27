cask "dialcatz" do
  arch arm: "arm64", intel: "x64"

  # filled in by scripts/bump.sh from the release on GitHub (Apple silicon and Intel DMGs)
  version "1.0.0"
  sha256 arm:   "181eb4c683a5989b7363d610e402ec77fb7b94cd07341f5ab1e531ccec6de353",
         intel: "a586ef690e9ccef9ef752c246b8ef17dd2e411534191ea8848e54ac8633d98db"

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
