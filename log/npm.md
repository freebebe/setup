tch OUT!!! Watch OUT!!! Watch OUT!!!

chown or chmod is NOT the solution, because of security-risk.

Instead do this, do:

First check, where npm point to, if you call:

```python
npm config get prefix

If /usr is returned, you can do the following:

mkdir $HOME/.npm-global

export NPM_CONFIG_PREFIX=$HOME/.npm-global

export PATH=$PATH:$HOME/.npm-global/bin

This create a npm-Directory in your Home-Directory and point npm to it.

To got this changes permanent, you have to add the export-command to your .bashrc:

echo -e "export NPM_CONFIG_PREFIX=$HOME/.npm-global\nexport PATH=\$PATH:$HOME/.npm-global/bin" >> $HOME/.bashrc

```

