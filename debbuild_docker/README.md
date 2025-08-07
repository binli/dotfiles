Usage
===
docker build --secret id=ubuntu,src=passwd.txt -t deb:24.04 .

```
 => [internal] load build definition from Dockerfile                                                                               0.0s
 => => transferring dockerfile: 940B                                                                                               0.0s
 => [internal] load metadata for docker.io/library/ubuntu:24.04                                                                    1.2s
 => [internal] load .dockerignore                                                                                                  0.0s
 => => transferring context: 2B                                                                                                    0.0s
 => CACHED [stage-0  1/11] FROM docker.io/library/ubuntu:24.04@sha256:a08e551cb33850e4740772b38217fc1796a66da2506d312abe51acda354  0.0s
 => [stage-0  2/11] RUN --mount=type=secret,id=ubuntu     chpasswd < /run/secrets/ubuntu                                           0.2s
 => [stage-0  3/11] RUN mkdir -p /etc/sudoers.d/     && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/ubuntu     && chmo  0.2s
 => [stage-0  4/11] RUN apt-get update                                                                                            34.6s
 => [stage-0  5/11] RUN apt-get -y install devscripts debhelper dh-modaliases vim                                                290.5s
 => [stage-0  6/11] RUN apt-get clean                                                                                              0.2s 
 => [stage-0  7/11] RUN mkdir -p /home/ubuntu/.ssh     && mkdir -p /home/ubuntu/.gnupg     && chmod 700 /home/ubuntu/.ssh     &&   0.2s 
 => [stage-0  8/11] RUN mkdir -p /source     && chown -R ubuntu:ubuntu /source                                                     0.2s 
 => [stage-0  9/11] RUN git config --global user.email "binli@ubuntu.com"                                                          0.3s 
 => [stage-0 10/11] RUN git config --global user.name "Bin Li"                                                                     0.2s 
 => [stage-0 11/11] WORKDIR /source                                                                                                0.1s 
 => exporting to image                                                                                                             2.7s
 => => exporting layers                                                                                                            2.7s
 => => writing image sha256:92700970146c50ebc63ac0735126491bb61995b26e895f4529218524d7e8c4e5                                       0.0s
 => => naming to docker.io/library/deb:24.04
```
docker run -it -v /work/init/ssh:/home/ubuntu/.ssh -v /work/init/gnupg:/home/ubuntu/.gnupg -v /source:/source --name noble deb:24.04 bash
