# Building ton-client-js WASM inside docker
## Instalation
```
git clone https://github.com/d3p/ton-client-js.wasm.build.git
```
## Making build image
```
docker build -t build-tonclient-wasm -f .\ton-client-js.wasm.build\Dockerfile .
```
## Build WASM
Change current location to `ton-client-js` project
```
cd ton-client-js
```
Run build process. First attempt will take a long time. Next run will be faster because `.cargo` directory will be populated with cache.
```
docker run --rm -v $(pwd):/tonlabs/TON-SDK -it build-tonclient-wasm "build-tonclient-wasm.sh"
```
## Location of binaries
After successful build process, binaries will be located here
```
ton-client-js/packages/lib-web/index.js
ton-client-js/packages/lib-web/tonclient.wasm
Compressed
ton-client-js/packages/lib-web/publish/tonclient_1_20_wasm.gz
ton-client-js/packages/lib-web/publish/tonclient_1_20_wasm_js.gz
```
