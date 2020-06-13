tch OUT!!! Watch OUT!!! Watch OUT!!!

chown or chmod is NOT the solution, because of security-risk.

Instead do this, do:

First check, where npm point to, if you call:

```python
npm config get prefix

If /usr is returned, you can do the following:

```python
mkdir ~/.npm-global
```python
export NPM_CONFIG_PREFIX=~/.npm-global
```python
export PATH=$PATH:~/.npm-global/bin

This create a npm-Directory in your Home-Directory and point npm to it.

To got this changes permanent, you have to add the export-command to your .bashrc:

```python
echo -e "export NPM_CONFIG_PREFIX=~/.npm-global\nexport PATH=\$PATH:~/.npm-global/bin" >> ~/.bashrc


