# README

Swagger integration with Rails application using rswag gem

Working with a sqlite database

Setup:

bundle install

rake db:migrate

rake rswag:specs:swaggerize

Start Rails server:

rails s
Go to http://localhost:3000/api-docs to view swagger-ui