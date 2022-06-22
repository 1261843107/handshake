# handshake
testbench使用的是verilog语言,其中发送端连续发送13个数据，接收端在接收6个数据后没个一个周期ready信号拉低一次。

一、对于valid打一拍的情况，给valid加了一级寄存器，为了除掉一级气泡，首先让寄存器存一个数据。
以下为仿真结果：
![valid打一拍](https://user-images.githubusercontent.com/73834205/175066013-a9524fd5-ff6f-4090-920e-ee39f39b51ae.png)

二、对于ready打一拍的情况，加了一个buffer，并且预存一个数据，在数据连续传输的情况可以转成直通模式
![ready打一拍](https://user-images.githubusercontent.com/73834205/175066174-804f9e7e-a499-4841-a46b-7ba752f5e8b6.png)


三、对于read valid都打一拍的情况，使用skid buffer
![valid和ready同时打拍](https://user-images.githubusercontent.com/73834205/175066238-9696ae50-f461-4c0b-b09a-b39af45fc815.png)

