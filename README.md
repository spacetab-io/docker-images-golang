docker-images-golang
-------------------

Images for docker containers:

* [Lint environment](linter) container is for lint golang app source code. 
Uses [golangci-lint](https://github.com/golangci/golangci-lint) to lint code with [custom config](lint/.golangci.yml). 
* [Test environment](test) container is for testing golang app. Has all things to test golang sources with `go test`. 
* [Build environment](build) container is for building golang app. Has all things to build golang app with go modules. 
* [Base environment](base) container is for running golang app. Has all things to run binaries in formalized application 
structure. Exposes `8080` port and run service command: `/app/bin/service`. Only thing you must do is copy binaries, 
Makefile (if needed), migrations (if needed) and application default configuration.

## Building image

Simply run a `make` command
    
    make build-base-image   # to build base image
    make build-build-image  # to build building image
    make build-linter-image # to build linterr image
    make build-test-image   # to build test image
    make build-all          # to build all images

## Pushing image

Simply run a `make` command
    
    make push-base-image   # to push base image
    make push-build-image  # to push building image
    make push-linter-image # to push linterr image
    make push-test-image   # to push test image
    make push-all          # to push all images

## Images usage

Common usage application Dockerfile:

```dockerfile
FROM spacetabio/docker-lint-golang:1.12-latest as lint-env

COPY . /app
RUN make lint

# ----

FROM spacetabio/docker-test-golang:1.12-latest as test-env

COPY . /app
RUN make test

# ----

FROM spacetabio/docker-build-golang:1.12-latest as build-env

COPY . /app
RUN make all

# ----

FROM spacetabio/docker-base-golang:1.12-latest

COPY --from=build-env /app/bin/*                  /app/bin/
COPY --from=build-env /app/Makefile               /app/
COPY --from=build-env /app/migrations/*           /app/migrations/
COPY --from=build-env /app/configuration/defaults /app/configuration/defaults
```

If private packages are used, build it with Dockerfile below and command: 
`docker build -t <imagename>:<tag> --build-arg TOKEN="$(cat ~/.ci-token)" --build-arg PRIVATE_REPO="private.repo.url" .`

```dockerfile
FROM spacetabio/docker-test-golang:1.12-latest as test-env

ARG TOKEN
ARG PRIVATE_REPO
RUN git config --global url."https://ci-token:${TOKEN}@${PRIVATE_REPO}/".insteadOf 'https://${PRIVATE_REPO}/'

COPY . /app
RUN make test
```

## LICENCE

MIT License

Copyright (c) 2021 Spacetab.io

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "
Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
