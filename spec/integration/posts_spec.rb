# spec/integration/pets_spec.rb
require 'swagger_helper'

describe 'Posts API' do

  path '/api/v1/posts' do

    post 'Creates a post' do
      tags 'Posts'
      consumes 'application/json', 'application/xml'
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          text: { type: :text},
          author: { type: :string }
        },
        required: [ 'title', 'text', 'author' ]
      }

      response '201', 'post created' do
        let(:post) { { title: 'Dodo', text: 'beautiful bird', author: 'Miguel' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:post) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/posts/{id}' do

    get 'Retrieves a post' do
      tags 'Posts'
      produces 'application/json', 'application/xml'
      parameter title: :id, :in => :path, :type => :string

      response '200', 'title found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            title: { type: :string },
            text: { type: :text },
            author: { type: :string }
          },
          required: [ 'title', 'text', 'author' ]

        let(:id) { Post.create(title: 'foo', text: 'bar', author: 'Gabo').id }
        run_test!
      end

      response '404', 'pet not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end