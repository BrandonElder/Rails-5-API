require 'rails_helper'

RSpec.describe 'PageContents API' do
  # Initialize the test data
  let!(:page) { create(:page) }
  let!(:page_contents) { create_list(:page_content, 20, page_id: page.id) }
  let(:page_id) { page.id }
  let(:id) { page_contents.first.id }

  # Tests for GET /pages/:page_id/page_contents
  describe 'GET /pages/:page_id/page_contents' do
    before { get "/pages/#{page_id}/page_contents" }

    context 'when page exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all page contents' do
        expect(json.size).to eq(20)
      end
    end

    context 'when page does not exist' do
      let(:page_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Page/)
      end
    end
  end

  # Tests for GET /pages/:page_id/page_contents/:id
  describe 'GET /pages/:page_id/page_contents/:id' do
    before { get "/pages/#{page_id}/page_contents/#{id}" }

    context 'when page content exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when page content does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Page/)
      end
    end
  end

  # Tests for PUT /pages/:page_id/page_contents
  describe 'POST /pages/:page_id/page_contents' do
    let(:valid_attributes) { { content: 'Remember Alf', tag: 'h1' } }

    context 'when request attributes are valid' do
      before { post "/pages/#{page_id}/page_contents", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/pages/#{page_id}/page_contents", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Tag can't be blank, Content can't be blank/)
      end
    end
  end

  # Tests for PUT /pages/:page_id/page_contents/:id
  describe 'PUT /pages/:page_id/page_contents/:id' do
    let(:valid_attributes) { { content: 'Cookie Crook' } }

    before { put "/pages/#{page_id}/page_contents/#{id}", params: valid_attributes }

    context 'when page content exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the page content' do
        updated_content = PageContent.find(id)
        expect(updated_content.content).to match(/Cookie Crook/)
      end
    end

    context 'when the page content does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find PageContent/)
      end
    end
  end

  # Test suite for DELETE /pages/:id
  describe 'DELETE /pages/:id' do
    before { delete "/pages/#{page_id}/page_contents/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end