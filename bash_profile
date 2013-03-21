# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi
# ---- language-env DON'T MODIFY THIS LINE!
# .bash_profile �ϡ���������˼¹Ԥ���롣
if [ -f ~/.bashrc ]
then
  # �����������Ǥ� .bash_profile �� .bashrc ��¹Ԥ��Ƥ����顢
  # ʣ�Ť��Ƥϼ¹Ԥ��ʤ���
  if [ -z "$BASHRC_DONE" ]
  then
    . ~/.bashrc
  fi
fi
# ---- language-env end DON'T MODIFY THIS LINE!

