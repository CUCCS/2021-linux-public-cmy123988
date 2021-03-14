

# 基于Ubuntu20.04系统的无人值守安装

### 软件环境

- Virtualbox
- Ubuntu 20.04 Server 64bit

### 实验要求

先手动安装ubuntu，自己用user-data和meta-data制作iso镜像文件，并在VirtualBox中进行配置完成无人值守安装

### 实验步骤

#### 1.手动安装ubuntu

下载好ubuntu-20.04.2-live-server-amd64.iso

![ubuntu-20.04.2-live-server-amd64](C:\Users\cmy\Desktop\chap0x01\ubuntu-20.04.2-live-server-amd64.png)

新建虚拟机并手动安装ubuntu

![create_new_virtual](C:\Users\cmy\Desktop\chap0x01\create_new_virtual.png)

设置双网卡

![network](C:\Users\cmy\Desktop\chap0x01\network.png)

挂载ubuntu-20.04.2-live-server-amd64.iso

![mount_disk](C:\Users\cmy\Desktop\chap0x01\mount_disk.png)

安装过程

![installing](C:\Users\cmy\Desktop\chap0x01\installing.png)

设置用户名和密码

![set_password](C:\Users\cmy\Desktop\chap0x01\set_password.png)

安装openSSH server

![install_openSSH_server](C:\Users\cmy\Desktop\chap0x01\install_openSSH_server.png)

安装完成，启用ssh并连接

![connect_SSH](C:\Users\cmy\Desktop\chap0x01\connect_SSH.png)

使用手动安装 Ubuntu 后得到的一个初始「自动配置描述文件」 :

```
/var/log/installer/autoinstall-user-data
```

![view_intial_autoinstall-user-data](C:\Users\cmy\Desktop\chap0x01\view_intial_autoinstall-user-data.png)

#### 2.参考 [番外章节 Cloud-Init 实验目录中的说明文件](https://github.com/c4pr1c3/LinuxSysAdmin/blob/a3c3ed18cf38b9e4be1ea53b46efe7f02e4ab8b5/exp/cloud-init/docker-compose/README.md) ，制作包含 `user-data` 和 `meta-data` 的 ISO 镜像文件，假设命名为 `focal-init.iso`

将autoininstall-user-data传送给主机

对照Ubuntu 20.04 + Autoinstall + VirtualBox中提供的示例配置文件进行修改并命名为user-data

![change_user_data](C:\Users\cmy\Desktop\chap0x01\change_user_data.png)

新建一个空文件meta-data并将两个文件发送给虚拟机

![sftp_send](C:\Users\cmy\Desktop\chap0x01\sftp_send.png)

安装依赖工具并创建 cloud-init 镜像

```
sudo apt install genisoimage

genisoimage -input-charset utf-8 -output init.iso -volid cidata -joliet -rock user-data meta-data
```

![make_cloud_init](C:\Users\cmy\Desktop\chap0x01\make_cloud_init.png)

利用前面传送autoininstall-user-data的方式把init.iso文件传给主机并将其改名为focal-init.iso

![send_init.iso](C:\Users\cmy\Desktop\chap0x01\send_init.iso.png)

#### 3.开始基于Ubuntu20.04系统的无人值守安装

移除上述虚拟机「设置」-「存储」-「控制器：IDE」

![remove_IDE](C:\Users\cmy\Desktop\chap0x01\remove_IDE.png)

在「控制器：SATA」下新建 2 个虚拟光盘，分别挂载「纯净版 Ubuntu 安装镜像文件」和 `focal-init.iso`

![remount_disk](C:\Users\cmy\Desktop\chap0x01\remount_disk.png)

查看虚拟机设置状态

![check_settings](C:\Users\cmy\Desktop\chap0x01\check_settings.png)

启动虚拟机，稍等片刻会看到命令行中出现以下提示信息。此时，需要输入 `yes` 并按下回车键，剩下的就交给「无人值守安装」程序自动完成系统安装和重启进入系统可用状态了

![begin_focal_installation](C:\Users\cmy\Desktop\chap0x01\begin_focal_installation.png)

### 实验中的问题和解决方法

在将user-data和meta-data发送给虚拟机的过程中先后出现了两个错误：编码格式不对和找不到文件

![utf-8_bug](C:\Users\cmy\Desktop\chap0x01\utf-8_bug.png)

将命令 genisoimage -output init.iso -volid cidata -joliet -rock user-data meta-data 改为genisoimage -input-charset utf-8 -output init.iso -volid cidata -joliet -rock user-data meta-data后编码错误解决但文件找不到没有解决，猜想传输方式不对，于是又用了sftp方法传送，成功解决，但后来明白我进入目录不对所以找不到，如果进入data目录问题应该也能解决。

![transfer_success](C:\Users\cmy\Desktop\chap0x01\transfer_success.png)