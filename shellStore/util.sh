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