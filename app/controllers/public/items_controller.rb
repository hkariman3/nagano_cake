class Public::ItemsController < ApplicationController

  def index
      @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page])
      render :index
    else
      @items1 = Item.all
      @items = Item.all.page(params[:page])
      #presentメソッドでparams[:category_id]に値が含まれているか確認 => trueの場合下記を実行
    end
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart = CartItem.new
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page])
      render :index
    else
      @items1 = Item.all
      @items = Item.all.page(params[:page])
    end
  end

  private

  def item_params
    params.require(:item).permit(:name,:introduction,:price)
  end
end
