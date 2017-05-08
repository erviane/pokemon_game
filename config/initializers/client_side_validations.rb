# ClientSideValidations Initializer  

require 'client_side_validations/simple_form' if defined?(::SimpleForm)  
require 'client_side_validations/formtastic' if defined?(::Formtastic)  
 if html_tag =~ /^<input/
     %{<div class="field_with_errors">#{html_tag}<label for="#{instance.send(:tag_id)}" class="message">#{instance.error_message.first}</label></div>}.html_safe
   elsif html_tag =~ /^<select/
 %{<div class="field_with_errors" id="select-error">#{html_tag}</div>}.html_safe
   else
     %{<div class="field_with_errors">#{html_tag}</div>}.html_safe
   end
end 

