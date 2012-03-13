class CustomerPresenter < BasePresenter
  presents :customer
  
  def contact
    if customer.xero_customer.email_address.present? 
      mail_to customer.xero_customer.email_address, "#{customer.xero_customer.first_name} #{customer.xero_customer.last_name}"
    else 
      "#{customer.xero_customer.first_name} #{customer.xero_customer.last_name}" 
    end 
  end

  def phones
    #collect the valid phone numbers
    valid_numbers = customer.xero_customer.phones.reject {|phone| phone.number.blank?}
    content_tag :ul do 
      valid_numbers.collect {|item| (content_tag(:li, item.country_code.to_s + " " + item.area_code.to_s + " " + item.number.to_s))} 
    end
  end

end
