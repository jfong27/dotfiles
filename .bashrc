EDITOR=vim

export HISTCONTROL=ignoredups

umask 077

shopt -s checkwinsize

[ -f /etc/bash_completion ] && . /etc/bash_completion

if [ -x /usr/bin/dircolors ]; then
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
   alias ls='ls --color=auto'
   alias dir='dir --color=auto'
   alias vdir='vdir --color=auto'

   alias grep='grep --color=auto'
   alias fgrep='fgrep --color=auto'
   alias egrep='egrep --color=auto'
fi

export PS1="\[\e[36;92m\]\`parse_git_branch\`\[\e[m\]\[\e[36m\]\u\[\e[m\]@\[\e[36m\]\h\[\e[m\]:\[\e[95m\]\w\[\e[m\] \[\e[92m\]∂\[\e[m\] "

LS_COLORS=$LS_COLORS:'di=0;35:' 
export LS_COLORS

function parse_git_branch() {
   BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
   if [ ! "${BRANCH}" == "" ]
   then
      STAT=`parse_git_dirty`
     echo "[${BRANCH}]"
   else
    echo ""
   fi
}

# get current status of git repo
function parse_git_dirty {
   status=`git status 2>&1 | tee`
   dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
   untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
   ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
   newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
   renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
   deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
   bits=''
   if [ "${renamed}" == "0" ]; then
      bits=">${bits}"
   fi
   if [ "${ahead}" == "0" ]; then
      bits="*${bits}"
   fi
   if [ "${newfile}" == "0" ]; then
      bits="+${bits}"
   fi
   if [ "${untracked}" == "0" ]; then
      bits="?${bits}"
   fi
   if [ "${deleted}" == "0" ]; then
      bits="x${bits}"
   fi
   if [ "${dirty}" == "0" ]; then
      bits="!${bits}"
   fi
   if [ ! "${bits}" == "" ]; then
      echo " ${bits}"
   else
      echo ""
   fi
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
