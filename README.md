# handshake
testbench使用的是verilog语言,其中发送端连续发送13个数据，接收端在接收6个数据后没个一个周期ready信号拉低一次。

一、对于valid打一拍的情况，给valid加了一级寄存器，为了除掉一级气泡，首先让寄存器存一个数据。
以下为仿真结果：
![valid打一拍](https://user-images.githubusercontent.com/73834205/175066013-a9524fd5-ff6f-4090-920e-ee39f39b51ae.png)

二、对于ready打一拍的情况，加了一个buffer，并且预存一个数据，在数据连续传输的情况可以转成直通模式
![ready打一拍](https://user-images.githubusercontent.com/73834205/175066174-804f9e7e-a499-4841-a46b-7ba752f5e8b6.png)


三、对于ready valid都打一拍的情况，将前两个模块例化在一个大的模块里，最后来看仿真结果，因为data和valid会打一拍所以data_o相对data_i有一个周期的延迟，但是已经消除了气泡，然后，在slave间隔一个周期拉高ready的情况也没有出现遗漏数据的情况。
![valid和ready同时打拍](https://user-images.githubusercontent.com/73834205/175526818-a35b0729-2331-4fa9-8d15-335ebfc3912b.png)




