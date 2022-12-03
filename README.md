This project name is ....Project12

Scope -

Region - US Central
Resource Groups: -
•	wmbqutarmrgp003 (for all VMs)
•	wmbqutarmrgp004 (for AZ SQL Database)

VM1-a and VM1-b  (IS6/7)
16 vCPUs / 128 GB – (2 VMs -RHEL8.x, Edsv5-series VM, Standard_E16ds_v5):-
(wmbqut001a.network.qut)
(wmbqut001b.network.qut)
App directory - /WM-data  (500 GB)

VM2-a and VM2-b  (MWS+CC+TC)
8 vCPUs / 64 GB – (2 VMs -RHEL8.x, Edsv5-series VM, Standard_E8ds_v5):-
(wmbqut002a.network.qut)
(wmbqut002b.network.qut)
App directory - /WM-data  (500 GB)

VM3-a and VM3-b (Broker3)
12 vCPUs / 252 GB – (2 VMs -RHEL8.x, FX-series VM, Standard_FX12mds):-
(wmbqut003a.network.qut)
(wmbqut003b.network.qut)
App directory (on Active node) - /WM-data  (500 GB) - (Active / Passive , Failover for VIP and Storage)



This template allows you to create 2 Virtual Machines under a Load balancer and configure a load balancing rule on Port 80. 