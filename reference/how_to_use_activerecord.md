Active Record Model
Let's say you want to attach one or multiple images to a Comment. First, we have to create the Comment model. We'll use the generator to create the resource.

rails g resource comment content:text
# One Attachment
You don't need to use the Blob and Attachment directly. To attach one image to a Comment, use has_one_attached
```
class Comment < ApplicationRecord
  has_one_attached :image
end
```
You don't have to create an Image model. Active Storage uses the Blob and Attachment under the hood to give us comment.image.

Let's take a look at the controller and views.
```
class CommentController < ApplicationController
  def new
    comment = Comment.new
  end

  def create
    comment = Comment.create! params.require(:comment).permit(:content)
    comment.image.attach(params[:comment][:image])
    redirect_to comment    
  end

  def show
    comment = Comment.find(paramd[:id])
  end
end
```
new.html.erb
```
<%= form_with model: @comment, local: true  do |form| %>
  <%= form.text_area :content %><br><br>
  <%= form.file_field :image, %><br>
  <%= form.submit %>
<% end %>
```
show.html.erb
```
<%= image_tag @comment.image %>
```
This is typical code for creating an object. The Active Storage part is comment.image.attach(params[:comment][:images]) on the create action which attaches the file from the image file field to the comment object.

To display the image, we pass @comment.image to image_tag.

# Many Attachments
We only need to modify a few things from the code above to use multiple attachments.

has_many_attached instead of has_one_attached
comment.images instead of comment.image
multiple: true on file_field to allow selection of multiple files
class Comment < ApplicationRecord
  has_many_attached :image
end
class CommentController < ApplicationController
  def new
    comment = Comment.new
  end

  def create
    comment = Comment.create! params.require(:comment).permit(:content)
    comment.images.attach(params[:comment][:images])
    redirect_to comment    
  end

  def show
    comment = Comment.find(paramd[:id])
  end
end
# new.html.erb
<%= form_with model: @comment, local: true  do |form| %>
  <%= form.text_area :content %><br><br>
  <%= form.file_field :images, multiple: true %><br>
  <%= form.submit %>
<% end %>
# show.html.erb
<% @comment.images.each do |image| %>
  <%= image_tag image %> <br />
<% end %>
