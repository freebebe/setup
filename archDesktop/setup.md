> sysctls --- /etc/sysctl.conf && /etc/sysctl.d

# 限制su
sudoedit `/etc/pam.d/su` | `/etc/pam.d/su-l`

```
auth required pam_wheel.so use.uid
```

# 拒绝通过SSH的远程root登陆
edit `/etc/ssh/sshd_config`

```
PermitRootLogin no
```
# 增加散列回合数
您可以增加shadow使用的哈希回合数，
从而通过迫使攻击者计算更多的哈希值来破解您的密码，
从而提高哈希密码的安全性。
默认情况下，shadow使用5000次回合，
但是您可以将其增加到任意数量。
尽管配置的回合越多，登录速度就越慢。
编辑`/etc/pam.d/passwd`并添加回合选项。
```
password required pam_unix.so sha512 shadow nullok rounds=65536
```
这使shadow执行65536次散列回合。

应用此设置后，密码不会自动重新加密，因此您需要使用以下方法重置密码：
```
passwd $username
```

# 限制Xorg root访问
默认情况下，某些发行版以root用户身份运行Xorg，
这是一个问题，因为Xorg包含大量古老而又复杂的代码，
这增加了巨大的攻击面，并使其更有可能拥有可以获取root特权的漏洞利用程序。
要阻止它作为root用户执行，请编辑/etc/X11/Xwrapper.config并添加：

```
needs_root_rights = no
```
# IPv6隐私扩展
IPv6地址是从计算机的MAC地址生成的，
从而使您的IPv6地址是唯一的，并直接绑定到计算机。
隐私扩展会生成一个随机的IPv6地址，以减轻这种形式的跟踪。
请注意，如果您开启了MAC地址欺骗机制或禁用了IPv6，则无需执行这些步骤。
## NetworkManager
要为NetworkManager启用隐私扩展，请编辑/etc/NetworkManager/NetworkManager.conf并添加：
```
[connection]
ipv6.ip6-privacy=2

```
## systemd-networkd
要为systemd-networkd启用隐私扩展，请创建/etc/systemd/network/ipv6-privacy.conf并添加：
```
[Network]
IPv6PrivacyExtensions=kernel
```
