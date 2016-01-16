express = require 'express'
app = express()

AppRouter = require './routes/app/app_router'

app.listen 3000, ->
  console.log 'Example app running on 3000!'

AppRouter.route(app)
