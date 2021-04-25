## 第四章实验：shell脚本编程基础

### 实验环境

- 虚拟机：**Virtualbox** Ubuntu 20.04 Server 64bit

- 软件环境：

  配置了Bash IDE的VScode-remote

  - ShellCheck
  - Bash Debug
  - Bash IDE

### 编程任务

#### 任务一：用bash编写一个图片批处理脚本，实现以下功能：

- [x] 支持命令行参数方式使用不同功能
- [x] 支持对指定目录下所有支持格式的图片文件进行批处理
- [x] 支持以下常见图片批处理功能的单独使用或组合使用
  - [x] 支持对jpeg格式图片进行图片质量压缩
  - [x] 支持对jpeg/png/svg格式图片在保持原始宽高比的前提下压缩分辨率
  - [x] 支持对图片批量添加自定义文本水印
  - [x] 支持批量重命名（统一添加文件名前缀或后缀，不影响原始文件扩展名）
  - [x] 支持将png/svg图片统一转换为jpg格式图片

#### 任务二：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务：

- [x] 2014世界杯运动员数据
  - [x] 统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员**数量**、**百分比**
  - [x] 统计不同场上位置的球员**数量**、**百分比**
  - [x] 名字最长的球员是谁？名字最短的球员是谁？
  - [x] 年龄最大的球员是谁？年龄最小的球员是谁？

#### 任务三：用bash编写一个文本批处理脚本，对以下附件分别进行批量处理完成相应的数据统计任务：

- [x] Web服务器访问日志
  - [x] 统计访问来源主机TOP 100和分别对应出现的总次数
  - [x] 统计访问来源主机TOP 100 IP和分别对应出现的总次数
  - [x] 统计最频繁被访问的URL TOP 100
  - [x] 统计不同响应状态码的出现次数和对应百分比
  - [x] 分别统计不同4XX状态码对应的TOP 10 URL和对应出现的总次数
  - [x] 给定URL输出TOP 100访问来源主机

### 实验要求

- 所有源代码文件必须单独提交并提供详细的脚本内置帮助信息
- 任务二的所有统计数据结果要求写入独立实验报告

### 实验过程

先进入VScode并连接到虚拟机，新建task1.sh,task2.sh,task3.sh三个脚本文件，并将要处理的图片传入和脚本文件同一目录下，安装imagemagick，shellcheck，p7zip-full

```
sudo apt-get update
sudo apt-get install -y shellcheck
sudo apt-get install imagemagick
sudo apt-get install p7zip-full
```

任务一

编写脚本并调试

![task1](C:\Users\cmy\2021-linux-public-cmy123988\chap0x04\img\task1.png)

任务二

编写脚本并调试

![task2](C:\Users\cmy\2021-linux-public-cmy123988\chap0x04\img\task2.png)

任务三

先解压压缩文件，再编写脚本并调试

```
7z x web_log.tsv.7z
```

![task3](C:\Users\cmy\2021-linux-public-cmy123988\chap0x04\img\task3.png)

根据要求，将实验数据存入ans.txt并单独写实验报告

#### Travis-ci构建

注册Travis-ci并绑定GitHub，可以实现自动构建

### 参考资料

[老师的b站教学视频](https://www.bilibili.com/video/BV1Hb4y1R7FE?p=2&spm_id_from=pageDriver)

[awk 入门教程 - 阮一峰的网络日志 (ruanyifeng.com)](http://www.ruanyifeng.com/blog/2018/11/awk.html)

[shell教程](https://www.runoob.com/linux/linux-shell.html)

https://github.com/CUCCS/linux-2020-LyuLumos/tree/ch0x04/ch0x04