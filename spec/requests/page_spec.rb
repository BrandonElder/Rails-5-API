require 'rails_helper'

RSpec.describe 'Rails API', type: :request do
  # initialize test data 
  let!(:pages) { create_list(:page, 10) }
  let(:page_id) { pages.first.id }

  # Test suite for GET /pages
  describe 'GET /pages' do
    # make HTTP GET request before each example
    before { get '/pages'}

    it 'returns pages' do

      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end


  # Test suite for GET /pages/:id
  describe 'GET /pages/:id' do
    before { get "/pages/#{page_id}" }

    context 'when the record exists' do
      it 'returns the page' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(page_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the records does not exist' do
      let(:page_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end


  # Test suite for POST /pages
  describe 'POST /pages' do
    let(:valid_attributes) { { page_url: 'www.example.com'} }
    let(:invalid_attributes) { { page_url: ""} }

    context 'when the request is valid' do
      before { post '/pages', params: valid_attributes }

      it 'creates a page' do
        expect(json['page_url']).to eq('www.example.com')
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/pages', params: { page_url: "" } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for PUT /pages/:id

  describe 'PUT /pages/:id' do
    let(:valid_attributes) { { page_url: 'www.example.com'} }

    context 'when the record exists' do
      before { put "/pages/#{page_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /pages/:id' do
    before { delete "/pages/#{page_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

