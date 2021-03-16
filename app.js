const http = require("http");
const spawn = require("child_process").spawn;
const createHandler = require("github-webhook-handler");
const handler = createHandler(require("./config/webhooks.json"));
const axios = require("axios");

http
  .createServer(function (req, res) {
    handler(req, res, function (err) {
      res.statusCode = 404;
      res.end("no such location");
    });
  })
  .listen(7777);

handler.on("push", function (event) {
  // Received a push event for hybird-html to refs/heads/main
  const projectName = event.payload.repository.name;
  const devUrl = event.payload.ref;
  if (/main/.test(devUrl)) {
    // 构建主线
    sendDingtalk("自动构建：开始构建项目 " + projectName);

    rumCommand(
      "sh",
      ["./shellStore/" + projectName + ".sh"],
      function (buildres) {
        sendDingtalk("自动构建：部署 " + projectName + " 项目结束");
      },
    );
  } else if (/develop/.test(devUrl)) {
    // 构建测试线
    console.log("构建测试线");
  }
});

handler.on("error", function (err) {
  console.error("hook遇到问题 Error:", JSON.stringify(err, null, "  "));
});

const rumCommand = (cmd, args, callback) => {
  const child = spawn(cmd, args);
  let response = "";
  child.stdout.on("data", function (buffer) {
    response += buffer.toString();
  });
  child.stdout.on("end", function () {
    callback(response);
  });
};

/**
 *
 * @param {} json
 *  "msgtype": "text",
     "text": {
         "content": "我就是我, @150XXXXXXXX 是不一样的烟火"
     },
     "at": {
         "atMobiles": [
             "150XXXXXXXX"
         ], 
         "isAtAll": false
     }
 */
const access_token =
  "SELF_TOKEN";
const sendDingtalk = content => {
  const json = {
    msgtype: "text",
    text: {
      content,
    },
  };

  axios.post(
    "https://oapi.dingtalk.com/robot/send?access_token=" + access_token,
    json,
  );
};
