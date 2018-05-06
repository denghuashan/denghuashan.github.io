---
title: 搭建个人博客站点解密
---
对搭建个人博客站点的步骤进行详细回顾，并记录。个人喜欢图文并茂。总结是检验自己的学习效果，并进行巩固。

## 系统环境配置
* 之前说过个人博客采用node.js+hexo+github搭建。要使用hexo，需要在你的系统中支持node.js以及Git，如果还没有，那就需要安装。
## 安装node.js
* 下载与安装地址：[http://www.runoob.com/nodejs/nodejs-install-setup.html](http://www.runoob.com/nodejs/nodejs-install-setup.html)
* 请根据自己操作系统的位数进行下载，这里不在阐述。
* 检验node.js是否安装好，如下图：<br>![](http://orxmumro7.bkt.clouddn.com/17-6-26/7768675.jpg)
## 安装Git
* 下载与安装地址：[https://git-scm.com/download/](https://git-scm.com/download/)
* 请根据自己操作系统的位数进行下载，这里不在阐述。
* 检验Git是否安装好，如下图：<br>![](http://orxmumro7.bkt.clouddn.com/17-6-26/83255845.jpg)
## 安装hexo
* 安装好Git后，右键点击Git Bash，进入本地Git控制台。
		$ cd d:/hexo # 可自行安装到任意目录
		$ npm install hexo-cli -g # 使用包管理工具npm安装hexo，-g是全局安装
		$ hexo init blog # 初始化到blog目录中，可任意选择
		$ cd blog # 进入blog目录
		$ npm install # 本地安装
		$ hexo g # 或者hexo generate，会在当前路径下生成public文件夹
		$ hexo s # 或者hexo server，可以在http://localhost:4000/ 查看
* 这里有必要提下Hexo常用的几个命令：
		$ hexo generate (hexo g) 生成静态文件，会在当前目录下生成一个新的叫做public的文件夹
		$ hexo server (hexo s) 启动本地web服务，用于博客的预览
		$ hexo deploy (hexo d) 部署播客到远端（比如github, heroku等平台）
* 常用简写
		$ hexo n == hexo new
		$ hexo g == hexo generate
		$ hexo s == hexo server
		$ hexo d == hexo deploy
### 现在打开[http://localhost:4000/](http://localhost:4000/)已经可以看到一篇内置的blog了。
![](http://orxmumro7.bkt.clouddn.com/17-6-26/49793978.jpg)
### 安装所用的本地环境如下：(可以通过Git控制台输入hexo -v查看)
![](http://orxmumro7.bkt.clouddn.com/17-6-26/15846985.jpg)
## hexo主题设置
这里以主题yilia为例进行说明。可以百度搜索hexo主题，有很多。
### 安装主题
		$ hexo clean
		$ git clone https://github.com/litten/hexo-theme-yilia.git themes/yilia
### 启用主题
修改blog目录下的_config.yml配置文件中的theme属性，将其设置为yilia。
### 更新主题
		$ cd d:/hexo/blog/themes/yilia
		$ git pull # # 取回远程仓库的变化，并与本地分支合并
		$ cd d:/hexo/blog
		$ hexo g # 生成新的静态文件
		$ hexo s # 启动本地web服务器
现在打开[http://localhost:4000/](http://localhost:4000/)，会看已经应用了一个新的主题。
## GitHub
### 注册GitHub
地址：[http://www.github.com/](http://www.github.com/)<br>
注册你的 username 和邮箱，邮箱十分重要，GitHub 上很多通知都是通过邮箱发送。
### 配置和使用 GitHub
* 登录GitHub，跳过引导页。点击Start a project
* 入下图示例：以.github.io结尾仓库。红色感叹号，是因为我的仓库已经存在同名项目了。不存在会显示绿色打钩图标<br>![](http://orxmumro7.bkt.clouddn.com/17-6-26/13049613.jpg)
* 新建的仓库，需要有一次提交记录。红框部分就是一个示例，在Git控制台进行输入。输入之前先让本地 git 项目与远程的 GitHub 建立联系。<br>![](http://orxmumro7.bkt.clouddn.com/17-6-26/7148619.jpg)
## 配置 SSH keys
### 检查 SSH keys的设置
		$ cd ~/.ssh # 检查本机的ssh密钥
如果提示：No such file or directory，说明你是第一次使用 git。如果有把.ssh文件夹里的文件先删掉。.ssh路径为：'C:\Users\your_user_directory\'，例如我的'C:\Users\DELL\'
### 生成新的 SSH Key：
		$ ssh-keygen -t rsa -C "邮箱地址@youremail.com" # GitHub注册的邮箱地址，-C为大写的C
		$ Generating public/private rsa key pair. # 采用非对称加密算法RSA生成公钥与私钥
		$ Enter file in which to save the key (/Users/your_user_directory/.ssh/id_rsa): # 回车就好
		$ Enter passphrase (empty for no passphrase): # 加盐处理，输入加密串
		$ Enter same passphrase again: # 加盐处理，再次输入加密串
SSH key设置成功界面：
![](http://orxmumro7.bkt.clouddn.com/17-6-26/25782206.jpg)
### 添加 SSH Key 到 GitHub
* 打开本地 id_rsa.pub 文件（参考地址 C:\Users\DELL\.ssh\id_rsa.pub）。此文件里面内容为刚才生成的密钥。如果看不到这个文件，你需要设置显示隐藏文件。准确的复制这个文件的内容，才能保证设置的成功。
* 登陆 GitHub 账号。点击右上角的 Account Settings--->SSH Public keys ---> add another public keys
* 把本地生成的密钥复制到里面（ key 文本框中）， 点击 add key 就ok了<br>
![](http://orxmumro7.bkt.clouddn.com/17-6-26/16438910.jpg)
### 使用Git控制台进行第一次提交
新建一个文件夹，右键点击Git Bash，进入本地Git控制台。
		$ echo "# test" >> README.md
		$ git init
		$ git add README.md
		$ git commit -m "first commit"
		$ git remote add origin https://github.com/denghuashan/denghuashan.git.io.git
		$ git push -u origin master
此时会要求输入username和password
![](http://orxmumro7.bkt.clouddn.com/17-6-26/79878299.jpg)<br>
#### 返回GitHub仓库F5刷新一下
![](http://orxmumro7.bkt.clouddn.com/17-6-26/44614202.jpg)
#### 点击右上角Fork
![](http://orxmumro7.bkt.clouddn.com/17-6-26/21744995.jpg)<br><br>
这时，可以通过链接[http://denghuashan.github.io/](http://denghuashan.github.io/)访问了。（现在还没有内容，别着急）
## 部署hexo到Github
### 这是很关键的一步，把在本地web环境下预览到的博客部署到github上，然后就可以直接通过[http://denghuashan.github.io/](http://denghuashan.github.io/)访问了。
		$ cd d:/hexo/blog
		$ git clone https://github.com/denghuashan/denghuashan.github.io.git .deploy/denghuashan.github.io
将之前创建的repo克隆到本地，新建一个目录叫做.deploy用于存放克隆的代码。
### 创建一个deploy脚本文件
		$ hexo generate # 生成最新的静态文件
		$ cp -R public/* .deploy/denghuashan.github.io # 拷贝public文件夹下的文件到本地仓库中去
		$ cd .deploy/denghuashan.github.io
		$ git add . # 添加到暂存区
		$ git commit -m “update” # 说明为update
		$ git push origin master # 推送本地分支到远程仓库master分支，输入username和password
		$ # 在d:/hexo/blog新建一个deploy.sh的文件，保存上面的指令。（shell脚本）下次推送到仓库的时候，直接在Git控制台启用。
		$ cd d:/hexo/blog
		$ sh deploy.sh
再访问[http://denghuashan.github.io](http://denghuashan.github.io)，就会看到hexo的web页面了。
## blog目录
![](http://orxmumro7.bkt.clouddn.com/17-6-26/20117628.jpg)
### 各文件夹及文件的作用
* .deploy：本地仓库
* node_modules：nodejs对hexo的支持，不要删除
* public：hexo生成的静态文件
* source：类似那个webapp目录，该目录下的_posts文件夹就是存放文章的。Markdown文件，方便博客的编写与编辑。
* themes：主题文件存放处
## blog目录下_config.yml文件配置说明
		# Hexo Configuration
		## Docs: https://hexo.io/docs/configuration.html
		## Source: https://github.com/hexojs/hexo/
		# Site
		title: DreamMaker-HS # 个人博客的标题。html中head标签中的title
		subtitle: 勤思善问，可敌良师益友。# 子标题
		description: 博学而笃志，切问而静思.! # 描述
		author: HuaShan # 作者名
		language: 
		timezone:
		# URL
		## If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'
		url: http://dhsmp.com # 独立域名
		root: /
	    permalink: :year/:month/:day/:title/
	    permalink_defaults:
	    # Directory
	    source_dir: source
	    public_dir: public
	    tag_dir: tags
	    archive_dir: archives
	    category_dir: categories
	    code_dir: downloads/code
	    i18n_dir: :lang
	    skip_render:
	    # Writing
	    new_post_name: :title.md # File name of new posts
	    default_layout: post
	    titlecase: false # Transform title into titlecase
	    external_link: true # Open external links in new tab
	    filename_case: 0
	    render_drafts: false
	    post_asset_folder: false
	    relative_link: false
	    future: true
	    highlight:
	      enable: true
	      line_number: true
	      auto_detect: false
	      tab_replace:
	   	# Category & Tag
	    default_category: uncategorized
	    category_map:
	    tag_map:
	    # Date / Time format
	   	## Hexo uses Moment.js to parse and display date
	    ## You can customize the date format as defined in
	    ## http://momentjs.com/docs/#/displaying/format/
	    date_format: YYYY-MM-DD
	    time_format: HH:mm:ss
	    # Pagination
	    ## Set per_page to 0 to disable pagination
	    per_page: 10
	    pagination_dir: page
	    # Extensions
	    ## Plugins: https://hexo.io/plugins/
	    ## Themes: https://hexo.io/themes/
	    theme: yilia # 主题，可以更改主题。默认是landscape
	    # Deployment
	    ## Docs: https://hexo.io/docs/deployment.html
		# 下面的配置需要添加
		deploy: # 部署`
		  type:github # 部署类型`
		  repository:https://github.com/denghuashan/denghuashan.github.io.git # 仓库地址`
		  branch:master # 分支`
## 绑定独立域名
		$ cd d:/hexo/blog/source/
		$ touch CNAME
		$ vim CNAME # 输入你的域名
		$ git add CNAME
		$ git commit -m "add CNAME"
		$ sh deploy.sh # 重新生成并提交
我是在阿里云上买的域名，操作基本是一样的。获取GitHub的IP地址，进入source目录下，添加CNAME文件。在域名注册提供商那里配置DNS解析。
![](http://orxmumro7.bkt.clouddn.com/17-6-26/4808297.jpg)
## 其他高级技巧
* 上面已经可以用独立域名进行访问了，其他的一些修改。在themes/(当前使用主题)/_config.yml文件进行修改配置。这里不在阐述。其他的一些特性，在这里只会提到，至于如何使用，请自行摸索。
* 采用Markdown进行文章的编辑与编写
* 使用的图床为七牛云存储 + 简易图床。[https://portal.qiniu.com/signup?code=3lmipeyx3j782](https://portal.qiniu.com/signup?code=3lmipeyx3j782 "七牛云存储")，点这个连接注册，可以给我增加存储空间。谢谢了。
* 添加404公益页面，推荐使用腾讯公益404。[http://www.qq.com/404/](http://www.qq.com/404/)
* 还可以添加一些其他的插件，如统计访问量、文章字数统计、文章评论与回复、打分，等等。