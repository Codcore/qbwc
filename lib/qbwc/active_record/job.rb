class QBWC::ActiveRecord::Job < QBWC::Job
  class QbwcJob < ActiveRecord::Base
    validates :name, :uniqueness => true, :presence => true
  end

  def initialize(name, company, *requests, &block)
    super
    find_job.first_or_create do |job|
      job.company = @company
      job.enabled = @enabled
    end
  end

  def find_job
    QbwcJob.where(:name => name)
  end

  def enabled=(value)
    find_job.update_all(:enabled => value)
  end

  def enabled?
    find_job.where(:enabled => true).exists?
  end

  def next_request
    find_job.pluck(:next_request).first
  end

  def next_request=(value)
    find_job.update_all(:next_request => value)
  end
end
