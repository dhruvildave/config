# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
# export JAVA_HOME="/usr/java/jdk-11.0.2"
# export JDK_HOME="/usr/java/jdk-11.0.2"
# export JRE_HOME="/usr/java/jdk-11.0.2"
# export PATH="$PATH:$JAVA_HOME/bin:$JRE_HOME/bin"

# Tomcat
export CATALINA_HOME="/mnt/4427FDEE206BF5AE/Downloads/apache-tomcat-9.0.16"

# CUDA
export PATH=/usr/local/cuda-10.1/bin:/usr/local/cuda-10.1/NsightCompute-2019.1${PATH:+:${PATH}}


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Alias definitions
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# Add respect command
source ~/.respect.sh
