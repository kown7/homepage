---
title: Autostart VcXsrv
---
Instead of having a dual-boot setup, Windows came shipped with a
hypervisor for virtualization. Setting up a linux system with a console
was an obvious choice; but how to get access to important GUI tools like
gitk?

Connecting with SSH to the virtual linux system and then X forwarding
with [VcXsrv](http://vcxsrv.sourceforge.net/) may not seem to be the
obvious solution, but it works perfectly fine. But how to start vcxsrv
without having to click through the configuration every time?

Add the vcxsrv.bat script to your startup folder: C:\\Users\\<span
style="color:#800080;">&lt;yourUsername&gt;</span>\\AppData\\Roaming\\Microsoft\\Windows\\Start
Menu\\Programs\\Startup. It should contain the following line:

    start "" "C:\Program Files\VcXsrv\vcxsrv.exe" -multiwindow
