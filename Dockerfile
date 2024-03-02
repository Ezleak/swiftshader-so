FROM debian:bookworm as dev-build
WORKDIR /build
RUN apt-get update && apt-get install -y git make cmake g++ nodejs glslang-tools pkg-config libx11-dev libxext-dev python3 gnutls-bin ca-certificates && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN git clone --depth=1 --recurse-submodules --shallow-submodules https://github.com/google/swiftshader.git && mkdir swbuild && cd swbuild && cmake ../swiftshader && make -j2

FROM scratch
COPY --from=dev-build /build/swbuild/Linux /swiftshader