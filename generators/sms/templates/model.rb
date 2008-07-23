class <%= class_name %> < ActiveSms::Base
<% actions.each do |action| -%>

  def <%= action.split(':')[0] %>
    @delivery   = ''<%- if action.split(':')[1] == 'email' -%>    
    @carrier    = ''
<%- end -%>
    @recipients = ''
    @from       = ''
    @body       = "<%= class_name %>#<%= action %>"
    @id         = '' 
    @schedule   = ''
    @options    = {}
  end
<% end -%>
end