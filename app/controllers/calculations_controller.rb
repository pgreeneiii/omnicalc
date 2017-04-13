class CalculationsController < ApplicationController

   def word_count
      @text = params[:user_text]
      @special_word = params[:user_word]

      sentence = @text.downcase.split
      search_key = @special_word.downcase.split

      sentence_length = 0
      search_count = 0

      sentence.each do |word|
         sentence_length += word.length

         search_key.each do |key|
            #remove special characters and count search words
            if key == word.gsub(/[^a-z0-9\s]/i, "")
               search_count += 1
            end
         end
      end

      @word_count = @text.split.count

      @character_count_with_spaces = @text.length

      @character_count_without_spaces = sentence_length

      @occurrences = search_count

      render("word_count.html.erb")
   end

   def loan_payment
      @apr = params[:annual_percentage_rate].to_f
      @years = params[:number_of_years].to_i
      @principal = params[:principal_value].to_f

      monthly_interest = (@apr/12.0/100) # convert to monthly percentage rate
      months = (@years*12) # convert to months

      payment = ((@principal*monthly_interest)/(1-(1+monthly_interest)**(-months))) #perform payment calculation

      @monthly_payment = payment

      render("loan_payment.html.erb")
   end

   def time_between
      @starting = Chronic.parse(params[:starting_time])
      @ending = Chronic.parse(params[:ending_time])

      seconds = @ending-@starting
      minutes = (seconds/60.0)
      hours = (minutes/60.0)
      days = (hours/24.0)
      weeks = (days/7.0)
      years = (weeks/52.0)

      @seconds = seconds
      @minutes = minutes
      @hours = hours
      @days = days
      @weeks = weeks
      @years = years

      render("time_between.html.erb")
   end

   def descriptive_statistics
      @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

      # Code for Sorting
      sorted = @numbers.sort

      # Calculate Range
      range = sorted.last-sorted.first

      # Calculate Median
      median_num = ((sorted.count-1)/2)

      if median_num == 0
         median = sorted[0]
      #median calc is different when number of items is even
      elsif median_num > 0 && (sorted.count%2) == 0
         median = (sorted[median_num]+sorted[median_num+1])/2
      #median calc for odd number of items
      else
         median = sorted[median_num]
      end

      # Calculate Sum
      sum = 0

      sorted.each do |num|
         sum += num
      end

      # Calculate Mean
      n = @numbers.count*1.0 #make n floating number
      mean = (sum/n)

      # Calculate Variance
      variance_numerator = 0
      sorted.each do |num|
         variance_numerator += ((num-mean)**2)
      end

      variance = (variance_numerator/n)

      # Calculate Standard Deviation
      sd = (variance)**(1.0/2.0)

      # Calculate Mode
      unique_numbers = []
      sorted.each do |num| #build array of unique numbers
         if unique_numbers == []
            unique_numbers.push(num)
            next

         else
            check = 0
            unique_numbers.each do |test|

               if test == num
                  check = 1
               else
                  next
               end
            end

            if check == 0
               unique_numbers.push(num)
            end
         end
      end

      high_count = 0
      mode = 0
      unique_numbers.each do |num|
         count = 0

         sorted.each do |compare| #count number of occurences
            if num == compare
               count += 1
            end
         end

         if count > high_count #store as mode if current highest count
            high_count = count
            mode = num
         end
      end

      if unique_numbers.count == sorted.count
         mode = 0
      end

      @sorted_numbers = sorted

      @count = @numbers.count

      @minimum = sorted.first

      @maximum = sorted.last

      @range = range

      @median = median

      @sum = sum

      @mean = mean

      @variance = variance

      @standard_deviation = sd

      @mode = mode

      # ================================================================================
      # Your code goes above.
      # ================================================================================

      render("descriptive_statistics.html.erb")
   end
end
