def stock_picker(price_per_day)
  best_margin = 0
  day_to_buy = 0
  day_to_sell = 0
  price_per_day.each_with_index do |buy_price, buy_day|
    price_per_day.each_with_index do |sell_price, sell_day|
      if sell_day > buy_day
        margin = sell_price.to_i - buy_price.to_i 		
      end
      if margin.to_i > best_margin.to_i	
        day_to_buy = buy_day
        day_to_sell = sell_day	
        best_margin = margin 
      end
    end
  end	

  print "You should buy stock on day #{day_to_buy} and sell on #{day_to_sell} for a total profit of #{best_margin}$ !"
  end

stock_picker([17,23,65,19,15,88,60,1,120])
