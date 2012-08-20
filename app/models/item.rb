class Item < ActiveRecord::Base

  acts_as_tree
  validates_presence_of :name
  attr_accessor :style

  def self.roots
    self.find(:all, :conditions=>["parent_id = ?", 0])
  end

  def level
    self.ancestors.size
  end

  #xlu add
  def has_children?
    items = Item.find(:all, :conditions=>["parent_id = ?", self.id])
    if items && items.size > 0
      return true
    else
      return false
    end
  end
end
