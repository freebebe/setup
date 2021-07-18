# brower
-   firejail --seccomp --nonewprivs --private-tmp firefox
  -   --net=none            => no network 初始化网络空间
  -                         => A network namespace initialized with –net is necessary in order to disable the abstract X11 socket. If for any reasons you cannot use a network namespace, the socket will still be visible inside the sandbox, and hackers can attach keylogger and screenshot programs to this socket.
  -                         => 黑客可以將鍵盤記錄程序和屏幕截圖程序附加到此套接字。
-   firejail --x11 --net=eth0 firefox 
  -                         =Firejail replaces the regular X11 server with Xpra or Xephyr servers (apt-get install xpra xserver-xephyr on Debian/Ubuntu), preventing X11 keyboard loggers and screenshot utilities from accessing the main X11 server.
-   firejail --private --dns=1.1.1.1 --dns=9.9.9.9 firefox -no-remote
  -                         => Use this setup to access your bank account, or any other site dealing with highly sensitive private information. The idea is you trust the site, but you don’t trust the addons and plugins installed in your browser. Use –private Firejail option to start with a factory default browser configuration, and an empty home directory.
  -                         => Also, you would need to take care of your DNS setting – current home routers are ridiculously insecure, and the easiest attack is to reconfigure DNS, and redirect the traffic to a fake bank website. Use –dns Firejail option to specify a DNS configuration for your sandbox:

