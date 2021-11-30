// user.js

//webcam
user_pref("media.navigator.video.h264.max_mbps", 1);
user_pref("media.navigator.video.max_fr", 30);
user_pref("media.navigator.video.default_height", 640);
user_pref("media.navigator.video.default_width", 480);

// experimental features
user_pref("network.dns.echconfig.enabled", true); // encrypted client hello
user_pref("network.dns.use_https_rr_as_altsvc", true); // encrypted client hello
user_pref("image.avif.enabled", true);
//user_pref("widget.use-xdg-desktop-portal", true);

// privacy
user_pref("browser.privatebrowsing.autostart", true);
user_pref("browser.search.suggest.enabled", false); // works only with built-in search
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("extensions.pocket.enabled", false);
//user_pref("media.peerconnection.enabled", false); // webrtc
user_pref("network.cookie.cookieBehavior", 3); // "only from visited"
user_pref("privacy.donottrackheader.enabled", true);
user_pref("browser.firstparty.isolate", true); // cookie containers

// usability
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("accessibility.blockautorefresh", true);
user_pref("browser.download.useDownloadDir", false); // ff doesn't respect XDG
user_pref("browser.newtabpage.enhanced", false); // not useful w/ CTR
user_pref("browser.urlbar.suggest.history", false);
user_pref("browser.urlbar.suggest.openpage", false);
user_pref("browser.aboutConfig.showWarning", false); // I'll be careful; I promise!
user_pref("middlemouse.contentLoadURL", false); // Wayland/X11 primary selection
user_pref("reader.parse-on-load.enabled", false);
user_pref("toolkit.cosmeticAnimations.enabled", false);

// theming
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("ui.prefersReducedMotion", 1); // only way to control fullscreen animation?
user_pref("ui.systemUsesDarkTheme", 1);
user_pref("browser.uidensity", 1); // compact

