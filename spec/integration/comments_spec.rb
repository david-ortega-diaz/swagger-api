# spec/integration/comments_spec.rb
require 'swagger_helper'

describe 'Comments API' do

  path '/api/v1/posts/{id}/comments' do

    post 'Create a comment' do
      tags 'Comments'
      consumes 'application/json', 'application/xml'
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          commenter: { type: :string },
          body: { type: :text },
          post_id: { type: :integer },
          index_comments_on_post_id: { type: :index }
        },
        required: [ 'commenter', 'body', 'post_id', 'index_comments_on_post_id' ]
      }

      response '201', 'post created' do
        let(:comment) { { commenter: 'Dodo', body: 'available', post_id: 5, index_comments_on_post_id: 3 } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:comment) { { commenter: 'foo' } }
        run_test!
      end
    end
  end

  path '/api/v1/posts/{id}/comments/{id_comment}' do

    get 'Retrieves a comment' do
      tags 'Comments'
      produces 'application/json', 'application/xml'
      parameter name: :id_comment, :in => :path, :type => :integer

      response '200', 'comment found' do
        schema type: :object,
          properties: {
            post_id: { type: :integer},
            commenter: { type: :string },
            body: { type: :text }
          },
          required: [ 'post_id', 'commenter', 'body']

        let(:id) { Comment.create(commenter: 'foo', body: 'bar').id }
        run_test!
      end

      response '404', 'comment not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end
end