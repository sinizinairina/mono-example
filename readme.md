Blog example for MonoJS Web Framework

# Installation

1 Install and start MongoDB

2 Install Node.JS

3 Install Blog Example and its dependencies

```
git clone https://github.com/sinizinairina/mono-example.git
cd mono-example
npm install
npm install coffee-script -g
coffee app.coffee
```

4 Go to http://localhost:3000

# Benchmarking

Install siege - `brew install siege`

Start example in production mode - `environment=production coffee app.coffee`
and create couple of blog posts there.

Run benchmark `siege -b -t10s -c100 http://localhost:3000`

# Ignore this seciont

How to start in on server

`port=3001 nohup node_modules/coffee-script/bin/coffee app.coffee > /dev/null 2> /dev/null < /dev/null &`