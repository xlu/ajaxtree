class CreateItems < ActiveRecord::Migration
  def self.up
      create_table "items", :force => true do |t|
         t.column "name", :string
         t.column "created_at", :datetime
         t.column "parent_id", :integer, :default => 0, :null => false
         t.column "abs_pos", :integer, :default => 0, :null => false
         t.column "rel_pos", :integer, :default => 0, :null => false
      end
      %w(item1 item2 item3 item4 item5).each do |name|
            parent = Item.new(:name=>name)
            parent.save
            Item.create(:name=>name+".1", :parent_id=>parent.id)
            Item.create(:name=>name+".2", :parent_id=>parent.id)
            Item.create(:name=>name+".3", :parent_id=>parent.id)
       end
 end

 def self.down
   drop_table :items
 end

end
