require "sinatra"
require "sinatra/activerecord"
require "./models/post.rb" # さっき作ったモデルを読み込み

get "/posts" do
  Post.all.to_json # 全てのPostを返す
end

get "/posts/:id" do
  Post.find(params[:id]).to_json # :idのPostを返す
end

post "/posts" do
  # sinatraはPOSTメソッドの際デフォルトでjsonを受け取れないので変換
  # 参考: http://qiita.com/izumin5210/items/caf66ece1f67a0fd6a4c
  json = JSON.parse(request.body.read)
  post = Post.new(json)
  if post.save
    { result: "success", code: 200 }.to_json
  else
    { result: "failure" }.to_json
  end
end

# 描画のための処理
get "/" do
  "test"
end