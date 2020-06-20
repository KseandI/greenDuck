function fish_prompt
  set -l last_status $status
  
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end
  if not set -q __fish_prompt_char
    switch (id -u)
      case 0
        set -g __fish_prompt_char '#'
      case '*'
        set -g __fish_prompt_char '>'
    end
  end

  # Setup colors
  set -l normal (set_color normal)
  set -l red (set_color red)
  set -l cyan (set_color cyan)
  set -l white (set_color white)
  set -l gray (set_color normal)
  set -l brwhite (set_color -o white)
  set -l green (set_color -o green)
  set -l blue (set_color -o blue)

  # Configure __fish_git_prompt
  set -g __fish_git_prompt_showdirtystate true
  set -g __fish_git_prompt_showuntrackedfiles true
  set -g __fish_git_prompt_showstashstate true
  set -g __fish_git_prompt_color green
  set -g __fish_git_prompt_color_flags red

  # Color prompt char red for non-zero exit status
  set -l pcolor $gray
  if test $last_status -ne 0
    set pcolor $red
  end

  # Line 1
  echo -n $red'┌'$green$USER$white'@'$green$__fish_prompt_hostname $blue\((prompt_pwd)\)$normal
  __fish_git_prompt
  echo

  # Line 2
  echo -n $red'└'$pcolor$__fish_prompt_char $normal
end
