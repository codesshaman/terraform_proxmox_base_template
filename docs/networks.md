### Example of bridge

```
[ 🖥️ VM1 ]──┐
[ 🖥️ VM2 ]──|──[ 💿 vmbr0 ]──[ 🌐 phis eno1 ]──> 🌏
[ 🖥️ VM3 ]──┘
     ^               ^               ^          ^
     1               2               3          4
```

1 - virtual machines

2 - virtual bridge interface

3 - phisical interface

4 - global network

### VLAN example

```
vmbr0 (Bridge) 
  ├─ VLAN 101
  └─ VLAN 102
```
