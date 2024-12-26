# Fedora NAS

An opinionated image based on Fedora CoreOS to act as a base for my NAS

## Rebasing 

```bash
rpm-ostree rebase ostree-unverified-registry:ghcr.io/areif-dev/fedora-nas/fedora-nas:latest
```

# WARNING

The security of the image has not been configured to allow the this next section to work properly. It will be functional in the near future, however. 

Reboot the system, then run 

```bash
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/areif-dev/fedora-nas/fedora-nas:latest
```
