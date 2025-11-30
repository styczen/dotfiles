Working with X11 and Ubuntu

Before cloning install git and git lfs:
```bash
sudo apt-get install -y \
    git

GIT_LFS_VERSION=3.5.1

wget -q https://github.com/git-lfs/git-lfs/releases/download/v$GIT_LFS_VERSION/git-lfs-linux-amd64-v$GIT_LFS_VERSION.tar.gz
tar -xf git-lfs-linux-amd64-v$GIT_LFS_VERSION.tar.gz
sudo ./git-lfs-$GIT_LFS_VERSION/install.sh
rm -rf git-lfs-$GIT_LFS_VERSION git-lfs-linux-amd64-v$GIT_LFS_VERSION.tar.gz
```