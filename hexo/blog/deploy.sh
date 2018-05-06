hexo generate
cp -R public/* .deploy/denghuashan.github.io
cd .deploy/denghuashan.github.io
git add .
git commit -m “update”
git push origin master