module Api
  module V1
      class BooksController < ApplicationController
        rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
        require_relative '../../../representers/books_representer'

        def index
          books = Book.all
          puts books
          render json: BooksRepresenter.new(books).as_json
        end
        #asdasads
        def create
          author = Author.create!(author_params)
          book = Book.new(book_params.merge(author_id: author.id))

          if book.save
            render json: book, status: :created
          else
            render json: book.errors, status: :unprocessable_entity
          end
        end

        def destroy
          Book.find(params[:id]).destroy!
          head :no_content
        end


        def book_params
          params.require(:book).permit(:title)
        end

        def author_params
          params.require(:author).permit(:first_name, :last_name, :age)
        end


        def not_destroyed
          render json: {}, status: :unprocessable_entity
      end
    end
  end
end