![samba](https://github.com/zekiahmetbayar/zekiahmetbayar.github.io/blob/master/images/samba.png)

# Samba Compiler

As it is known, the Samba package in the GNU&Linux repositories does not contain the domain controller role.

If you want to configure samba as a domain controller, you have to recompile Samba from the source code with various instructions found in Samba Wiki.

This causes instructions to be re-executed in each version (every 6 months). In addition, package dependencies that change in each version can cause Samba to not work properly.

For these reasons, we designed the Samba Compiler Actions structure.

## Usage

This repo currently pushes its releases by default at [Samba Debian Package Generator](https://github.org/aciklab/samba). If you do not want to send the releases to another repository, please clean the following files first.
    - Dockerfile
    - actions.yml
    - entrypoint.sh
    - .github/workflows/generate.yml 's 'Pushes to another repository' block

If you want to publish your releases elsewhere, change the values ​​in the .github/workflows/generate.yml 's 'Pushes to another repository' block according to you.

After all, if you want to compile a new version, write the version you want in the build/version file and place the necessary packages from Samba Wiki in the file of the required distribution under Dockerfiles/distribution.

If you want to compile a new version on a completely new distribution, please create a Dockerfile according to the following Dockerfile naming standard. Then update the variables in build/version according to your distribution and samba version.

If you only want to download the source code, you can download any of the releases at [this link](https://github.com/aciklab/samba_source/releases)!

Finally, if you need a package that creates or migrates a samba domain, please have a look [here](https://github.com/aciklab/samba)!


## Dockerfile Naming Standard

```bash
source build/version
dockerfile="$os_name-$os_version-$samba_version.dockerfile"
```
##### Current Samba Version : 4.15.4 (Latest)
