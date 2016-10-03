// user.js

// privacy
user_pref("browser.privatebrowsing.autostart", true);
user_pref("browser.search.suggest.enabled", false); // works only with built-in search
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("extensions.pocket.enabled", false);
user_pref("media.peerconnection.enabled", false); // webrtc
user_pref("network.cookie.cookieBehavior", 3); // "only from visited"
user_pref("privacy.donottrackheader.enabled", true);

// usability
user_pref("accessibility.blockautorefresh", true);
user_pref("browser.download.useDownloadDir", false); // ff doesn't respect XDG
user_pref("browser.newtabpage.enhanced", false); // not useful w/ CTR
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("font.name.serif.x-western", "sans-serif");
user_pref("general.warnOnAboutConfig", false); // I'll be careful; I promise!
user_pref("middlemouse.contentLoadURL", false); // X11 PRIMARY Selection
user_pref("reader.parse-on-load.enabled", false);