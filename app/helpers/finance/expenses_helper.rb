module Finance::ExpensesHelper
  def category_icon(category)
    # Define your icon logic here
    # For example:
    case category
    when "food"
      "food-icon"
    when "transport"
      "transport-icon"
      # etc...
    end
  end
end
