class OrderNormalizer
  def initialize(orders)
    @orders = orders
  end

  def normalize
    @orders.map do |order|
      order.order_id = order.order_id.to_i
      order.deal_id = order.deal_id.to_i
      order.email = normalize_email(order.email)
      order.street = normalize_street(order.street)
      order.city = order.city.downcase
      order.state = normalize_state(order.state)
      order
    end
  end

  protected

  def normalize_email(email)
    email_array_splited_by_at = email.split("@")
    index_of_cross = email_array_splited_by_at.first.index("+")
    email_array_splited_by_at.first.delete!('.')
    email_array_splited_by_at[0] = email_array_splited_by_at.first.slice(0..(index_of_cross - 2)) if index_of_cross
    email_array_splited_by_at.join("@")
  end

  def normalize_street(street)
    street.downcase.gsub('st.', 'street').gsub('rd.', 'road')
  end

  def normalize_state(state)
    state.downcase.gsub('il', 'illinois').gsub('ny', 'new york')
  end
end
