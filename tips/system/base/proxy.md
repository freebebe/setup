#zsh
~~~
vim ~/.zshrc
~~~

- setup_quick_keys
~~~
alias proxy='export all_proxy=socks5://127.0.0.1:1080'
alias unproxy='unset all_proxy'
~~~
- 激活
~~~
source ~/.zshrc
~~~

#bash
~~~
vim ~/.bashrc
~~~

- setup_quick_keys
~~~
alias proxy='export all_proxy=socks5://127.0.0.1:1080'
alias unproxy='unset all_proxy'
~~~
- 激活
~~~
source ~/.bashrc
~~~

# this windows get Proxy
## base-proxy(only)
~~~
export http_proxy="socks5://127.0.0.1:1080"
~~~

#command proxy(all)
~~~
export https_proxy="socks5://127.0.0.2:5389"
~~~
