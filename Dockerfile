FROM base/archlinux

RUN pacman --noconfirm -Sy archlinux-keyring
RUN pacman --noconfirm -S ca-certificates
RUN which update-ca-certificates && update-ca-certificates || true
RUN trust extract-compat
RUN : \
  && pacman --noconfirm -S libunistring xz make \
  && pacman --noconfirm -S ncurses \
  && ln -s /usr/lib/libncursesw.so.6 /usr/lib/libncursesw.so.5 \
  && pacman --noconfirm -S crystal dmd llvm rust julia nim nodejs pypy ruby git tcl js \
  && yes | pacman -Sy mesa-libgl jdk8-openjdk jruby mono \
  && pacman --noconfirm -S cargo go scala gdc ldc wget clojure \
  && git clone https://github.com/kuwa72/benchmarks.git \
  && : \

