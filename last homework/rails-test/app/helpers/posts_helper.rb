module PostsHelper
  def action_links
    link_to("Edit", edit_post_path(@post)) + " | " +
      link_to("Back", posts_path)
  end
end
