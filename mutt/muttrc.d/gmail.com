set my_gmail_secret=`openssl enc -d -aes-256-cbc -a -in ~/.gmail.com.secret`

account-hook imaps://imap.gmail.com "\
  set imap_authenticators = login \
      imap_user           = konrad.tegtmeier@gmail.com \
      imap_pass           = $my_gmail_secret"

alternates 'konrad.tegtmeier@gmail.com'

set folder = imaps://imap.gmail.com

  mailboxes = +INBOX
  set spoolfile="+INBOX"

  folder-hook imaps://imap.gmail.com "\
    set folder      = imaps://imap.gmail.com \
        spoolfile   = +INBOX \
        postponed   = +[Gmail]/Drafts \
        record      = +[Gmail]/'Sent Mail' \
        from        = 'konrad.tegtmeier@gmail.com' \
        realname    = 'J. Konrad Tegtmeier-Rottach' \
        smtp_url    = smtps://konrad.tegtmeier@smtp.gmail.com \
        smtp_authenticators = 'login' \
        smtp_pass   = $my_gmail_secret \
        "
