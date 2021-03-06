require 'rails_helper'
describe 'Books API', type:  :request do
  describe 'get books' do
    it 'returns all books' do
      FactoryBot.create(:book, title: '1925', author: 'Geador Well')
      FactoryBot.create(:book, title: '1922', author: 'Geador Peops')
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      # expect(JSON.parse(response.body.size)).to eq(2)
    end
  end
  describe 'POST /books' do
    it 'create a new book' do
      expect { post "/api/v1/books",  params: {
        book: {title: '1925'},
        author: {first_name: '1925', last_name: 'Geador Well', age: 52}
      }}.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
      expect(Author.count).to eq(1)
    end
  end
  describe 'DELETE /books/:id' do
    it 'delete a book' do
      FactoryBot.create(:book, id: 1,  title: '1925', author: 'Geador Well')
      delete "/api/v1/books/1"
      expect(response).to have_http_status(:no_content)
    end
  end

end