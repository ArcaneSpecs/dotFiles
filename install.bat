@echo off

pushd %~dp0

git pull
cd .config

cp -R nvim %USERPROFILE%\AppData\Local

popd 

