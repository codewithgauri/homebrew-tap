cask "sidekik" do
  version "0.1.1"
  sha256 "3cbd2d4fe3ce0e7a93f6bc1040454417802305755c2e0325467f1ec67ae97b4f"

  url "https://codeymon.com/download/sidekik/files/Sidekik-#{version}-mac.zip"
  name "Sidekik"
  desc "Use an Android tablet as a second screen, over USB or Wi-Fi"
  homepage "https://codeymon.com/download/sidekik/"

  depends_on macos: ">= :sonoma"

  app "Sidekik.app"

  # Sidekik is signed but not yet notarized; clear the download flag so Gatekeeper does not block it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Sidekik.app"]
  end

  uninstall quit: "com.screenmachine.mac"

  zap trash: [
    "~/Library/Logs/Sidekik.log",
    "~/Library/Preferences/com.screenmachine.mac.plist",
  ]

  caveats <<~EOS
    Sidekik lives in the menu bar. Allow Screen Recording and Accessibility when asked.

    For USB you also need adb. If you don't have it yet:
      brew install --cask android-platform-tools

    Tablet app and guide: https://codeymon.com/download/sidekik/
  EOS
end
