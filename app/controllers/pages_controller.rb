class PagesController < ApplicationController
  before_action :set_page, only: [:show, :update, :destroy, :page_content]

  def index
    @pages = Page.all
    json_response(@pages)
  end

  def create
    @page = Page.create!(page_params)
    json_response(@page, :created)
  end

  def show
    json_response(@page)
  end

  def update
    @page.update(page_params)
    head :no_content
  end

  def destroy
    @page.destroy
    head :no_content
  end

  private

  def page_params
    params.permit(:page_url)
  end

  def set_page
    @page = Page.find(params[:id])
  end

end
