mailboxes imaps://imap.gmail.com

alternates 'konrad.tegtmeier@gmail.com'
set my_gmail_secret = `pass imap.gmail.com|head -n1`

account-hook imaps://imap.gmail.com "\
  set imap_authenticators = login \
      imap_user           = konrad.tegtmeier@gmail.com \
      imap_pass           = $my_gmail_secret \
  "

folder-hook imaps://imap.gmail.com "\
  set folder      = imaps://imap.gmail.com \
      spoolfile   = +INBOX \
      postponed   = +[Gmail]/Drafts \
      record      = +[Gmail]/'Sent Mail' \
      trash       = +[Gmail]/'Trash' \
      from        = konrad.tegtmeier@gmail.com \
      realname    = 'J. Konrad Tegtmeier-Rottach' \
      smtp_url            = smtps://konrad.tegtmeier@smtp.gmail.com \
      smtp_authenticators = login \
      smtp_pass           = $my_gmail_secret \
  "
