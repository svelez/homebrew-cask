cask "evernote" do
  on_el_capitan :or_older do
    version "7.2.3_456885"
    sha256 "eb9a92d57ceb54570c009e37fa7657a0fa3ab927a445eef382487a3fdde6bb97"

    url "https://cdn1.evernote.com/mac-smd/public/Evernote_RELEASE_#{version}.dmg"

    livecheck do
      skip "Legacy version"
    end
  end
  on_sierra do
    version "7.14_458244"
    sha256 "1049a40b8497c0e37d7fed8828552dba89fa52c826134e05b0d56e431e5033ad"

    url "https://cdn1.evernote.com/mac-smd/public/Evernote_RELEASE_#{version}.dmg"

    livecheck do
      skip "Legacy version"
    end
  end
  on_high_sierra do
    version "7.14_458244"
    sha256 "1049a40b8497c0e37d7fed8828552dba89fa52c826134e05b0d56e431e5033ad"

    url "https://cdn1.evernote.com/mac-smd/public/Evernote_RELEASE_#{version}.dmg"

    livecheck do
      skip "Legacy version"
    end
  end
  on_mojave :or_newer do
    version "10.64.4,20231024105232,c3d2aae3f25298b412bbe37f45b546c6d0f1131d"
    sha256 "0bd34cabab0c470a986cee80106155f67491283ce20547e909fc23648043b692"

    url "https://cdn1.evernote.com/boron/mac/builds/Evernote-#{version.csv.first}-mac-ddl-stage-#{version.csv.second}-#{version.csv.third}.dmg"

    livecheck do
      url "https://evernote.s3.amazonaws.com/boron/mac/public/latest-mac.yml"
      regex(/Evernote[._-](\d+(?:\.\d+)+)-mac-ddl-stage-(\d+(?:\.\d+)*)-([0-9a-f]+)\.dmg/i)
      strategy :electron_builder do |yaml, regex|
        yaml["files"]&.map do |file|
          match = file["url"]&.match(regex)
          next if match.blank?

          "#{match[1]},#{match[2]},#{match[3]}"
        end
      end
    end
  end

  name "Evernote"
  desc "App for note taking, organizing, task lists, and archiving"
  homepage "https://evernote.com/"

  auto_updates true

  app "Evernote.app"

  uninstall quit: [
    "com.evernote.Evernote",
    "com.evernote.EvernoteHelper",
  ]

  zap trash: [
    "~/Library/Application Support/Caches/evernote-client-updater",
    "~/Library/Application Support/com.evernote.Evernote",
    "~/Library/Application Support/com.evernote.EvernoteHelper",
    "~/Library/Application Support/Evernote",
    "~/Library/Caches/com.evernote.Evernote",
    "~/Library/Cookies/com.evernote.Evernote.binarycookies",
    "~/Library/Logs/Evernote",
    "~/Library/Preferences/com.evernote.Evernote.plist",
    "~/Library/Preferences/com.evernote.EvernoteHelper.plist",
    "~/Library/Saved Application State/com.evernote.Evernote.savedState",
  ]
end
