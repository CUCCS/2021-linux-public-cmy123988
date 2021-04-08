## 第三章实验   学习Systemd

### 实验目的

学习使用Systemd

### 实验环境

Virtualbox Ubuntu 20.04 Server 64bit

asciinema，Windows10--powershell

### 实验要求

-  根据教程学习Systemd操作并使用asciinema进行录屏
-  完成自查清单

### 实验过程

#### 1.学习Systemd

https://asciinema.org/a/RgXBZUJGOOlZdRSnZJML1f9e5

https://asciinema.org/a/92aAzQTt2kJEr9agxmPfh6kJd

https://asciinema.org/a/R2b2kG5CWxjRIsN0QjpN8ThMs

https://asciinema.org/a/evm0n2m2pXSAcouG4uZN5fj7e

https://asciinema.org/a/B0TaczL8sODAgmvQ5BQNuvAZl

https://asciinema.org/a/99LZ0ZeBeSwVUpociGUpBgPGY

#### 2.Systemd实战

https://asciinema.org/a/cXDLuQTpG6XLwlNeTwlGEl4bF

### 自查清单

1. 如何添加一个用户并使其具备sudo执行程序的权限？

   ```
   sudo adduser user_name
   username ALL=(ALL) ALL
   ```

   

2. 如何将一个用户添加到一个用户组？

   ```
   usermod -a -G [GroupName] [UserName]
   ```

   

3. 如何查看当前系统的分区表和文件系统详细信息？

   ```
   sudo fdisk -l  
   df -h
   ```

   

4. 如何实现开机自动挂载Virtualbox的共享目录分区？

   ```
   sudo mount -t vboxsf [共享文件夹名称] /mnt/dirname
   ```

   

5. 基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？

   ```
   lvextend --size {{120G}} {{logivcal_volume}}
   lvextend --size +{{100G}} -r {{logical_volume}}
   lvextend --size {{100%%FREE}} {{logical_volume}}
   
   lvreduce --size {{120G}} {{logical_volume}}
   lvreduce --size -{{100G}} -r {{logical_volume}}
   ```

   

6. 如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？

   在[Service]中做如下改动：

   ```
   ExecStartPost = <脚本位置>
   ExecStopPost = <脚本位置>
   sudo systemctl daemon-reload
   sudo systemctl restart demo.service
   ```

   

7. 如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现***杀不死\***？

   在[Service]中做如下改动：

   ```
   Restart=always
   sudo systemctl daemon-reload
   sudo systemctl restart demo.service
   ```

   

### 实验问题

在根据教程操作时有些运行的程序和服务需要按实际情况操作，还要注意系统状态变化

### 参考文献

[Systemd 入门教程：命令篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html)

[Systemd 入门教程：实战篇](http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-part-two.html)