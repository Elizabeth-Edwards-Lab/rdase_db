



# How to calculate identity
Here identity(A,B)=100% (5 identical nucleotides / min(length(A),length(B)))
Ref: https://www.quora.com/What-is-the-difference-between-the-percentage-similarity-and-the-percentage-identity-of-two-sequences


```
<%= form_with url:'protein', method: :get do |f| %>
  <% @identity_groups.each do |group_number| %>
    <%= hidden_field_tag(:group, group_number) %>
    <%= f.submit "#{group_number}", disabled: false, :id => 'group-click-button', formtarget: "_blank" %>
    &nbsp;
  <% end %>
<% end %>
```