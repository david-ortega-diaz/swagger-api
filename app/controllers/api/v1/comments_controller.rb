module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: [:show, :update, :destroy]

      # GET /api/v1/comments
      def index
        @comments = Comment.all

        render json: @comments
      end

      # GET /api/v1/comments/1
      def show
        if @comment
          render json: @comment.to_json(only: [:id, :post_id, :commenter, :body, :index_comments_on_post_id])
        else
          render json: {}, status: :not_found
        end
      end

      # comment /api/v1/comments
      def create
        @comment = Comment.new(comment_params)

        if @comment.save
          render json: @comment.to_json(only: [:id, :post_id, :commenter, :body, :index_comments_on_post_id]), status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/comments/1
      def update
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/comments/1
      def destroy
        @comment.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_comment
          @comment = Comment.find(params[:id])
        rescue ActiveRecord::RecordNotFound
        end

        # Only allow a trusted parameter "white list" through.
        def comment_params
          params.fetch(:comment).permit(:post_id, :commenter, :body, :index_comments_on_post_id)
          # .permit(:name, :status, :photo_url)
        end
      end
    end
  end
