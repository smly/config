export LOCAL_BIN=$HOME/bin:/usr/local/bin:$HOME/local/bin
# path
PATH=$PATH:$LOCAL_BIN # user bin
PATH=$PATH:$HOME/.cabal/bin          # haskell
PATH=$PATH:/usr/bin/perlbin/vendor   # perl
#PATH=$PATH:$HOME/.gem/ruby/1.8/bin
PATH=$PATH:$HOME/.gem/ruby/1.9.1/bin # ruby
PATH=$PATH:$JAVA_HOME/bin            # java
PATH=$PATH:/usr/local/texlive/p2008/bin/i686-pc-linux-gnu  # texlive
export PATH

# go
export GOROOT=$HOME/go
export GOARCH=386
export GOOS=linux
export GOBIN=$LOCAL_BIN

#export HADOOP=$HOME/intern/hatenaintern2/smly/hadoop-0.18.0
#export TEXINPUTS=$HOME/.tex.d/
export CLASSPATH=$CLASSPATH:/home/smly/gitws/naist-exercises/dicision_tree/weka-3-6-1/weka.jar
export MANPATH=$MANPATH:$HOME/man:/usr/local/texlive/2008/texmf/doc/man

export LIBDIR=/home/kohei-o/local/lib
export INCLUDE_PATH=/home/kohei-o/local/include
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/pgsql/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:$LIBDIR
