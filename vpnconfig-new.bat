::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFDNBQhCHLleeA6YX/Ofr0+OXnk8cQK86YIrnzrubOOkS5EKqfJUitg==
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZksaHErRXA==
::ZQ05rAF9IBncCkqN+0xwdVsFAlTMbCXpZg==
::ZQ05rAF9IAHYFVzEqQIROglVVUSxD0f6MIUybQc0azJtJZDsNA==
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWNB3Isbv6Xs=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATEc6TaruO6LA==
::ZQ0/vhVqMQ3MEVWAtB9wruObLA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRkNBqq158J1XhaDJSuJNZlc3tjVagVIJpX30z/OGA==
::Zh4grVQjdCyDJGyX8VAjFBNBQhCHLleeA6YX/Ofr0+OXnk8cQK86YIrn7ISgI+8d7EzjI8Jj02Jf+A==
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off&color 0D&MODE con: COLS=100 LINES=25

title Array SSL VPN 可上网脚本
title Array SSL VPN 可上网脚本


::echo 设置本地可上网的网关及vpn虚拟网关
::set localroute=10.180.160.1
::set localroute=192.168.42.11		%路由器 xiong %
::set localroute=192.168.1.1 		%路由器 Xn9s %
::set localroute=192.168.43.182
::set localroute=192.168.43.1       %热点%
for /f "usebackq tokens=3" %%I in (`route print -4 ^|findstr "211.141.83.94"`) do set localroute=%%I
for /f "usebackq tokens=4" %%I in (`route print -4 ^|findstr "211.141.83.94"`) do set localIP=%%I

if "%localroute%"=="" (Goto noset) 
echo %localroute%
echo %localIP%




::set localroute=192.168.50.1 

::set vpnroute=10.10.32.1
::set vpnroute=10.10.36.1
set vpnroute=10.10.0.1
for /f "usebackq tokens=3" %%I in (`route print -4 0.0.0.0^|findstr "0.0.0.0"^|findstr "10.10"`) do set vpnroute=%%I
set vpnroute=10.10.0.1

set localIF=16
for /f "usebackq tokens=1" %%I in (`wmic nicconfig get IPAddress^,InterfaceIndex^,IPEnabled^|findstr TRUE^|findstr %localIP%`) do set localIF=%%I
set VPN_Adapter=49
for /f "usebackq tokens=2" %%I in (`wmic nicconfig get DefaultIPGateway^,InterfaceIndex^,IPEnabled^|findstr TRUE^|findstr %vpnroute%`) do set VPN_Adapter=%%I


echo 添加路由
route add 128.0.0.0 mask 128.0.0.0 %localroute% if %localIF%
route add 64.0.0.0  mask 192.0.0.0 %localroute% if %localIF%
route add 32.0.0.0  mask 224.0.0.0 %localroute% if %localIF%
route add 16.0.0.0  mask 240.0.0.0 %localroute% if %localIF%
::route add 0.0.0.0 mask 248.0.0.0 %localroute% if %localIF%
route add 4.0.0.0   mask 252.0.0.0 %localroute% if %localIF%
route add 2.0.0.0   mask 254.0.0.0 %localroute% if %localIF%
route add 1.0.0.0   mask 255.0.0.0 %localroute% if %localIF%
route add 12.0.0.0  mask 252.0.0.0 %localroute% if %localIF%
route add 8.0.0.0   mask 254.0.0.0 %localroute% if %localIF%
route add 11.0.0.0  mask 255.0.0.0 %localroute% if %localIF%
route add 10.0.0.0  mask 255.0.0.0 %vpnroute% if %VPN_Adapter%

timeout /t 2 /nobreak > nul
echo WScript.sleep 2000 > sleep.vbs
Wscript sleep.vbs

echo 更改vpn的路由优先级
::将vpnroute的值改大，优先级改低
::for %%I in (%IP%) do route change %%I %vpnroute% metric 800 if 12;
route change 128.0.0.0 mask 128.0.0.0 %vpnroute% if %VPN_Adapter% metric 800
route change  64.0.0.0 mask 192.0.0.0 %vpnroute% if %VPN_Adapter% metric 800
route change  32.0.0.0 mask 224.0.0.0 %vpnroute% if %VPN_Adapter% metric 800
route change  16.0.0.0 mask 240.0.0.0 %vpnroute% if %VPN_Adapter% metric 800
::route change 0.0.0.0 mask 248.0.0.0 %vpnroute% if %VPN_Adapter% metric 800
route change   4.0.0.0 mask 252.0.0.0 %vpnroute% if %VPN_Adapter% metric 800
route change   2.0.0.0 mask 254.0.0.0 %vpnroute% if %VPN_Adapter% metric 800
route change   1.0.0.0 mask 255.0.0.0 %vpnroute% if %VPN_Adapter% metric 800
route change  12.0.0.0 mask 252.0.0.0 %vpnroute% if %VPN_Adapter% metric 800
route change   8.0.0.0 mask 254.0.0.0 %vpnroute% if %VPN_Adapter% metric 800
route change  11.0.0.0 mask 255.0.0.0 %vpnroute% if %VPN_Adapter% metric 800


cls
echo on
echo ping test

set ip=223.5.5.5,183.232.96.107,120.204.10.176,117.184.242.105,117.184.242.106,183.192.169.100,183.232.231.172,183.232.231.173,183.192.169.101,120.204.10.176,112.60.1.19,117.169.101.153,117.169.101.164,120.241.189.228,112.60.1.26,112.60.1.26,112.60.1.15,112.60.1.59,112.60.1.62,117.169.102.203,117.169.101.151,120.241.189.188
for %%I in (%ip%) do ping -n 1 %%I


exit

::route add 10.0.0.0 mask 255.0.0.0 10.10.0.1 if 12
::route add 0.0.0.0 mask 0.0.0.0 192.168.43.1 if 16

:noset

echo VPN未正常开启，请检查或等待"Array SSL VPN"开启，再重新运行，按任意键退出！
::可能公网地址已经改变
pause>nul
