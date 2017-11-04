class PageContentsController < ApplicationController
  before_action :set_page
  before_action :set_page_content, only: [:show, :update, :destroy]

  def index
    json_response(@page.page_contents)
  end

  def show
    json_response(@page_content)
  end

  def create
    @page.page_contents.create!(page_content_params)
    json_response(@page, :created)
  end

  def update
    @page_content.update(page_content_params)
    head :no_content
  end

  def destroy
    @page_content.destroy
    head :no_content
  end

  private

  def page_content_params
    params.permit(:tag, :content)
  end

  def set_page
    @page = Page.find(params[:page_id])
  end

  def set_page_content
    @page_content = @page.page_contents.find_by!(id: params[:id]) if @page
  end

end
