class ItemsController < ApplicationController

  def index
    redirect_to :action => :show
  end

  def show
    @items = Item.find(:all)
    @item = Item.find(:first)
    @mod_item = Item.new
    # select according to your choice...
    #this item will be selected node by default in the tree when it will first be loaded.
  end

  def display_clicked_item
    # this action will handle the two way syncronization...all the tree nodes(items) will be linked
    # to this action to show the detailed item on the left of the tree when the item is clicked
    # from the tree
    #puts "========== in display_clicked_item, params=#{params.inspect}============="
    if request.xhr?
      @item = Item.find(params[:id]) rescue nil
      if @item
        # the code below will render all your RJS code inline and
        # u need not to have any .rjs file, isnt this interesting
        render :update do |page|
          page.hide "selected_item"
          page.replace_html "selected_item", :partial=>"items/item", :object=>@item
          page.visual_effect 'toggle_appear', "selected_item"
        end
      else
        return render :nothing => true
      end
    end
  end

  def sort_ajax_tree
    #{"authenticity_token"=>"sXW9LT/B7wMrtucIy/eDEkC0Of0B7oIGn7PstWkU1PQ=",
    #"action"=>"sort_ajax_tree", "id"=>"7_tree_div", "parent_id"=>"13", "controller"=>"items", "_"=>""}
    #puts "========== in sort_ajax_tree, params=#{params.inspect}, parent.name=#{Item.find(params[:parent_id]).name}============="
    if request.xhr?
      if @item = Item.find(params[:id].split("_").first) rescue nil
        parent_item = Item.find(params[:parent_id])
        render :update do |page|
          if @item.parent_id == 0
            page.alert("Cannot change root")
          end
          @item.parent_id = parent_item.id
          @item.save
          @items=Item.find(:all)
          page.replace_html "ajaxtree", :partial=>"items/ajax_tree", :object=>[@item,@items]
          page.hide "selected_item"
          page.replace_html "selected_item", :partial=>"items/item", :object=>@item
          page.visual_effect 'toggle_appear', "selected_item"
        end
      else
        return render :nothing => true
      end
    end
  end

  def update_item
    #{"new_name"=>"item2.3x", "action"=>"update_item", "controller"=>"items", "item_id"=>"8"}
    item_id = params['item_id']
    new_name = params['new_name']
    if @item = Item.find(item_id) rescue nil
      @item.update_attributes(:name => new_name)
    end
    if request.xhr?
      render :update do |page|
        page.alert("You have successfully updated name to #{new_name}")
      end
    else
      render :nothing => true
    end
  end

end
