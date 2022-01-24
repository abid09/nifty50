select*,
avg(open)  over (partition by year(date)
      order by year(date)
      ) as avg_open
     ,avg(close)  over (partition by year(date)
      order by year(date)
      ) as avg_close
      from bhartiartl
      -- Although comparing annual average of a stock price gives us a fair idea of their bullish/bearish nature, its not the most relible method
      ; Select*
             from (select Date, open_price, close_price, 
             avg(close_price) over(order by date rows 50 preceding) as cp50 
		     from bhartiartl
             where year(date) between 2020 and 2021) as t
             where year(date) = 2021;
	-- Moving averages gives us a better understanding of the stock. In this case we have calculated the average close price for 50 days.
    Select *,
		  case when cp50>cp100 then 'bullish' else 'bearish' end as bullish_indicator
           from (select Date, open_price, close_price, avg(close_price) 
           over(order by date rows 50 preceding) as cp50,
           avg(close_price) over(order by date rows 100 preceding) as cp100
           from bhartiartl
            where year(date) between 2011 and 2021) as e
             where year(date) = 2021
	-- Comparing the 50 days average with 100 days average is a more accurate method of finding out the bearish/bullish nature of the stock.
     
      

      