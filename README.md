# Ajayu

Ajayu in Aymara means "soul". This repository containts examples of templates to build different images using [Packer](https://packer.io/). 

# Before using Ajayu

Before trying to clone Ajayu, please be sure you have installed the following:

- Go
- Packer

A refernece for how to install Go and packer can be found in [here](https://percyperezdante.github.io/tools/installation/) 

# How to build images

For example, lets take the case of oracle_linux_6.

```bash
$ packer build oracle_linux_6_10.json
```

This should generate a packer_cache and and oracle-linux-6-x86_64_packer-6.10-SNAPSHOT.box, as below. 

```bash
drwxr-xr-x 2 percy percy       4096 Mar 17 16:13 scripts
drwxr-xr-x 2 percy percy       4096 Mar 17 16:13 http
drwxrwxr-x 3 percy percy       4096 Mar 17 16:14 packer_cache
-rw-r--r-- 1 percy percy       1725 Mar 17 16:18 oracle_linux_6_10.json
-rw-rw-r-- 1 percy percy         38 Mar 17 16:23 README.md
-rw-rw-r-- 1 percy percy 1154884632 Mar 17 16:41 oracle-linux-6-x86_64_packer-6.10-SNAPSHOT.box
```

The .box is the image we are going to use with Vagrant for this example.

# How to use built images.

Talking the example of oracle_linux_6, you can add this box to your list using Vagrant

```bash
$ vagrant box add --name MY_OL6 oracle-linux-6-x86_64_packer-6.10-SNAPSHOT.box
$ vagrant box list
```

Now we create a Vagrant file with this image name

```bash
$ mkdir test
$ cd test
$ vagrant init MY_OL6
$ vagrant up
$ vagrant ssh
```




