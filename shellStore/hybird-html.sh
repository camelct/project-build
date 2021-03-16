#! /bin/bash

sendDTalk() {
  access_token="SELF_TOKEN"
  curl https://oapi.dingtalk.com/robot/send?access_token=$access_token \
    -H "Content-Type: application/json" \
    -d " 
    {
      'msgtype': 'text',
      'text': {
        'content': '自动构建：$1'
      }
    }"
}

cd /sources/workspace/hybird-html

sendDTalk "开始拉取"
git pull

sendDTalk "开始打包"
yarn build

sendDTalk "开始分发"
rm -rf /sources/workspace/hybird-build/fn1/project/* && cp -rf /sources/workspace/hybird-html/dist/* /sources/workspace/hybird-build/fn1/project/
rm -rf /sources/workspace/hybird-build/fn2/project/* && cp -rf /sources/workspace/hybird-html/dist/* /sources/workspace/hybird-build/fn2/project/
rm -rf /sources/workspace/hybird-build/fn3/project/* && cp -rf /sources/workspace/hybird-html/dist/* /sources/workspace/hybird-build/fn3/project/
