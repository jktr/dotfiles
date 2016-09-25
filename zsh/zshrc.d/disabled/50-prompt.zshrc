### prompt.zshrc

setopt prompt_subst
setprompt () {

  # expansion seqs
  e_usr='%n'
  e_usrsym='%#'
  e_host='%M'
  e_pwd='%~'
  e_multiline_desc='%_'

  # color aliases
  for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$fg[${(L)color}]%}'
  done

  # color conf
  c_reset="%{$reset_color%}"
  c_delim="${PR_BLUE}"
  c_pwd="${PR_GREEN}"
  c_uid_root="${PR_RED}"
  c_uid_sys="${PR_YELLOW}"
  c_uid_usr="${PR_GREEN}"
  c_host_local="${PR_GREEN}"
  c_host_remote="${PR_YELLOW}"
  c_nzexit="${PR_MAGENTA}"

  # user part, with selective color
  if [[ $UID -eq 0 ]]; then
    c_pr_usr="${c_uid_root}"
    c_pr_usr_sym="${c_uid_root}"
  elif [[ $UID -lt 1000 ]]; then
    c_pr_usr="${c_uid_sys}"
    c_pr_usr_sym="${c_uid_sys}"
  else
    c_pr_usr="${c_uid_usr}"
    c_pr_usr_sym="${c_uid_usr}"
  fi

  # host part, with selective color
  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    c_pr_host="${c_host_remote}"
  else
    c_pr_host="${c_host_local}"
  fi
    
  # actually set prompt
  PS1=$'${c_delim}[${c_pr_usr}${e_usr}${c_delim}@${c_pr_host}${e_host}${c_delim}|${c_pwd}${e_pwd}${c_d
elim}]${c_pr_usr}${e_usrsym}${c_reset} '
  PS2=$'${e_multiline_desc}>'
  RPROMPT=$'%(?..${c_nzexit}[${c_reset}%?${c_nzexit}]${c_reset})'
}
setprompt

