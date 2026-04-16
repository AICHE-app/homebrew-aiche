cask "aiche-desktop" do
  version "1.2.2"

  # Architecture-specific downloads
  on_arm do
    sha256 "515ee5c92ce3e120beb8ab65a33b873fd0b3402cce89ee5b9cd384f586dfed8f"
    url "https://github.com/AICHE-app/mac-releases/releases/download/v#{version}/AICHE-Installer-#{version}-ARM64.dmg",
        verified: "github.com/AICHE-app/mac-releases/"
  end

  on_intel do
    sha256 "38c51a08ba87fdd93e2f876ed4b929aa027701df375b7544f713eb597857e524"
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
