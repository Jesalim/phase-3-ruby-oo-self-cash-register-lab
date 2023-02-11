class CashRegister
    attr_reader :total, :discount, :transactions
  
    def initialize(discount = nil)
      @total = 0.0
      @discount = discount
      @transactions = []
    end
  
    def add_item(title, price, quantity = 1)
      @total += price * quantity
      @transactions << { title: title, price: price, quantity: quantity }
    end
  
    def apply_discount
      if discount
        @total = @total * (100 - discount) / 100
        "Discount applied. New total: $#{'%.2f' % @total}"
      else
        "No discount to apply."
      end
    end
  
    def items(title = nil, quantity = nil)
      if title && quantity
        @transactions.select { |t| t[:title] == title && t[:quantity] == quantity }
      elsif title
        @transactions.select { |t| t[:title] == title }
      else
        @transactions
      end
    end
  
    def void_last_transaction
      last_transaction = @transactions.pop
      @total -= last_transaction[:price] * last_transaction[:quantity] if last_transaction
      @total = 0.0 if @transactions.empty?
      @total
    end
  end
  