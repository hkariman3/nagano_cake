class Public::HomesController < ApplicationController

  def top
      @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page])
      render :index
    else
      @items1 = Item.all.order(created_at: :desc)
      @items = Item.all.page(params[:page])
    end
  end

  def about
  end

end
