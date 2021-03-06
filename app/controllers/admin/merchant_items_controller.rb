class Admin::MerchantItemsController < Admin::BaseController 
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    if params[:type]
      merchant = find_merchant_from_item
      change_item_status(merchant)
    else 
      update_item
    end
  end

  def destroy
    merchant = find_merchant_from_item
    flash[:notice] = "#{find_item(merchant).name} was successfully deleted"
    find_item(merchant).delete
    redirect_to '/admin/merchant/items'
  end

  private

  def item_params
    params.permit(:name, :description, :price, :image, :inventory)
  end
  
  def find_item(merchant)
    merchant.items.find(params[:id])
  end

  def update_item
    @item = Item.find(params[:item_id])
    @item.update(item_params)
    if @item.save
      redirect_to "/admin/merchants/#{@item.merchant_id}/items"
    else
      flash[:notice] = @item.errors.full_messages.to_sentence
      redirect_to "/admin/merchants/#{@item.merchant_id}/items/#{@item.id}/edit"
    end
  end

  def change_item_status(merchant)
    if params[:type] == 'deactivate'
      find_item(merchant).update(active?: false)
      flash[:notice] = "#{find_item(merchant).name} is no longer for sale!"
    elsif params[:type] == 'activate'
      find_item(merchant).update(active?: true)
      flash[:notice] = "#{find_item(merchant).name} is now for sale!"
    end
    redirect_to '/admin/merchant/items'
  end

  def find_merchant_from_item
    item.merchant_id
  end

  def item_check_creation(item)
     if item.save
      flash[:notice] = "Your item was saved!"
      redirect_to '/admin/merchant/items'
    else
      flash[:notice] = item.errors.full_messages.to_sentence
      render :new
    end
  end
end