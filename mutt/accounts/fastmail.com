mailboxes  imaps://imap.fastmail.com

alternates "@(0x16.de|konradtegtmeier.com)"
unalternates "rss@0x16.de"

set my_fastmail_user = jktr@fastmail.com
set my_fastmail_secret = `pass fastmail.com|head -n1`

account-hook imaps://imap.fastmail.com "\
  set imap_authenticators = login \
      imap_user           = $my_fastmail_user \
      imap_pass           = $my_fastmail_secret \
  "

folder-hook imaps://imap.fastmail.com "\
  set folder      = imaps://imap.fastmail.com \
      spoolfile   = +INBOX \
      postponed   = +Drafts \
      record      = +Sent \
      trash       = +Trash \
      from        = jktr@0x16.de \
      realname    = 'Konrad Tegtmeier' \
      smtp_url            = smtps://$my_fastmail_user@smtp.fastmail.com \
      smtp_authenticators = login \
      smtp_pass           = $my_fastmail_secret \
  "

