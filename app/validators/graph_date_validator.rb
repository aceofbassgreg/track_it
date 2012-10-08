class GraphDateValidator < ActiveModel::Validator
  def validate(record)
    @start_time = record.start_time
    @end_time = record.end_time
    @days = record.days
        
    record.errors[:blank_submit] = I18n.t "errors.graph.blank_submit" if blank_submit?
    record.errors[:invalid_date] = I18n.t "errors.graph.invalid_date" if !params_nil? and @days.nil? and invalid_date?
  end
  
  def blank_submit?
    true if @start_time == "" or @end_time == ""
  end
  
  def params_nil?
    true if @start_time.nil? and @end_time.nil? and @days.nil?
  end
  
  def invalid_date?
    @start_time.to_time
    @end_time.to_time
    return false
    rescue ArgumentError
    return true
  end
end