class ClockAbleValidator < ActiveModel::Validator

  def validate(record)
    time_tracker = time_tracker(record)
    error_location = "activerecord.errors.models.activity.attributes.base"
    record.errors[:clock_in_able]     =         I18n.t "#{error_location}.clock_in_able" if !clock_in_able?(record,time_tracker)
    record.errors[:clock_out_able]    =         I18n.t "#{error_location}.clock_out_able" if !clock_out_able?(record,time_tracker)
    record.errors[:either_present]    =         I18n.t "#{error_location}.either_present" if either_present?(record)  
    record.errors[:present]           =         I18n.t "#{error_location}.present" if !present?(record.date)
    record.errors[:present]           =         I18n.t "#{error_location}.present" if !present?(record.activity_id)
  end
  
  def clock_in_able?(record,time_tracker)
    return true if time_tracker.nil?
    return true if !time_tracker.clock_out.nil?
    return true if time_tracker.id == record.id
    return false
  end
  
  def clock_out_able?(record,time_tracker)
    return false if record.id == time_tracker.id and !time_tracker.clock_out.nil?
    return true if !record.clock_in.nil? 
    return false
  end
  
  def time_tracker(record)
    TimeTracker.find_all_by_activity_id(record.activity_id).last || TimeTracker.new
  end
  
  def either_present?(record)
    return true if record.clock_in.nil? and record.clock_out.nil?
  end
  
  def present?(record_attribute)
    return true if !record_attribute.nil?
  end
end