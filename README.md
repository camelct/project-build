# project-cli

自动构建

```shell
docker logs autobuildnode
docker stop autobuildnode
docker rm autobuildnode

cd /home/project-cli && docker build --force-rm=true -t ct/node-web-app .
docker run --name autobuildnode -v /home/sources:/sources/workspace -p 8888:7777 -d ct/node-web-app

curl https://oapi.dingtalk.com/robot/send?access_token=SELF_TOKEN \
-H 'Content-Type: application/json' \
-d '{"msgtype": "text",
    "text": {
         "content": "钉钉机器人群消息测试"
    }
  }'
```
