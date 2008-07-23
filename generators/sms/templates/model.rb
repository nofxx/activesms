class <%= class_name %> < ActiveSms::Base
<% actions.each do |action| -%>

  def <%= action.split(':')[0] %>
    @delivery   = <%= ":#{action.split(':')[1] == 'human' ? 'gateway' : action.split(':')[1]}"%>
    <%- if action.split(':')[1] == 'email' -%>    
    @carrier    = ''
    <%- end -%>
    @recipients = ''
    @from       = ''
    @body       = "<%= class_name %>#<%= action %>"
    <%- if action.split(':')[1] == 'human' -%>
    @id         = '' 
    @schedule   = ''
    <%- end -%>
    @options    = {}
  end
<% end -%>
end