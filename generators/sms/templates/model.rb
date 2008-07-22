class <%= class_name %> < ActiveSms::Base
<% actions.each do |action| -%>

  def <%= action %>
    @recipients = ''
    @from       = ''
    @body       = "<%= class_name %>#<%= action %>"
    @options    = {}
  end
<% end -%>
end