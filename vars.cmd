@REM script for setting all the variables in order to run the ATH locally on windows
@REM use config.groovy in the same folder if desired uncomment below
@REM set CONFIG=%~dp0%config.groovy
set DISPLAY=:0
set INTERACTIVE=false
set BROWSER=remote-webdriver-firefox
set REMOTE_WEBDRIVER_URL=http://0.0.0.0:4444/wd/hub
set JENKINS_JAVA_OPTS=-Xmx1280m

@REM Jenkins binds to 0.0.0.0 (OMG) so we can use any network but the docker network.
@REM but we may as well use the default network
@echo off
FOR /F "tokens=* USEBACKQ" %%F IN (`netsh interface ipv4 show addresses "vEthernet (WSL)" ^| grep "IP Address:" ^| gawk '{print $3}'`) DO (
SET IP=%%F
)
@echo on
set SELENIUM_PROXY_HOSTNAME=%IP%
set JENKINS_LOCAL_HOSTNAME=%IP%
@echo.
@echo To start the remote firefox container run the following command:
@echo docker run --shm-size=256m -d -p 4444:4444 -p 5900:5900 -e no_proxy=localhost -e SCREEN_WIDTH=1680 -e SCREEN_HEIGHT=1090 selenium/standalone-firefox-debug:3.141.59