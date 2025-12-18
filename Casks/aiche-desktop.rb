cask "aiche-desktop" do
  version "1.0.17"

  # Architecture-specific downloads
  on_arm do
    sha256 "b7de4774328d1ab5b990ac65f48dfca3b3bcbcc982e68236ebde57ad11c16db9"
    url "https://github.com/AICHE-app/mac-releases/releases/download/v#{version}/AICHE-Installer-#{version}-ARM64.dmg",
        verified: "github.com/AICHE-app/mac-releases/"
  end

  on_intel do
    sha256 "e3d33dfb0b73bd2a683f8752fe645dc5f286a6d19ab3192fbb369806a9e467ce"
    url "https://github.com/AICHE-app/mac-releases/releases/download/v#{version}/AICHE-Installer-#{version}-Intel.dmg",
        verified: "github.com/AICHE-app/mac-releases/"
  end

  name "AICHE Desktop"
  desc "AI-powered audio transcription and enhancement desktop app"
  homepage "https://aiche.app"

  # Auto-update support
  livecheck do
    url :url
    strategy :github_latest
  end

  # Main app
  app "AICHE Desktop.app"

  # Uninstall handler - removes app on upgrade/reinstall
  uninstall delete: "/Applications/AICHE Desktop.app"

  # Cleanup on uninstall
  zap trash: [
    "~/Library/Application Support/AICHE",
    "~/Library/Preferences/app.aiche.desktop.plist",
    "~/Library/Logs/AICHE Desktop",
  ]

  caveats <<~EOS
    AICHE Desktop requires the following permissions:

    1. Microphone access - for audio recording
    2. Accessibility permissions - for global hotkeys

    On first launch, grant these permissions when prompted.
    You can configure hotkeys in the app settings.
  EOS
end
