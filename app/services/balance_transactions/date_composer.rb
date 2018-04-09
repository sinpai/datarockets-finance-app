class BalanceTransactions::DateComposer
  def initialize(params)
    @params = params
  end

  def call
    compose_date
  end

  private

  def compose_date
    return false if @params['date(1i)'].blank?
    @date_array = []
    iterate_over_date_fields
    @date_array.reverse.join('-')
  end

  def iterate_over_date_fields
    (1..3).each do |dt|
      @date_array << @params["date(#{dt}i)"]
    end
  end
end
