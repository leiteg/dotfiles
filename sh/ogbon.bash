# .bashrc

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Execute an arbitrary command with Slurm
slurm() {
    srun -p GPUlongB -A cenpes-unicamp $@
}

# Execute an arbitrary command with Awave container
awave() {
    singularity exec --nv $HOME/awave.sif $@
}

parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Force colors
force_color_prompt=yes
#PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='\e[01;34m\w\e[1;32m $(parse_git_branch)\e[00m\$ '

if [[ ! -z $VIMRUNTIME ]]; then
    PS1="\e[1;31m○\e[0m $PS1"
fi

alias make="make --no-print-directory"

export PATH=$HOME/.programs/bin:$PATH
export LD_LIBRARY_PATH=$HOME/.programs/lib:$HOME/.programs/lib64:$LD_LIBRARY_PATH
export CPATH=$HOME/.programs/include:$CPATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/gustavo.leite/.local/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/gustavo.leite/.local/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/gustavo.leite/.local/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/gustavo.leite/.local/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
