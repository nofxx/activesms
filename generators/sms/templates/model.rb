class <%= class_name %> < ActiveSms::Base
<% actions.each do |action| -%>

  def <%= action %>
    @recipients = ''
    @from       = ''
    @body       = "<%= class_name %>#<%= action %>"
    @id         = '' 
    @schedule   = "dd/mm/aaaa hh:mm:ss"
    @options    = {}
  end
<% end -%>
end