# Theme based on Bira theme from oh-my-zsh: https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/bira.zsh-theme
# Some code stolen from oh-my-fish clearance theme: https://github.com/bpinto/oh-my-fish/blob/master/themes/clearance/

function __user_host
  # only show host name if we're SSH
  if test -n "$SSH_CONNECTION"

    # warn if sudo
    if [ (id -u) = "0" ];
      echo -n (set_color --bold red) $USER@
    else
      echo -n (set_color --bold green)
    end
    
    echo -n (hostname|cut -d . -f 1) (set_color normal)
  end
end

function __current_path
  echo -n (set_color --bold blue)(string replace $HOME '~' (pwd))(set_color normal)
end

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function __git_status
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)

    if [ (_git_is_dirty) ]
      set git_info '<'$git_branch"*"'>'
    else
      set git_info '<'$git_branch'>'
    end

    echo -n (set_color yellow) $git_info (set_color normal) 
  end
end

function __ruby_version
  # requires rbenv
  if type "rbenv" > /dev/null 2>&1
    set ruby_version (rbenv version-name)
    set ruby_global_version (rbenv global)
    
    if [ $ruby_version != $ruby_global_version ] 
      echo -n (set_color red) ‹$ruby_version› (set_color normal)
    end
  end
end

function fish_prompt
  __user_host
  __current_path
  __ruby_version
  __git_status
  echo -e ''
  echo (set_color --bold white)"\$ "(set_color normal)
end

function fish_right_prompt
  # no-op
end
