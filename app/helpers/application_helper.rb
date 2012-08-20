module ApplicationHelper

  def get_tree_data(tree, parent_id)
    ret = "<div class='outer_tree_element' >"
    #top_level_rel_pos = 0
    tree.each do |node|
=begin
      if (node.parent_id == 0) && (node.rel_pos == 0)
        debugger
        node.rel_pos += top_level_rel_pos
        node.save!
        top_level_rel_pos += 1
      end
=end
      if node.parent_id == parent_id
        node.style = (@ancestors and @ancestors.include?(node.id))? 'display:inline' : 'display:none'
        display_expanded = (@ancestors and @ancestors.include?(node.id))? 'inline' : 'none'
        display_collapsed = (@ancestors and @ancestors.include?(node.id))? 'none' : 'inline'
        ret += "<div class='inner_tree_element' id='#{node.id}_tree_div'>"
        if node.has_children?
          ret += "<img id='#{node.id.to_s}expanded' src='/images/expanded.gif' onclick='javascript: return toggleMyTree(\"#{node.id}\"); ' style='display:#{display_expanded}; cursor:pointer;'  />  "
          ret += "<img style='display:#{display_collapsed}; cursor:pointer;'  id='#{node.id.to_s}collapsed' src='/images/collapsed.gif' onclick='javascript: return toggleMyTree(\"#{node.id.to_s}\"); '  />  "
        end

        #ret += " <img src='/images/drag.gif' style='cursor:move' id='#{node.id}_drag_image' align='absmiddle' class='drag_image' /> "
        # xlu mod
        unless parent_id == 0
          ret += " <img src='/images/drag.gif' style='cursor:move' id='#{node.id}_drag_image' align='absmiddle' class='drag_image' /> "
        end
        #ret += "<span> (#{node.abs_pos}, #{node.rel_pos}) </span>"
        ret += "<span id='#{node.id}_tree_item'>"
        ret += "<input class='item' id=\"item_" + node.id.to_s + "\" value=\"#{node.name}\" disabled=\"disabled\" name=\"";
        ret += yield node
        ret += "\"/>"
        ret += "<button class=\"edit_item\" id=\"edit_item_" + node.id.to_s + "\" class=\"btn btn-primary\" style=\"margin-top: -10px\">Edit</button>"
        ret += "</span>"
        #orig: ret += "<span id='#{node.id}children' style='#{node.style}' >"
        ret += "<span id='#{node.id}children' style='display: block;' >"  # xlu modified to display all children
        # xlu node sort by name. will cause infinite loop
        sorted_children = node.children.sort_by{|e| e[:name]}
=begin
        rel_pos = 0
        sorted_children.each do |child|
          child.rel_pos += rel_pos  if  child.rel_pos == 0
          child.save!
          rel_pos += 1
        end
=end
        ret += get_tree_data(sorted_children, node.id){|n| yield n}
        #ret += get_tree_data(node.children, node.id){|n| yield n}
        ret += "</span>"
        ret += "</div>"
      end
    end
    ret += "</div>"
    return ret
  end
end
